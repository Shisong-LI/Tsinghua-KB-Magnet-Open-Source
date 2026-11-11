# Manufacturing and inspection guide

This guide explains how to turn the supplied files into an inspectable build specification. It is a handoff framework for the project maintainer, machining supplier, and magnet supplier. The source PDFs remain the reference for their individual dimensions and notes.

## Build scope

The package contains an assembly, native part models, drawing sources, nine PDF engineering drawings, and eight individual STEP exports. It does not contain a released quantity bill of materials, a measured assembly, magnetization records, inspection reports, supplier certificates, or the complete equipment required for a Kibble balance.

## Resolve these drawing and model discrepancies first

The nine supplied PDF sheets were inspected. The following distinctions are visible in the original drawing content and affect purchasing and manufacturing.

| Item | Drawing evidence | Required resolution |
| --- | --- | --- |
| Permanent-magnet material | [A5_SmCo PDF](../hardware/drawings/A5_SmCo%20-%20图纸.pdf) is named `A5_SmCo`, but its title block and technical note specify sintered **NdFeB M50** (`钕铁硼 M50`) | Confirm the intended material before ordering; do not label this CAD snapshot a verified SmCo build |
| Yoke material | [Cover](../hardware/drawings/A5_Cover%20-%20图纸.pdf), [InnerL](../hardware/drawings/A5_InnerL%20-%20图纸.pdf), [InnerS](../hardware/drawings/A5_InnerS%20-%20图纸.pdf), [OuterL](../hardware/drawings/A5_OuterL-图纸.pdf), and [OuterS](../hardware/drawings/A5_OuterS-图纸.pdf) title blocks specify **DT4** | The paper discusses DT4C; do not assume grade equivalence or silently replace the supplied drawing specification |
| Fixture revision | [Upper fixture PDF](../hardware/drawings/上部磁体固定件.pdf) and [lower fixture PDF](../hardware/drawings/下部磁体固定件.pdf) identify **V2.0**, dated `20261110`; assembly-folder native filenames identify **V1.0** | Reconcile drawing and model geometry and select an authoritative revision |
| Fixture and clamp material | The two fixture sheets and [inner-yoke clamp sheet](../hardware/drawings/内磁轭卡件%20-%20图纸1.pdf) specify **LY12** | Confirm the supplied material designation and condition with the supplier |

Neither a filename nor a paper parameter overrides an unresolved drawing/model conflict. The archive does not supply material certificates, measured magnetic properties, or an approved disposition for these differences.

## Prepare a controlled drawing set

1. Select a repository revision and record its commit identifier and hardware-manifest hash.
2. Resolve the native-model differences described in the [CAD guide](CAD_GUIDE.md). Establish which model and drawing revision applies to each purchased or machined part.
3. Open each PDF at a readable scale. Review its title block, dimensions, tolerances, surface requirements, material, quantity, and all written notes. Do not quote a dimension from a thumbnail or infer a tolerance from nominal STEP geometry.
4. Create a bill of materials from the resolved assembly configuration. Count component occurrences and distinguish repeated hardware from unique part-file counts.
5. Resolve omissions or conflicts before obtaining a machining quotation. Record the answers with the drawing set so every supplier works to the same interpretation.

The file index counts digital files. It is not a purchase list: one part file can represent several physical occurrences, and an assembly can contain configurations or suppressed components that affect quantities.

## Quantities and manufacturing notes visible on the PDFs

These are sheet annotations, transcribed for navigation. They are not a complete assembly-derived bill of materials.

| PDF component | Sheet quantity | Material annotation | Selected notes |
| --- | ---: | --- | --- |
| A5_Cover | 2 | DT4 | Vacuum stress-relief annealing; remove flash/burrs and dull sharp edges as specified on this sheet |
| A5_InnerL | 1 | DT4 | Vacuum stress-relief annealing; nickel plating `t > 0.05`; explicit sharp-edge/no-chamfer callout |
| A5_InnerS | 1 | DT4 | Vacuum stress-relief annealing; nickel plating `t > 0.05`; explicit sharp-edge/no-chamfer callout |
| A5_OuterL | 1 | DT4 | Vacuum stress-relief annealing; nickel plating `t > 0.05`; explicit sharp-edge/no-chamfer callout |
| A5_OuterS | 1 | DT4 | Vacuum stress-relief annealing; nickel plating `t > 0.05`; explicit sharp-edge/no-chamfer callout |
| A5_SmCo | 2 | NdFeB M50 | Sintered material; smooth surfaces without burrs, scratches, or other defects |
| Upper magnet fixture | 1 | LY12 | Natural-color anodizing; unmarked chamfers C0.5 |
| Lower magnet fixture | 1 | LY12 | Natural-color anodizing; unmarked chamfers C0.5 |
| Inner-yoke clamp | 2 | LY12 | Remove flash/burrs and dull sharp edges; unmarked fillets R2.5 |

