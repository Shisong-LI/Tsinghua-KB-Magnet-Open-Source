# Technical guide

This guide explains the engineering relationships needed to use the source files and design a verification programme. The [paper fact sheet](PAPER_FACTS.md) is the compact source-linked record of article-specific values. The discussion below is independent engineering guidance; it supplies neither a fabrication approval nor test results for the supplied CAD snapshot.

## 1. What the magnet must do

A Kibble balance compares gravitational force with electromagnetic force and links that force measurement to an induced voltage measured during motion. For an ideal vertical measurement:

$$mg=(Bl)_{\mathrm w}I,\qquad U=(Bl)_{\mathrm v}v.$$

Here $m$ is mass, $g$ local gravitational acceleration, $I$ coil current, $U$ induced voltage, and $v$ vertical coil velocity. The factor $Bl$ is a convenient name for the coil's effective field integral. The subscripts distinguish weighing from velocity operation. Combining the relations gives

$$m=\frac{UI}{gv}\frac{(Bl)_{\mathrm w}}{(Bl)_{\mathrm v}}.$$

The familiar cancellation of the magnetic factor requires equality between its effective values in both operations. A stable magnet helps, but equality also depends on the coil path, current, temperature, position, alignment, and operating sequence. Therefore, field strength alone is an incomplete acceptance criterion.

For an ideal circular coil with $N$ turns at radius $r$ in a radial field, the magnitude is approximately

$$Bl\approx 2\pi NrB_r.$$

This relation is useful for a first estimate. Actual winding geometry, finite wire cross-section, leads, field variations, and coil tilt require a more complete model or direct measurement.

## 2. Reading an annular magnetic circuit

In a permanent-magnet circuit, magnetized material provides magnetomotive force, ferromagnetic yokes guide flux, and the air gap provides the working region for the coil. A useful first model is

$$\Phi\approx\frac{\mathcal F}{\mathcal R},\qquad
\mathcal R=\sum_j\frac{\ell_j}{\mu_j A_j},\qquad
B_j\approx\frac{\Phi}{A_j}.$$

The reluctance model explains why gap geometry and interfaces matter. It does not resolve leakage, fringing, saturation, or hysteresis; those require field simulation and measurements with realistic material data. Treat a simulation as conditional on geometry, boundary conditions, magnetization, and the measured material properties supplied to it.

For approximately radial flux through a cylindrical surface of fixed height $h$,

$$\Phi\approx 2\pi rhB_r(r).$$

If flux is approximately independent of radius, $B_r\propto 1/r$ and the product $rB_r$ becomes relatively insensitive to radius. This provides a useful design objective for circular coils. Real devices deviate from this ideal near ends, interfaces, apertures, and local material variations.

## 3. Geometry: preserve the working region

Use the [file index](FILE_INDEX.md) to locate inner and outer yokes, covers, magnet-ring geometry, and auxiliary fixtures. The supplied PDF drawings remain the source for their printed dimensions and tolerances. Verify their relationship to each native part and STEP file before ordering.

The following relationships deserve an explicit review:

| Relationship | Engineering consequence | Evidence to collect |
| --- | --- | --- |
| Inner/outer-yoke concentricity | Unequal local gap width changes azimuthal field behavior and coil clearance | Datum scheme, dimensional report, gap measurements |
| Axial interfaces and split plane | Seating and contamination can change geometry after opening | Interface inspection and repeated closure data |
| Features near the gap ends | Local reluctance and fringing affect the usable travel interval | Measured axial field profile against travel requirements |
| Magnet location and orientation | Polarity errors change the intended flux circuit | Supplier magnetization drawing and incoming polarity map |
| Coil/fixture envelope | Dynamic motion requires clearance across travel and alignment adjustments | Interference review and measured runout |
| Retainers and fasteners | Mechanical security and magnetic perturbations depend on actual material and placement | Approved parts list and assembled inspection |

Do not infer a mating fit from visually similar CAD surfaces. A drawing may describe one component while the assembly references a different revision. Resolve that mismatch with an engineering decision and preserve the reviewed source revision in the manufacturing package.

## 4. Materials: qualify the delivered batch

The paper's material selections are summarized in the [fact sheet](PAPER_FACTS.md). For a new build, specify the exact supplied grade, geometry, processing state, and inspection method rather than relying on a material-family name.

