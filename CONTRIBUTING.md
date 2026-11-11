# Contributing

Contributions that improve reproducibility are welcome: corrected file mappings, resolved assembly references, reviewed manufacturing notes, neutral-format assembly exports, simulation inputs, and well-documented measurement datasets.

## Report an issue

Include the repository commit or release tag, the exact affected path, your CAD application/version where relevant, and a concise expected-versus-observed description. For geometry or drawing discrepancies, identify the dimension or feature and explain how it was checked. Please avoid attaching unrelated proprietary models or personal information.

## Propose a design change

1. State the engineering problem and the behavior the change should achieve.
2. Identify affected interfaces, drawings, materials, assembly operations, and magnetic assumptions.
3. Supply editable CAD and update relevant drawings or neutral exports together.
4. Preserve original filenames unless intentionally migrating references; document that migration.
5. Rebuild the assembly in the stated CAD version and report unresolved references or warnings.
6. Update inventory entries and hardware checksums for intentional payload changes.
7. Run `python scripts/validate.py` and include the relevant engineering validation.

For binary CAD changes, attach a before/after image or dimensional comparison so the review does not depend solely on opening a proprietary tool. A STEP export should identify its native source revision, export settings, and length units.

## Report measurements or simulations

Use the [validation guide](docs/VALIDATION.md). Link raw data, calibration references, processing code, operating conditions, and the tested hardware revision. Separate measured results from fitted coefficients, simulated values, and acceptance targets.

For simulations, include solver/version, geometry source, materials, magnetization, boundary conditions, mesh convergence, and a comparison with measurement where available. Do not publish an image alone as a reproducible simulation result.

## Licenses and attribution

Submit contributions under the license assigned to the affected material in [LICENSE](LICENSE), retain existing notices, and disclose external material and its terms. Cite the scientific work when discussing the published design or results.
