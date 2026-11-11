# Publish to GitHub

The display title is **Tsinghua KB Magnet Open Source**. GitHub repository names use a URL-friendly slug, so the default repository is `Tsinghua-KB-Magnet-Open-Source` in the account used for sign-in.

## One-click publication on Windows

1. Extract the entire project ZIP, retaining its folders and original filenames.
2. Double-click [`Publish-to-GitHub.cmd`](../Publish-to-GitHub.cmd).
3. If Git or GitHub CLI is missing, the launcher installs it through Windows Package Manager (`winget`). Complete any Windows installation prompts.
4. If necessary, complete the GitHub sign-in in your browser, including permission to upload the included validation workflow. The script then creates a **public** repository and uploads this project.

The launcher uses PowerShell 7 when available and otherwise Windows PowerShell 5.1. It checks the hardware manifest and SHA-256 checksums before any installation, authentication, or publication. Python is not required for this publication route. Nothing is published merely by extracting or reading the package.

If `winget` is unavailable, install [Git for Windows](https://git-scm.com/download/win) and [GitHub CLI](https://cli.github.com/), reopen the launcher, and continue. Organization publication requires repository-creation permission in that organization.

## Preview and options

Run these commands from the project directory. The preview performs local integrity checks and reports the destination without changing files, starting sign-in, installing software, or contacting GitHub.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\publish.ps1 -DryRun
```

Publish to an organization, create a private repository, or choose a different slug:

```powershell
.\scripts\publish.ps1 -Owner MyResearchOrganization -InstallPrerequisites
.\scripts\publish.ps1 -Private -InstallPrerequisites
.\scripts\publish.ps1 -RepoName Tsinghua-KB-Magnet-Replica -InstallPrerequisites
```

`-Private` sets visibility only when creating a new repository. Re-running the script does not change the visibility of an existing repository.

## Existing repositories and reruns

The first run initializes a local `main` branch, commits the package, creates the remote repository, and pushes the branch. Git identity is taken from existing configuration; if absent, the authenticated GitHub account and its GitHub no-reply address are configured for this repository only.

For a subsequent run, the script verifies that `origin` points to the requested GitHub repository, commits local changes, and pushes the current branch. It does not force-push, replace remotes, delete repositories, or rewrite commits. A repository that already exists on GitHub is reused only when this local project already has a matching `origin`.

If publication stops after the repository is created, retain the local `.git` directory and rerun the same command. If a push is rejected because the remote contains additional commits, reconcile the changes using normal Git tools before rerunning. A network or access failure does not authorize replacing the remote repository.

## Package checks and downloadable ZIP

With Python 3.9 or newer installed, run:

```powershell
python scripts/validate.py
python scripts/make_release.py
```

The validator checks required files, the complete hardware inventory, byte sizes, SHA-256 values, and local Markdown file links. The ZIP builder validates first and creates a sorted archive with fixed timestamps beside the repository, together with a `.zip.sha256` file. Git history, caches, temporary files, and previous ZIPs are excluded. Rebuilding unchanged contents with the same Python/zlib runtime produces the same archive bytes.

These checks validate distribution integrity. They do not open or rebuild SolidWorks models or verify dimensions, load capacity, assembly safety, or magnetic performance; see [validation](VALIDATION.md).

GitHub Actions repeats the Python checks after pushes and pull requests. Its workflow can also be started manually under **Actions > Validate open hardware package > Run workflow**. Publishing creates a repository; a tagged GitHub Release can be added later using the validated ZIP.

## Tool references

- [GitHub CLI: create a repository](https://cli.github.com/manual/gh_repo_create)
- [GitHub CLI: browser authentication](https://cli.github.com/manual/gh_auth_login)
- [Windows Package Manager: install command](https://learn.microsoft.com/en-us/windows/package-manager/winget/install)
- [GitHub Actions checkout](https://github.com/actions/checkout) and [Python setup](https://github.com/actions/setup-python)