For yokes, record chemistry or grade certification, machining sequence, stress relief or magnetic annealing when applicable, and the condition in which magnetic properties were measured. Machining stress, surface damage, and joint quality can all change the assembled response. A generic permeability constant is insufficient to predict saturation and hysteresis throughout a real circuit.

For permanent magnets, agree the magnetization direction and polarity convention in a supplier drawing. Retain batch identity, dimensional inspection, magnetic acceptance measurements, coating and bonding details where applicable, and the temperature range used for qualification. If an annulus is segmented, record segment identity and orientation so that field asymmetry can be traced back to its physical arrangement.

For fixtures and fasteners, document material as well as size. A mechanically interchangeable item can have a different magnetic response. Replacing parts close to the working region should trigger an assessment of the field map and operating repeatability.

## 5. Opening, assembly, and alignment

Use the article's splitting discussion to understand the design concept, and use the native assembly to establish the actual interfaces in this snapshot. Design a guided, constrained assembly procedure with an explicit support path for every moving mass. An equilibrium position predicted from a force curve still requires lateral guidance and positive retention during access.

Before magnetized assembly, a mechanical review should establish fixture stiffness, travel stops, lift capacity, fastener engagement, and access for alignment. A dry fit of suitable unmagnetized or representative components can reveal reference, clearance, and tooling problems before magnetic forces complicate the operation. Record the procedure actually approved for the workshop; the supplied filenames do not specify a complete lifting system.

Measure concentricity relative to defined datums, rather than adjusting only for a visually even gap. Record closure sequence and adjustment settings. Reopen and close the assembly several times, then repeat the geometric and magnetic measurements that affect the intended instrument operation.

## 6. Field mapping: measure an operating volume

An axial centerline profile is useful, but the coil samples a finite volume. A measurement plan should cover the intended height interval, radial envelope, and azimuthal positions. Define coordinates, sensor orientation, probe calibration, environmental monitoring, and a reproducible scan trajectory.

For a relative profile, a useful definition is

$$\epsilon_B(z)=\frac{B_r(z)-B_r(z_0)}{B_r(z_0)}.$$

State the reference position $z_0$, normalization, smoothing, and treatment of drift when reporting this quantity. Keep the raw data alongside processed profiles. A flat-looking normalized plot can hide changes in absolute field or differences between operating cycles.

In moving-coil measurements, the ratio $U/v$ estimates the effective field integral when parasitic voltage, timing, and motion errors are controlled. Synchronize voltage and velocity acquisition, characterize their transfer functions, and retain both movement directions. Characterize alignment separately so a geometrical effect is not absorbed into a fitted magnetic profile.

## 7. Temperature, current, and history

For small temperature excursions about a reference point, define a local fractional coefficient

$$\alpha_T=\frac{1}{Bl}\frac{\partial(Bl)}{\partial T}.$$

Specify where temperature is measured, when equilibrium is judged to have been reached, and whether the coefficient describes a component or the assembled system. Temperature gradients and sensor lag can make a simple ambient-temperature correction inadequate. Measure the response over the time scales and operating cycle of the intended instrument.

A local empirical current model may be written

$$Bl(I,z)\approx Bl(0,z)\left[1+a_1(z)I+a_2(z)I^2+\cdots\right].$$

This is a generic fit model, not an assertion of measured coefficients for this release. Reverse current, repeat zero-current measurements, and vary the timing sequence to separate reversible current response from heating and magnetic history. Record the current convention and units used in every fit. A coefficient estimated for one coil, height, or sequence should not be transferred without verification.

## 8. From a magnet test to a mass result

A magnet can pass dimensional and field-profile checks while the complete balance remains limited by other effects. Carry field-map uncertainty, temperature response, current dependence, alignment, closure repeatability, and drift into the instrument-level uncertainty analysis together with voltage, current, velocity, local gravity, and mass-related corrections.

Use sensitivity coefficients and covariance when combining correlated terms. Record which corrections are measured, simulated, bounded, or assumed. The [validation guide](VALIDATION.md) supplies a practical test matrix and a reporting template. An independently fabricated magnet earns its performance claim through its own evidence.

## 9. Suggested reading route

Read the article in this order: design and materials (Section II), manufacturing and mechanical operation (Section III), experimental assessment (Section IV), and remaining work (Section V). Use the figures and equations in the linked article as their authoritative context. Then compare the source files with the [manufacturing guide](MANUFACTURING.md), resolve revision questions, and define acceptance measurements before procurement.
