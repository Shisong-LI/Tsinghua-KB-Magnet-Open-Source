# SPDX-License-Identifier: MIT
<#
.SYNOPSIS
Validate and publish this project to GitHub, with a mutation-free dry run.
#>
[CmdletBinding()]
param(
    [ValidatePattern('^[A-Za-z0-9_.-]+$')]
    [string]$RepoName = 'Tsinghua-KB-Magnet-Open-Source',
    [ValidatePattern('^[A-Za-z0-9-]*$')]
    [string]$Owner = '',
    [switch]$Private,
    [switch]$DryRun,
    [switch]$InstallPrerequisites
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))

function Invoke-Checked {
    param([string]$Program, [string[]]$Arguments)
    & $Program @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$Program failed (exit $LASTEXITCODE)." }
}

function Invoke-Probe {
    param([string]$Program, [string[]]$Arguments)
    # Windows PowerShell 5.1 represents native stderr as error records. A missing
    # remote or signed-out account is an expected probe result, not an exception.
    $SavedPreference = $ErrorActionPreference
    try {
        $ErrorActionPreference = 'Continue'
        $Output = @(& $Program @Arguments 2>$null)
        return [PSCustomObject]@{ Code = $LASTEXITCODE; Output = $Output }
    } finally { $ErrorActionPreference = $SavedPreference }
}

function Find-Program {
    param([string]$Name, [string[]]$Candidates)
    $Found = Get-Command $Name -ErrorAction SilentlyContinue
    if ($Found) { return $Found.Source }
    foreach ($Candidate in $Candidates) {
        if ($Candidate -and (Test-Path -LiteralPath $Candidate -PathType Leaf)) { return $Candidate }
    }
    return $null
}

