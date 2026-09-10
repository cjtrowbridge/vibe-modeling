# triple_thor_enclosure

A triple-thor vertical enclosure. Three Thor units stand on end inside a
cylindrical acrylic shroud, seated in a 3D-printed cylindrical base plinth
with open-bottom recesses. Cool air is fed from a 120 mm intake fan in a
side-mounted intake assembly; it rises through the central void between
the Thors (open up to the top of the Thors so their full intake sides are
exposed) and across their intake faces. Hot air is expelled from the
outward-facing large sides of the Thors and drawn out the top through a
`120 mm` hole cut in the center of the closed cylinder top, by a `120 mm`
exhaust fan mounted at the very top.

This is currently a **structural mockup only** — lighting, down-lights,
and glow-in-the-dark / iridescent circuitry accents are deferred (see
Lighting, later section).

Because the print bed is `220 x 220 x 220 mm`, the base and top cap are
split radially into thirds (annular sectors) and joined with M3 hardware.
The intake and exhaust assemblies are separate parts that attach to the
symmetric sectors.

## Thor Unit

- Each Thor is `234 x 113 x 57` mm; the standing height used in this
  design is **`244 mm`** (confirmed).
- **Top clearance:** the Thors have buttons on top that must not be
  pressed, so the enclosure needs **at least `10 mm` of clearance**
  above the Thor tops — the top cap / exhaust stack must not bear down
  on the Thor tops. This sets the top-cap standoff / mounting-hardware
  height (see Exhaust fan stack).
- Standing on end: the standing height is vertical (Z), and the footprint
  of each Thor is `113 mm x 57 mm`.
- The `113 mm` side of each Thor faces the center of the arrangement so
  the three `113 mm` faces form an equilateral triangle footprint.
- **Intake:** each Thor takes in air on its narrow (`57 mm`) sides (the
  two faces between the inward `113 mm` face and the outward `113 mm`
  face).
- **Exhaust:** each Thor expels hot air from the large face pointing
  **outward, toward the acrylic cylinder** (the `113 mm` face on the
  outside of the triangle). That hot air is collected by the cylinder
  interior and pulled up and out the top (see Exhaust Path).

## Acrylic Cylinder (Shroud)

- **Internal diameter:** `290 mm`
- **External diameter:** `300 mm` (wall thickness `5 mm`)
- **Height:** `300 mm`
- Encloses the three Thors on their sides.
- **Closed on one end:** the cylinder has a **closed end at the top** and
  an **open end at the bottom**.
- **Bottom coupling:** the open end seats into a lip formed by the base
  plinth sectors; the lip keeps the cylinder centered and supported on
  the base (see Base Plinth).
- **Top:** the user will cut a `120 mm` diameter hole through the center
  of the closed top for exhaust. The printed top cap attaches by a lip
  around its edge that **centers** the cap on the `300 mm` OD cylinder —
  a centering lip, not a press fit and not screwed to the cylinder wall.
- **Exhaust path:** hot air expelled from the Thors' outward-facing
  exhaust faces fills the interior, rises, and is drawn up through the
  `120 mm` top hole by the `120 mm` exhaust fan mounted above it (see Top
  Cap).

## 3D-Printed Base Plinth

The base receives the three Thors, forms the lip that seats the open
bottom of the acrylic cylinder, and carries the **intake assembly**. It
is split radially into three annular sector parts for print-bed fit.

### Base Sectors

- Three annular sector parts, each 120 degrees of the base circle.
- Each sector contains: one Thor recess, its wire-chase openings, the
  share of the central-void / duct interface, and its share of the
  cylinder-receiving lip.
- **Symmetry:** two sectors are intended to be **identical** and one is
  the **unique intake sector**. The intake assembly (see Intake
  Assembly) breaks the 3-fold symmetry, so full interchangeability is
  not required. The two non-intake sectors should remain interchangeable
  with each other where possible.

### Recesses

