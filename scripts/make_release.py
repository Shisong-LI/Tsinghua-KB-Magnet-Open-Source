#!/usr/bin/env python3
"""Build a reproducible, validated source ZIP outside the repository."""
# SPDX-License-Identifier: MIT
from __future__ import annotations

import argparse
import hashlib
import sys
import zipfile
from pathlib import Path

from validate import ROOT, check

EXCLUDED_DIRS = {".git", ".venv", "__pycache__", ".pytest_cache", ".idea", ".vscode"}
EXCLUDED_SUFFIXES = {".pyc", ".pyo", ".zip", ".tmp", ".bak"}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=ROOT.parent / f"{ROOT.name}.zip")
    args = parser.parse_args()
    output = args.output.resolve()
    if output.is_relative_to(ROOT):
        parser.error("The ZIP must be outside the repository to avoid self-inclusion.")
    errors = check()
    if errors:
        print("Release not built: " + "; ".join(errors), file=sys.stderr)
        return 1
    files = sorted((p for p in ROOT.rglob("*") if p.is_file()
                    and not any(part in EXCLUDED_DIRS for part in p.relative_to(ROOT).parts)
                    and p.suffix.lower() not in EXCLUDED_SUFFIXES
                    and not p.name.startswith("~$")
                    and p.name not in {".DS_Store", "Thumbs.db"}),
                   key=lambda p: p.relative_to(ROOT).as_posix())
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_name(output.name + ".tmp")
    try:
        with zipfile.ZipFile(temporary, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
            for item in files:
                if item.is_symlink():
                    raise ValueError(f"Symlinks are not distributable: {item}")
                info = zipfile.ZipInfo(f"{ROOT.name}/{item.relative_to(ROOT).as_posix()}", (1980, 1, 1, 0, 0, 0))
                info.create_system = 3
                info.external_attr = 0o100644 << 16
                info.compress_type = zipfile.ZIP_DEFLATED
                archive.writestr(info, item.read_bytes(), compresslevel=9)
        temporary.replace(output)
    finally:
        if temporary.exists():
            temporary.unlink()
    digest = hashlib.sha256(output.read_bytes()).hexdigest()
    output.with_suffix(output.suffix + ".sha256").write_text(f"{digest}  {output.name}\n", encoding="ascii")
    print(f"Created {output} ({len(files)} files)")
    print(f"SHA-256: {digest}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
