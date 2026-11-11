# Validation and acceptance plan

This is a proposed verification programme for a newly built magnet. It is not a record of completed hardware tests. Article-specific observations are in the [paper fact sheet](PAPER_FACTS.md); repository checks verify file integrity, not magnetic behavior.

## Validation status of this release

| Item | Status |
| --- | --- |
| Source payload copied and indexed | Verified by file-manifest checks |
| All nine PDF drawings: text and rendered sheets | Inspected during packaging; see [manufacturing guide](MANUFACTURING.md) |
| Native assembly resolves and rebuilds in SolidWorks | Not verified |
| All STEP files import and agree with native parts | Not verified |
| Drawing/CAD revision agreement and complete manufacturing BOM | Requires engineering review |
| Fabricated component dimensions and material properties | No new measurements supplied |
| Assembled field maps and repeatability | No new measurements supplied |
| Complete Kibble balance performance or uncertainty | Not established by this repository |

## 1. Digital source acceptance

Run `python scripts/validate.py` from the repository root and retain its output with the release tag. The file manifest records the hardware payload rather than self-referential hashes of the repository metadata.

In SolidWorks, open the assembly with full part resolution, rebuild it, and record software version, missing references, suppressed components, warnings, and active configuration. Export an assembly BOM and compare every referenced file with the manifest. If a component is missing, preserve that finding rather than silently recreating it from a similar name.

Open every neutral CAD file in the receiving tool. Check units and overall bounds, then compare critical dimensions, datums, mating features, and printed tolerances against the native model and drawing. A valid exchange-file header is only a format check.

## 2. Define acceptance before procurement

Choose acceptance limits from the intended coil, travel, operating sequence, measurement uncertainty allocation, and workshop capability. Do not adopt an article's measured performance as an automatic purchase tolerance. Name the measurement method and uncertainty alongside each proposed limit.

| Test | Quantity or behavior | Minimum record |
| --- | --- | --- |
| Incoming materials | Yoke grade/processing; magnet grade/polarity | Batch certificates and measured magnetic checks |
| Dimensional inspection | Gap-defining radii, axial datums, fits and clearances | Drawing revision, instrument, uncertainty, results |
| Pre-assembly review | References, interference, restraints, fixture travel | Signed review record and assembly procedure |
| Static alignment | Concentricity, runout, seating and gap distribution | Coordinate convention and measurement locations |
| Absolute field | Working-region field magnitude and orientation | Sensor calibration, temperature and position |
| Axial profile | Field integral over the intended travel | Raw scans, normalization, fit residuals and repeat scans |
| Radial/azimuthal map | Variation over the actual winding envelope | Probe locations and asymmetry metrics |
| Closure repeatability | Geometry and profile after access cycles | Cycle count, settings and before/after differences |
| Thermal response | Drift, gradients, coefficient and settling | Sensor locations, time series and test sequence |
| Current dependence | Change under the intended current cycle | Polarity convention, timing, coil position and model |
| Magnetic history | Response to current and opening history | State preparation, sequence and recovery measurements |
| Instrument integration | Effective field-integral equality across modes | Synchronized voltage/velocity and weighing records |

## 3. Recommended measurement record

Keep machine-readable raw data outside the immutable source snapshot, or add it as a separately documented dataset. CSV is sufficient if its schema and units are explicit. Include:

- Repository commit, CAD revision, component serial numbers, and assembled configuration.
- Date/time with timezone, operator, procedure revision, and instrument calibration identifiers.
- Coordinate origin, sign conventions, probe/coil orientation, commanded and measured positions.
- Temperature sensor identities and locations, ambient conditions, coil current, and timing.
- Raw voltage, velocity, magnetic measurements, and the processing software revision.
- Corrections, exclusions, smoothing, fitted coefficients with units, residuals, and uncertainty.

Avoid using one CSV column for different quantities in different scan types. Retain missing readings explicitly and explain exclusions. Include repeat scans that test drift and hysteresis rather than reporting only the smoothest trace.

## 4. Test report template

```text
Test identifier:
Repository commit / hardware revision:
Assembly and coil identifiers:
Objective and predeclared acceptance limits:
Measurement method and calibration references:
Coordinates, polarity, and units:
Environmental conditions and stabilization:
State preparation and operating sequence:
Raw data location and checksum:
Processing code/version:
Results, repeatability, and uncertainty:
Deviations and unresolved questions:
Pass/fail decision and reviewer:
```

Attach plots with labeled axes and units, and give the full scan range even when discussing a smaller accepted interval. A repeatability plot should identify the cycles represented. A temperature fit should show the time record or sufficient evidence that lag and gradients were considered.

## 5. Acceptance and change control

Approve a build for its documented operating envelope. Replacing a magnet batch, modifying gap geometry, changing a fixture's material, altering the coil, or changing the current sequence can invalidate earlier evidence. State which tests must be repeated for each class of change.

For a public measurement report, distinguish measured quantities from modeled estimates and design targets. Link raw data and analysis to the released hardware revision so another group can assess the same claim.