- One per Thor, each **`50 mm` deep** (tentative — "we will have to see
  how this works and potentially adjust") to receive the bottom of the
  Thor.
- **Recess bottoms are open** to the wire chases (see Wire Chases).
- **Lip:** a ~`3 mm` lip around the recess edge prevents the Thor from
  dropping out / tipping.

### Wire Chases

- **The whole bottom face of each Thor is exposed** to the outside as a
  wire chase: the open recess bottom lets the full bottom of the Thor
  reach out and down for cable management. There is no discrete small
  notch per wire; the entire open bottom face is the chase.
- This is intentional: any number/width of cables can exit freely.

### Intake Assembly (side-mounted, asymmetric)

- The 120 mm **intake** fan is **not** in the central duct column.
- Instead the intake duct does a **`90 degree` turn** and routes out
  **one side** of the enclosure (the unique intake sector). The intake
  fan is mounted at (or near) that turn so it blows into the duct run
  that feeds the central void.
- The intake assembly (fan + turn + short duct + mounting) is a
  separate printed part that **attaches to the symmetric sectors** with
  M3 hardware — it is not baked into one sector, so the sectors stay
  simple and mostly interchangeable.
- The intake mouth is on the **outside** of the enclosure (toward the
  viewer / accessible side), taking in fresh ambient air.
- Exact turn geometry, fan mounting, and the sector interface are open
  (see Open Questions).

### Cylinder-Receiving Lip

- The base sectors form a continuous lip/groove around the outer edge
  that receives the **open bottom end** of the `300 mm` OD acrylic
  cylinder, centering and supporting it.
- M3 hardware through the lip can clamp the cylinder to the base (nut
  holders / boss behind the lip). See Base Hardware.

### Base Hardware

- M3 screw holes and nut holders (or printed boss with trapped nut) at:
  - the **central-duct / void interface** — clamping the base sectors
    together and to the central structure,
  - **inside the cylinder lip** — clamping the `300 mm` OD cylinder to
    the base,
  - the **outer edge of the base** — for optional external mounting,
  - the **intake-sector interface** — attaching the intake assembly to
    the sector(s).
- Nut-holder strategy and exact bolt-circle diameters are open (see
  Open Questions).

## Central Airflow Column

A **separate printed cylindrical column** at the center of the
arrangement, running from the base up through the central void to the
level of the **top of the Thors**.

- It no longer houses the intake fan (the fan moved to the side-mounted
  Intake Assembly) — it is the **central airflow structure / spine** that
  the intake duct and the top exhaust tie into, and it carries the M3
  hardware that joins the base sectors and top cap.
- **Open to the Thors:** the column / central void is open all the way
  up to the top of the Thors so the **entire inside and sides of the
  Thors are exposed to fresh air**. Cool air from the intake rises
  through the middle and out across the intake (narrow `57 mm`) edges.
- The central void is bounded by the three center-facing `113 mm` faces
  of the Thors and **extends out to the edges** of the Thors at each
  corner.
- **The inter-thor gap is a first-class airflow dimension.** The original
  targets — gap as close to `2 x` Thor thickness (`114 mm`) as possible,
  and the exhaust faces at least `1 x` Thor thickness (`57 mm`) clear of
  the `290 mm` wall — are **mutually exclusive** for a `290 mm` ID
  cylinder (verified numerically):
  - At the minimum inradius `R = 32.6 mm` (Thors' inner corners just
    touching), the exhaust-face clearance is `55.4 mm` (near the `57 mm`
    target) but the inter-thor gap is `0 mm`.
  - The inradius that gives a `114 mm` gap is `R ≈ 88 mm`, which pushes
    the outer corners to `155.6 mm` — past the `145 mm` cylinder radius.
  - The maximum `R` that still fits inside the `290 mm` ID is `R ≈ 75
    mm`, giving a gap of `82 mm` but only `13 mm` exhaust-face clearance.
  No single `R` satisfies both targets; the `114 mm` gap target is the
  binding one and is unachievable inside this shroud.
- **Layout decision (balanced):** the **inradius is locked at `R = 57 mm`**
  (one Thor thickness). This gives an **inter-thor gap of `42.2 mm`**, an
  **exhaust-face clearance of `31.0 mm`** to the `290 mm` wall, and an
  **outer extent of `127.2 mm`** (fits the `145 mm` radius with a
  `17.8 mm` margin). Both original targets are relaxed to reach this
  balanced point; if either becomes critical later, the levers are a
  larger shroud OD or a reduced Thor footprint.
- The goal is maximum central airflow to the intake edges while keeping
  the outward exhaust faces clear of the cylinder.
- Column diameter, height, and the intake/exhaust tie-in geometry are
  open questions.

## 3D-Printed Top Cap

- Cylindrical top cap sits on top of the acrylic cylinder.
- **Centering lip:** a lip around the edge of the cap keeps the cap
  **centered** on the `300 mm` OD cylinder. It is a centering feature,
  not a press fit and not screwed to the cylinder wall.
- **Exhaust stack:** a `120 mm` exhaust fan is mounted **above the
  `120 mm` hole** the user cuts in the closed cylinder top, between that
  hole and the mounting hardware at the very top of the structure. Hot
  air from the Thors (outward-facing exhaust faces) fills the cylinder
  interior, rises, and is pulled up through the hole by this fan.
  - The top cap provides the **mounting hardware** that connects the
    fan to the very top of the structure (M3 + nut holders).
  - Clearance is required for the fan body and its plenum above the
    cylinder top.
- **Thor top clearance:** the top cap / exhaust stack must **not bear
  down on the Thor tops** (buttons must not be pressed) — the cap rides
  on the cylinder, not on the Thors, and leaves **at least `10 mm` of
  clearance** above the `244 mm` Thor tops.
- **Lighting (DEFERRED):** down-lights, glow-in-the-dark / iridescent
  circuitry accents, and the USB blacklight are **not part of this
  structural mockup** and are deferred to a later iteration. No LED
  hardware, light features, or accent geometry are modeled now.
- **Print-bed fit:** the top cap is split radially into thirds
  (annular sectors), matching the base, and assembled with M3 hardware
  at the central interface, the cylinder centering lip, and the outer
  edge.

## Lighting (Deferred)

- **Down-lights**, **glow-in-the-dark / iridescent circuitry accents**,
  and the **USB blacklight** are **deferred** out of this iteration.
- The current deliverable is a **structural mockup**; no LED hardware,
  light-emitting features, or accent geometry are modeled now.
- When revisited, decide: which blacklight / LED hardware, the target
  aesthetic (traced circuit paths vs. abstract geometry), and whether
  accents are printed in a separate material or painted.

## Airflow Summary

1. The 120 mm **intake** fan (in the side-mounted Intake Assembly)
   pushes fresh air out one side of the base, into the central airflow
   column.
2. The column / central void is **open all the way up to the top of the
   Thors**, so cool air rises through the middle and out across the
   intake (narrow `57 mm`) edges of all three Thors. The whole inside
   and sides of the Thors are exposed to fresh air.
3. Air passes through each Thor.
4. Hot air is expelled from each Thor's **outward-facing** large side,
   into the space inside the acrylic cylinder.
5. The hot air fills the cylinder interior, rises, and is drawn out
   through the `120 mm` hole in the closed top by the 120 mm **exhaust**
   fan mounted above it.

## Scope

- Current deliverable is a **structural mockup** in OpenSCAD (existing
  reference mockup at `src/triangle_layout_mockup.scad`). Lighting,
  down-lights, and glow/iridescent accents are **deferred**.
- Printable parts (print bed `220 x 220 x 220 mm`), to be detailed once
  the mockup is approved:
  - **two identical base sectors** + **one unique intake sector**,
  - one **intake assembly** (fan + 90-degree turn + short duct),
  - one **central airflow column / spine**,
  - **three top-cap sectors** (carrying the centering lip and the exhaust
    fan mounting stack),
  - plus the off-the-shelf acrylic cylinder (`290 mm` ID / `300 mm` OD
    x `300 mm` tall, closed on top, open at the bottom, user-cut
    `120 mm` exhaust hole).
- **Structural targets:** all printed parts use a **`3 mm` minimum wall
  thickness**, and the **minimum structural overlap is `>= 3 mm`**
  (per `AGENTS.md` §10). Every structural join must be a positive-volume
  intersection of at least the minimum overlap; coplanar / epsilon
  contacts do not count.
- Parts are joined with **M3** hardware and nut holders (see Base
  Hardware and Top Cap). Structural and fit verification follows the
  repository CAD playbooks, including the split-print playbook.

## Current Folder Layout

- `src/` - OpenSCAD source. `main.scad` will become the scripted export
  entrypoint once the design has dispatchable parts.
- `src/triangle_layout_mockup.scad` - Initial reference mockup. Shows the
  three Thors' `113 mm` sides arranged as an equilateral triangle
  (inradius `inner_side / (2 * sqrt(3))`), a `211.89 mm` outside-circle
  reference, and a `290 mm` bounding circle for clearance context.
  Classified as a **non-printable reference mockup** per
  `playbooks/how_to_manage_reference_mockups_and_non_printable_geometry.md`;
  it must not be unioned into printable output.
- `src/parts/` - Per-part source modules (base, top cap, duct, etc.) to
  be split out.
- `configs/` - Named revision configs (e.g. `rev_0001.json`) once part
  IDs and parameters are established.
- `parts.json` - Not yet created; will define the authoritative printable
  and assembly artifact set once exports are classified.
- `assembly.json` - Not yet created; will define the multipart assembly
  contract once the base / cylinder / top cap hierarchy is locked.

## Open Questions (to resolve before geometry work)

Resolved (recorded for context, no longer open):

- **Thor standing height = `244 mm`** (confirmed). Top clearance for the
  Thor buttons is required (see resolved item below).
- **Thor top clearance = `10 mm` minimum** above the `244 mm` Thor tops,
  so the top cap / exhaust stack does not press the Thor buttons. This
  sets the top-cap standoff / mounting-hardware height.
- **Layout inradius locked at `R = 57 mm`** (one Thor thickness), the
  balanced point between central airflow and exhaust clearance. The
  original `114 mm` gap target and `57 mm` exhaust-clearance target are
  mutually exclusive inside the `290 mm` ID shroud (see Central Airflow
  Column for the full derivation). At `R = 57 mm`: inter-thor gap
  `42.2 mm`, exhaust-face clearance `31.0 mm`, outer extent `127.2 mm`.
- **Minimum wall thickness = `3 mm`** for all printed parts (structural
  overlap must be >= `3 mm` per `AGENTS.md` §10).
- **Recess depth = `50 mm`** (tentative — "we will have to see how this
  works and potentially adjust").
- **Wire chases = the whole bottom face of each Thor** is exposed as the
  chase; there is no fixed count/width to define.
- **Sector symmetry** is satisfied by making **two base sectors
  identical + one unique intake sector**; the intake assembly attaches
  to the symmetric sectors (see still-open item 1).
- **Cylinder / cap coupling:** cylinder is closed on top, open at the
  bottom; the base lip receives the open bottom end and the top-cap lip
  centers on the `300 mm` OD (no press fit, no clamp to the wall).
- **Thor exhaust orientation:** the large side facing **outward**
  (toward the cylinder) is the exhaust face on all three Thors.
- **Column height:** open up to the **top of the Thors**, so the whole
  inside and sides of the Thors are exposed to fresh air.
- **Lighting:** deferred (structural mockup only).

Still open:

1. **Intake assembly geometry (asymmetric):** exact `90 degree` turn
   shape, the duct run that feeds the central column, where the 120 mm
   intake fan mounts, the intake mouth location on the outside, and how
   the intake assembly attaches (M3 + nut holders) to the unique intake
   sector and its neighbors without making the two identical sectors
   non-interchangeable.
2. **Exhaust fan stack geometry:** the `120 mm` fan sits above the
   user-cut `120 mm` top hole; define the mounting hardware / standoff
   height (must clear the Thor tops by the `10 mm` minimum above), plenum
   clearance, and the M3 interface to the top-cap sectors.
3. **M3 mounting points (all pieces):** exact bolt-circle diameters,
   hole counts, and nut-holder strategy at every joint — base sectors to
   each other, base to cylinder, intake assembly to sectors, central
   column to base and top, and top-cap sectors to each other and to the
   exhaust stack. All must preserve the `3 mm` minimum internal-edge
   margin.
4. **Print-bed fit (addressed by radial split):** verify each base
   sector, the intake assembly, the central column, and each top-cap
   sector fit the `220 mm` bed with margin; confirm the split
   orientation minimizes supports.