All nine sheets refer to `GB/T 1804-f` for unmarked dimensional tolerances. Apply explicitly dimensioned tolerances and local feature notes at their indicated locations. Obtain the applicable standard and confirm its interpretation with the supplier; this guide does not reproduce its tolerance tables.

The four inner/outer-yoke sheets explicitly state that edges retain sharp corners and prohibit chamfering. Their burr-removal notes must be implemented without defeating those local requirements. Cover and aluminum-fixture edge treatments differ. Do not apply one blanket deburring or chamfer operation to the entire assembly.

The plating callout is transcribed literally as `t > 0.05`. Clarify its unit, process, dimensional allowance, and effect on final fits before manufacture. The package does not include a process specification resolving those points or the order of heat treatment, finish machining, and plating.

The permanent-magnet drawing shows outer diameter 130 mm, inner diameter 40 mm, and height 25 mm. Both outer-yoke sheets show an outer diameter of 220 mm. These are selected drawing dimensions, not an assembly reconstruction or a declaration that all paper geometry matches the supplied revision. Consult the full original sheets for the remaining dimensions and tolerances.

## Component handoff

| Group | Supplied evidence | Required handoff decision |
| --- | --- | --- |
| Cover and inner/outer yokes | Native models, PDF sheets, and individual STEP models | Confirm material condition, dimension hierarchy, mating surfaces, and final inspection requirements |
| Permanent magnet | `A5_SmCo` native models, drawing source, and PDF specifying NdFeB M50 | Resolve material naming, then confirm magnetic specification, segment arrangement if used, magnetization direction and polarity, acceptance tests, and handling fixture |
| Upper/lower magnet fixtures | Assembly-folder native models, PDF sheets, and STEP models | Confirm fit to the selected assembly revision and actual loading requirements |
| Inner-yoke clamp | Two native-file versions, drawing source, PDF, and STEP | Resolve revision differences before procurement |
| Standard screws | Native part models with size identifiers in their filenames | Confirm occurrence count, material, strength class, finish, engagement, and tightening specification |

## Dimensional inspection

Plan inspection around the functional interfaces: the air-gap surfaces, yoke concentricity, mating faces, mounting features, and clearances needed for the coil and handling equipment. Derive acceptance values from the selected drawings and approved assembly definition. The existence of a CAD dimension does not establish a verified machining tolerance.

For each inspected component, record the part identifier, drawing revision, measurement method, instrument identity, measurement uncertainty where relevant, results, and disposition. Record compliance with the applicable local edge-treatment notes and cleanliness of mating surfaces before final assembly. Do not alter a magnetic surface or a fit to resolve an unexplained assembly conflict without an approved engineering change.

## Magnetic characterization

Confirm the supplier's material and magnetization records against the agreed purchase specification. Record the identification and polarity of each permanent-magnet component before it enters the assembly. After assembly, measure the field using a documented coordinate system and calibrated instrumentation; preserve the raw measurements and analysis settings.

A useful measurement record includes probe orientation, position reference, scan direction, temperature, settling time, instrument calibration, and the assembly's open/closed history. Repeat relevant measurements after a geometry adjustment, component substitution, or disassembly. Compare a new build to its own acceptance criteria rather than treating the paper's results as a certificate for this CAD snapshot.

## Assembly preparation

Prepare a fixture-supported assembly plan from the resolved CAD and an assessment of magnetic and mechanical loads. Specify restraint, travel limits, access, lifting points, and the means to keep the coil and gap surfaces clear during closure. Permanent magnets can produce large attraction and repulsion forces before surfaces touch. Use appropriately rated handling equipment and keep hands out of closing interfaces.

The supplied source set does not establish a validated bolt-tightening sequence, torque schedule, adhesive specification, lifting capacity, or force-versus-travel acceptance test. Those parameters require an engineering decision for the actual parts and fixture. A levitation feature described in the publication is not a rated lifting or support system for an untested reproduction.

## Complete the build record

Keep the resolved bill of materials, drawing set, material certificates, dimensional results, magnetization records, assembly procedure, configuration record, and field measurements together. A reproducible release should identify both the digital source revision and the actual assembled specimen.

For a derivative design, describe every change from this archive and its verification. Consult the [technical guide](TECHNICAL_GUIDE.md), [paper fact sheet](PAPER_FACTS.md), and [provenance record](PROVENANCE.md) for the boundary between research context and the evidence supplied with this release.
