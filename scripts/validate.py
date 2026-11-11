#!/usr/bin/env python3
"""Validate the distributable repository without third-party dependencies."""
# SPDX-License-Identifier: MIT
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path, PurePosixPath
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
REQUIRED = (
    "README.md", "LICENSE", "CITATION.cff", "docs/PUBLISHING.md",
    "docs/PAPER_FACTS.md", "docs/TECHNICAL_GUIDE.md", "docs/VALIDATION.md",
    "docs/PROVENANCE.md", "references/paper.bib", "metadata/file-manifest.json",
    "LICENSES/CERN-OHL-P-2.0.txt", "LICENSES/MIT.txt", "LICENSES/CC-BY-4.0.txt",
    "Publish-to-GitHub.cmd", "scripts/publish.ps1", "scripts/make_release.py",
)
HARDWARE_EXTENSIONS = {".sldasm", ".sldprt", ".slddrw", ".step", ".stp", ".pdf"}
LINK = re.compile(r"!?\[[^\]\n]*\]\((?:<([^>]+)>|([^\s)]+))(?:\s+\"[^\"]*\")?\)")


def check(root: Path = ROOT) -> list[str]:
    errors: list[str] = []
    for name in REQUIRED:
        if not (root / name).is_file():
            errors.append(f"Missing required file: {name}")
    manifest_path = root / "metadata/file-manifest.json"
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8-sig"))
    except (OSError, ValueError) as exc:
        return errors + [f"Cannot read hardware manifest: {exc}"]
    if manifest.get("schema_version") != 1:
        errors.append("Manifest schema_version must be 1")
    entries = manifest.get("files")
    if not isinstance(entries, list) or not entries:
        return errors + ["Manifest files must be a nonempty list"]
    recorded: set[str] = set()
    for entry in entries:
        if not isinstance(entry, dict):
            errors.append("Manifest contains a non-object entry")
            continue
        name = entry.get("path", "")
        posix = PurePosixPath(name) if isinstance(name, str) else PurePosixPath()
        if (not isinstance(name, str) or "\\" in name or posix.is_absolute()
                or ".." in posix.parts or not name.startswith("hardware/")):
            errors.append(f"Unsafe hardware path: {name!r}")
            continue
        if name in recorded:
            errors.append(f"Duplicate manifest entry: {name}")
        recorded.add(name)
        item = root.joinpath(*posix.parts)
        if not item.resolve().is_relative_to((root / "hardware").resolve()):
            errors.append(f"Hardware path escapes its directory: {name}")
            continue
        if not item.is_file() or item.is_symlink():
            errors.append(f"Missing hardware file or unsupported symlink: {name}")
            continue
        if item.stat().st_size != entry.get("size_bytes"):
            errors.append(f"Byte-size mismatch: {name}")
        digest = entry.get("sha256", "")
        if not isinstance(digest, str) or not re.fullmatch(r"[0-9a-f]{64}", digest):
            errors.append(f"Invalid SHA-256: {name}")
        elif hashlib.sha256(item.read_bytes()).hexdigest() != digest:
            errors.append(f"SHA-256 mismatch: {name}")
    actual = {p.relative_to(root).as_posix() for p in (root / "hardware").rglob("*")
              if p.is_file() and p.suffix.lower() in HARDWARE_EXTENSIONS}
    for name in sorted(actual - recorded):
        errors.append(f"Hardware file missing from manifest: {name}")
    for name in sorted(recorded - actual):
        errors.append(f"Manifest entry is not a supported hardware file: {name}")
    for page in root.rglob("*.md"):
        if any(part in {".git", "__pycache__", ".venv"} for part in page.relative_to(root).parts):
            continue
        content = page.read_text(encoding="utf-8-sig")
        # Ignore illustrative commands in code fences. Check portable file targets;
        # generated heading anchors are left to the Markdown renderer.
        content = re.sub(r"^```.*?^```[^\n]*", "", content, flags=re.M | re.S)
        for match in LINK.finditer(content):
            target = match.group(1) or match.group(2)
            parsed = urlsplit(target)
            if parsed.scheme or parsed.netloc or not parsed.path:
                continue
            local = (page.parent / unquote(parsed.path)).resolve()
            if not local.is_relative_to(root.resolve()):
                errors.append(f"Nonportable link outside repository in {page.relative_to(root)}: {target}")
            elif not local.exists():
                errors.append(f"Broken local link in {page.relative_to(root)}: {target}")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT, help="Repository directory")
    args = parser.parse_args()
    errors = check(args.root.resolve())
    if errors:
        print("Repository validation FAILED:", file=sys.stderr)
        for error in errors:
            print(f"  - {error}", file=sys.stderr)
        return 1
    count = len(json.loads((args.root / "metadata/file-manifest.json").read_text(encoding="utf-8-sig"))["files"])
    print(f"Repository validation PASSED: {count} hardware files verified; required files and local Markdown links checked.")
    print("This validates packaging integrity, not CAD rebuilds, engineering dimensions, or magnetic performance.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
