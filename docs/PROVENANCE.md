# Provenance and release scope

## Source snapshot

The hardware payload was supplied in the local folder named `KB_Standard_A5磁组20261110`. This repository was prepared on **2026-11-11**. The folder label is preserved as a source identifier; it is not treated as a formal engineering release number or proof of the design's first creation date.

Root-level native SolidWorks files are copied to `hardware/solidworks/`. Files from the original `图纸` directory are copied to `hardware/drawings/`. Original names and bytes are retained. See [FILE_INDEX.md](FILE_INDEX.md) and the [manifest](../metadata/file-manifest.json) for the exact mapping and checksums. The English descriptions in the index are explanatory labels, not replacement filenames.

## Relationship to the article

The research reference is *A Compact Magnet System for the Tsinghua Tabletop Kibble Balance*, by Yongchao Ma, Nanjia Li, Weibo Liu, Kang Ma, Wei Zhao, Songling Huang, and Shisong Li, [arXiv:2409.03334v1](https://arxiv.org/abs/2409.03334v1), submitted 2024-09-05. The documentation pins this version rather than silently tracking a future revision.

The article provides scientific context. The supplied folder is a later design-file snapshot. Their exact geometrical and revision equivalence has not been established. Article measurements belong to the research prototypes described there. They are not measurements of this repository's CAD files or of a future replica.

## What was added during packaging

The repository adds English explanatory documentation, an original SVG overview, file inventories, cryptographic checksums, citation files, a licensing map, contribution templates, local verification/packaging scripts, and GitHub publication workflows. These additions do not change the original CAD or drawing payload.

The [technical guide](TECHNICAL_GUIDE.md) and [validation plan](VALIDATION.md) contain independent engineering guidance. They should be reviewed and adapted by the building team. They do not add missing manufacturing specifications to the original drawings.

## Evidence boundaries

No native SolidWorks rebuild, neutral-CAD round-trip, complete assembly BOM extraction, new finite-element model, new fabrication, or new magnetic measurement is claimed. A filename suggesting a particular material or version is not a substitute for a verified CAD property or controlled drawing. Conflicting or incomplete information should be recorded as an issue tied to a commit.

The source set is preserved intact, including similarly named parts from different directories and standard-fastener files. Their placement reflects the supplied source, rather than a claim that every file is an independently controlled revision of a single master design.

## Article and third-party rights

The article and its figures are linked at their original source. No article PDF, extracted figure, or copied article text is included. Repository licenses apply to their stated scopes and do not relicense external publications, standards, software, trademarks, or material outside the publisher's authority. Publication of a derivative does not imply endorsement by Tsinghua University or the article's authors.
