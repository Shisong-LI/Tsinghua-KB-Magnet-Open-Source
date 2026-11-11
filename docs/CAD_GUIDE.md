# CAD access and revision guide

This repository preserves the supplied CAD snapshot without renaming, converting, repairing, or rebuilding its source files. Use the [file index](FILE_INDEX.md) to select a model and the [manifest](../metadata/file-manifest.json) to verify its identity.

## Choose a starting point

| Task | Starting files | Scope |
| --- | --- | --- |
| Inspect the assembly in SolidWorks | `hardware/solidworks/01.THUKB-CY-01-00 M磁组.SLDASM` | Original assembly plus its 13 neighboring part files |
| Review dimensions without CAD software | The nine PDF sheets in `hardware/drawings/` | Human-readable engineering drawings |
| Open individual parts in another CAD system | The eight `.STEP` files in `hardware/drawings/` | Individual neutral-format components; no assembly STEP is supplied |
| Edit a drawing | The seven `.SLDDRW` files and their neighboring `.SLDPRT` files | Drawing-associated native sources |

## Opening the assembly

1. Download or clone the complete repository. Keep both `hardware/solidworks/` and `hardware/drawings/` intact.
2. Open the assembly from `hardware/solidworks/` in a compatible SolidWorks installation. Start with a read-only copy if you intend only to inspect it.
3. Review missing-reference, rebuild, suppressed-component, and mate messages. If a reference cannot be found, first select the matching original filename in the assembly's own folder.
4. Check each component's resolved path. Several similarly named components also exist in `hardware/drawings/`; they must not be substituted by name alone.
5. Record the SolidWorks version, selected configuration, resolved references, and rebuild result before making an export or manufacturing decision.

The package has been checked for file presence and byte identity. A SolidWorks open/rebuild and assembly-reference audit have not been performed for this release. The application's minimum supported version, internal configurations, and external-reference completeness remain unverified.

The original names include Chinese characters, spaces, the multiplication sign `×`, and a full-width slash `／`. Use a Unicode-capable filesystem and preserve these characters. If your toolchain requires ASCII filenames, create a separate derivative using SolidWorks reference-management tools, then rebuild and verify all references before releasing it.

## Why two native model sets exist

`hardware/solidworks/` reproduces the files originally beside the assembly. `hardware/drawings/` reproduces the original drawing folder. This separation reflects the supplied archive rather than a newly defined revision hierarchy.

The drawing-associated `A5_OuterLV1.0.SLDPRT` has the same SHA-256 as its assembly-folder counterpart. `A5_OuterS.SLDPRT` is also byte-identical to assembly-folder `A5_OuterSV1.0.SLDPRT`, despite the different basename. The cover, inner-yoke, SmCo, and inner-yoke-clamp native files differ between the two folders. A different hash establishes different file content; it does not establish which geometry changed or which revision is authoritative.

Do not automatically replace an assembly part with a drawing-associated part. Resolve any dimensional or revision conflict with the project maintainer and document the decision. The `L` and `S` labels are retained as identifiers; a length or position inferred from those letters alone is not a checked design property.

## Working with STEP files

Import a STEP file as an individual component, inspect the import report, and confirm units and body count. Compare key dimensions to the matching PDF before using the imported body for CAM or assembly work. STEP availability does not establish drawing equivalence, fit, or magnetic suitability.

There is no supplied STEP export for `A5_SmCo`, the complete assembly, or the standard screw models. Do not present a newly created neutral model as an original release file. For a derivative export, record the source-file hash, application version, configuration, export settings, and date in its release notes.

## Editing and contributing CAD

Keep manufacturing geometry changes separate from documentation or publishing-tool changes. For each CAD change, describe the component, reason, dimensional effect, and impact on neighboring parts. Supply an updated PDF and neutral export when applicable, and update their manifest entries together.

Review an assembly after part changes for interference, reference resolution, and configuration selection. Record the result in the contribution rather than assuming that a successful file save proves the assembly is ready to build.

The paper discusses a 2024 magnet study. This repository contains the later supplied snapshot named `KB_Standard_A5磁组20261110`. Neither the folder date nor a matching filename proves that this CAD exactly reproduces a paper-tested specimen. See [provenance](PROVENANCE.md) and the [manufacturing guide](MANUFACTURING.md).