function Assert-Package {
    $Required = @('README.md', 'LICENSE', 'CITATION.cff', 'metadata/file-manifest.json',
        'docs/PUBLISHING.md', 'docs/PAPER_FACTS.md', 'docs/TECHNICAL_GUIDE.md',
        'docs/VALIDATION.md', 'docs/PROVENANCE.md', 'references/paper.bib',
        'LICENSES/CERN-OHL-P-2.0.txt', 'LICENSES/MIT.txt', 'LICENSES/CC-BY-4.0.txt')
    foreach ($Name in $Required) {
        if (-not (Test-Path -LiteralPath (Join-Path $ProjectRoot $Name) -PathType Leaf)) {
            throw "Required file is missing: $Name"
        }
    }
    $Manifest = Get-Content -LiteralPath (Join-Path $ProjectRoot 'metadata/file-manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($Manifest.schema_version -ne 1 -or @($Manifest.files).Count -eq 0) { throw 'Invalid hardware manifest.' }
    $Seen = @{}
    foreach ($Entry in $Manifest.files) {
        $Name = [string]$Entry.path
        if (-not $Name.StartsWith('hardware/') -or $Name.Contains('\') -or $Name.Split('/') -contains '..' -or [IO.Path]::IsPathRooted($Name)) {
            throw "Unsafe hardware path: $Name"
        }
        if ($Seen.ContainsKey($Name)) { throw "Duplicate hardware path: $Name" }
        $Seen[$Name] = $true
        $FilePath = Join-Path $ProjectRoot $Name
        $HardwarePrefix = [IO.Path]::GetFullPath((Join-Path $ProjectRoot 'hardware')) + [IO.Path]::DirectorySeparatorChar
        if (-not [IO.Path]::GetFullPath($FilePath).StartsWith($HardwarePrefix, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Hardware path escapes its directory: $Name"
        }
        if (-not (Test-Path -LiteralPath $FilePath -PathType Leaf)) { throw "Hardware file is missing: $Name" }
        if ((Get-Item -LiteralPath $FilePath).Length -ne $Entry.size_bytes) { throw "File size changed: $Name" }
        if ([string]$Entry.sha256 -cnotmatch '^[0-9a-f]{64}$') { throw "Invalid SHA-256: $Name" }
        if ((Get-FileHash -LiteralPath $FilePath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $Entry.sha256) {
            throw "Hardware checksum changed: $Name. Review the change and update the manifest deliberately."
        }
    }
    $Actual = @(Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'hardware') -File -Recurse |
        Where-Object { $_.Extension.ToLowerInvariant() -in @('.sldasm', '.sldprt', '.slddrw', '.step', '.stp', '.pdf') })
    foreach ($Item in $Actual) {
        $RelativeName = $Item.FullName.Substring($ProjectRoot.Length + 1).Replace('\', '/')
        if (-not $Seen.ContainsKey($RelativeName)) { throw "Hardware file is absent from manifest: $RelativeName" }
    }
    if ($Actual.Count -ne $Seen.Count) { throw 'Manifest hardware count does not match the repository.' }
    Write-Host "Package integrity passed: $($Seen.Count) original hardware files verified."
}

function Get-Origin {
    param([string]$GitPath)
    $Probe = Invoke-Probe $GitPath @('-C', $ProjectRoot, 'remote', 'get-url', 'origin')
    if ($Probe.Code -eq 0) { return ([string]($Probe.Output -join '')).Trim() }
    return ''
}

function Assert-Origin {
    param([string]$Remote, [string]$FullName)
    $Clean = $Remote.TrimEnd('/') -replace '\.git$', ''
    if ($Clean -ine "https://github.com/$FullName" -and
        $Clean -ine "git@github.com:$FullName" -and
        $Clean -ine "ssh://git@github.com/$FullName") {
        throw "origin does not match github.com/$FullName. Existing remotes are never replaced."
    }
}

try {
    Assert-Package
    $Visibility = if ($Private) { 'private' } else { 'public' }
    if ($DryRun) {
        Write-Host 'DRY RUN passed. No files, Git history, credentials, installations, or GitHub resources were changed.'
        Write-Host "Planned repository: $RepoName ($Visibility), owner: $(if ($Owner) { $Owner } else { 'authenticated GitHub account' })."
        Write-Host 'Actual publication requires Git and GitHub CLI; the launcher can install missing tools with winget.'
        exit 0
    }

    $GitCandidates = @("$env:ProgramFiles\Git\cmd\git.exe", "$env:LOCALAPPDATA\Programs\Git\cmd\git.exe")
    $GhCandidates = @("$env:ProgramFiles\GitHub CLI\gh.exe", "$env:LOCALAPPDATA\Programs\GitHub CLI\gh.exe")
    $GitPath = Find-Program 'git.exe' $GitCandidates
    $GhPath = Find-Program 'gh.exe' $GhCandidates
    if ((-not $GitPath -or -not $GhPath) -and $InstallPrerequisites) {
        $Winget = Get-Command winget.exe -ErrorAction SilentlyContinue
        if (-not $Winget) {
            throw 'winget is unavailable. Install Git from https://git-scm.com/download/win and GitHub CLI from https://cli.github.com/, then reopen this launcher.'
        }
        if (-not $GitPath) {
            Write-Host 'Installing Git using Windows Package Manager...'
            Invoke-Checked $Winget.Source @('install', '--id', 'Git.Git', '--exact', '--source', 'winget', '--accept-source-agreements', '--accept-package-agreements', '--silent', '--disable-interactivity')
        }
        if (-not $GhPath) {
            Write-Host 'Installing GitHub CLI using Windows Package Manager...'
            Invoke-Checked $Winget.Source @('install', '--id', 'GitHub.cli', '--exact', '--source', 'winget', '--accept-source-agreements', '--accept-package-agreements', '--silent', '--disable-interactivity')
        }
        $env:PATH = [Environment]::GetEnvironmentVariable('PATH', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('PATH', 'User') + ';' + $env:PATH
        $GitPath = Find-Program 'git.exe' $GitCandidates
        $GhPath = Find-Program 'gh.exe' $GhCandidates
    }
    if (-not $GitPath -or -not $GhPath) {
        throw 'Git and GitHub CLI are required. Use Publish-to-GitHub.cmd for installation via winget, or install https://git-scm.com/download/win and https://cli.github.com/.'
    }
    # Make the resolved tools available to GitHub CLI and the per-command credential helper.
    $env:PATH = (Split-Path -Parent $GitPath) + ';' + (Split-Path -Parent $GhPath) + ';' + $env:PATH
    $env:GH_HOST = 'github.com'
    $Authentication = Invoke-Probe $GhPath @('auth', 'status', '--hostname', 'github.com')
    if ($Authentication.Code -ne 0) {
        Write-Host 'Complete GitHub sign-in in the browser when prompted.'
        Invoke-Checked $GhPath @('auth', 'login', '--hostname', 'github.com', '--git-protocol', 'https', '--web', '--scopes', 'workflow')
    }
    # Uploading .github/workflows requires the OAuth workflow scope. Inspect only
    # response headers; tokens are never requested, printed, or written here.
    $PermissionProbe = Invoke-Probe $GhPath @('api', '--hostname', 'github.com', '--include', '--silent', 'user')
    $ScopeHeader = @($PermissionProbe.Output | Where-Object { $_ -imatch '^X-OAuth-Scopes:' })
    if ($PermissionProbe.Code -eq 0 -and $ScopeHeader.Count -gt 0 -and $ScopeHeader[0] -notmatch '(?i)(^|[:, ]+)workflow($|[, ])') {
        if ($env:GH_TOKEN -or $env:GITHUB_TOKEN) {
            throw 'The environment-provided GitHub token lacks workflow permission. Add the workflow scope or use a token permitted to write workflows, then rerun.'
        }
        Write-Host 'GitHub permission is required to upload the included validation workflow; complete the browser authorization.'
        Invoke-Checked $GhPath @('auth', 'refresh', '--hostname', 'github.com', '--scopes', 'workflow')
    }
    $AccountRaw = & $GhPath api --hostname github.com user
    if ($LASTEXITCODE -ne 0) { throw 'Unable to read the authenticated GitHub account.' }
    $Account = $AccountRaw | ConvertFrom-Json
    if (-not $Owner) { $Owner = [string]$Account.login }
    $FullName = "$Owner/$RepoName"
    $HasLocalGit = Test-Path -LiteralPath (Join-Path $ProjectRoot '.git')
    $Origin = if ($HasLocalGit) { Get-Origin $GitPath } else { '' }
    if ($Origin) { Assert-Origin $Origin $FullName }
    $Existing = Invoke-Probe $GhPath @('repo', 'view', $FullName, '--json', 'nameWithOwner,url')
    $RemoteExists = $Existing.Code -eq 0
    if ($RemoteExists -and -not $Origin) {
        throw "GitHub repository $FullName already exists but this project has no matching origin. No existing repository was changed. Clone that repository separately or choose -RepoName."
    }
    if (-not $RemoteExists -and $Origin) {
        throw "Unable to access the existing origin repository $FullName. Check your network and permissions."
    }
    if (-not $HasLocalGit) {
        Invoke-Checked $GitPath @('-C', $ProjectRoot, 'init', '--initial-branch=main')
    }
    $Top = & $GitPath -C $ProjectRoot rev-parse --show-toplevel
    if ($LASTEXITCODE -ne 0 -or [IO.Path]::GetFullPath([string]$Top) -ine $ProjectRoot) {
        throw 'The project must be the root of its own Git repository.'
    }
    $Branch = & $GitPath -C $ProjectRoot symbolic-ref --quiet --short HEAD
    if ($LASTEXITCODE -ne 0) { throw 'Detached HEAD: switch to the branch you intend to publish and run again.' }
    $GitName = & $GitPath -C $ProjectRoot config user.name
    if (-not $GitName) { Invoke-Checked $GitPath @('-C', $ProjectRoot, 'config', '--local', 'user.name', [string]$Account.login) }
    $GitEmail = & $GitPath -C $ProjectRoot config user.email
    if (-not $GitEmail) {
        $NoReply = '{0}+{1}@users.noreply.github.com' -f $Account.id, $Account.login
        Invoke-Checked $GitPath @('-C', $ProjectRoot, 'config', '--local', 'user.email', $NoReply)
    }
    Invoke-Checked $GitPath @('-C', $ProjectRoot, 'add', '--all')
    & $GitPath -C $ProjectRoot diff --cached --quiet
    $DiffStatus = $LASTEXITCODE
    if ($DiffStatus -eq 1) {
        Invoke-Checked $GitPath @('-C', $ProjectRoot, 'commit', '-m', 'Publish Tsinghua KB magnet open hardware and documentation')
    } elseif ($DiffStatus -ne 0) { throw 'Unable to inspect staged changes.' }
    if (-not $RemoteExists) {
        Write-Host "Creating $Visibility repository github.com/$FullName..."
        $VisibilityFlag = if ($Private) { '--private' } else { '--public' }
        Invoke-Checked $GhPath @('repo', 'create', $FullName, $VisibilityFlag, '--description',
            'Tsinghua KB Magnet Open Source: permanent-magnet CAD, engineering drawings, and research documentation.',
            '--source', $ProjectRoot, '--remote', 'origin')
    }
    # Use the CLI credential helper for this push only; do not change global Git configuration.
    Invoke-Checked $GitPath @('-C', $ProjectRoot, '-c', 'credential.helper=', '-c',
        'credential.helper=!gh auth git-credential', 'push', '--set-upstream', 'origin', [string]$Branch)
    Write-Host "Published successfully: https://github.com/$FullName"
    Write-Host 'GitHub Actions will validate the uploaded package. The workflow result is visible on the Actions tab.'
} catch {
    Write-Host "Publication stopped: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
