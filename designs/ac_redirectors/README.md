# AC Redirectors

`ac_redirectors` is a two-part parametric airflow-guide prototype plus a
reference-only AC interface mockup for the
low-mounted Toshiba window air conditioner shown in the supplied truck-camper
reference photos.

Both objects share a thin quarter-cylinder foundation. The common scoop turns
the nominally horizontal outlet stream upward. The door-side object continues
into a four-wall vertical duct; the bed-side object divides the outlet into
five individually enclosed ducts whose upper segments turn the rising stream
approximately 45 degrees toward the bed.

## Authoritative Parts

- `part_id = 1`: `ac_redirector_door_side`
- `part_id = 2`: `ac_redirector_bed_side`
- `part_id = 3`: `ac_vent_rail_mockup`

`parts.json` is the authoritative complete-build manifest.

## Revision 0001 Assumptions

- Measured total outlet width: `406 mm`
- Nominal outlet height and quarter-turn internal radius: `50 mm`
- Printed width per object: `198 mm`
- Nominal installed gap between objects: `10 mm`
- Nominal wall and end-wall thickness: `3 mm`
- Provisional rail profile: `3 mm` thick by `10 mm` deep
- Provisional hook clearance: `0.6 mm`
- Photo-derived lower vent datum to rail base: approximately `64 mm`
- Photo-derived vent face to vertical rail: approximately `56 mm`
- Photo-derived vertical rail-flange rise: approximately `34 mm`
- Bed-side yaw direction: negative X at `45 degrees`
- Material requested for the prototype: PLA

The photographed rail profile was not measured conclusively. The revision 0001
hook is therefore a provisional rectangular-flange assumption, not a confirmed
fit. Print a narrow cross-section coupon or crop before committing to either
full-width object. PLA may creep or soften in a hot parked vehicle; the geometry
uses gravity capture instead of spring retention, but that does not remove the
temperature risk.

## Airflow Geometry

The quarter-turn is an open guide rather than a sealed duct. Its `3 mm` annular
shell follows a 90-degree arc with a `50 mm` internal radius. Solid end walls
limit lateral spill and carry two end hook bands. On the door-side part, a
continuous `3 mm` alignment spine merges into the solid back wall. The
bed-side part retains the spine and merges it into a continuous `3 mm`
AC-side mounting wall that extends down to the duct roots. The hooks, end
walls, alignment spine, mounting wall, and five duct backs therefore form one
continuous structure rather than leaving an exposed bar or visually floating
hooks. The hook bridges stop at the rear airflow plane instead of projecting
into the end ducts. The continuous wall occupies the front `3 mm` boundary of
that plane. A `6 mm`-deep cap exists only at the top alignment spine: its rear
`3 mm` overlaps the hooks and its front `3 mm` overlaps the wall. This
preserves a full-thickness load path without placing hook material inside the
airflow or projecting the lower wall into the AC casing.

Both top-duct wall sets rise `50 mm`, matching the quarter-cylinder radius. The
door-side top duct has solid front, back, left, and right walls with an open
top. The bed-side object uses five separately enclosed channels spanning the
entire `198 mm` intake. Each channel rises vertically for `28 mm`, then its
final `22 mm` rises and shifts `22 mm` through X and Z. This preserves the
requested 45-degree outlet direction while keeping the complete bed-side
artifact at the printer's `220 mm` limit. Each bed-side outlet is trimmed on a
plane perpendicular to its final swept centerline rather than ending
horizontally. Set `bed_yaw_sign` to `1` to mirror the direction.

The provisional hook geometry provides:

- `12 mm` vertical engagement below the bridge
- `10.6 mm` usable rail depth (`10 mm` rail plus `0.6 mm` clearance)
- `72.6 mm` total rearward reach from the vent face to behind the reversed lip
- `11 mm` hook-band length along the rail at each end

Both `11 mm` hook bands sit fully inside the `198 mm` base footprint, flush
with its left and right edges. They remain behind the continuous rear wall and
overlap the alignment spine through their full width, so they do not enter an
end-duct opening or extend beyond the main base on the build plate.

The bed-side foundation end walls stop at the `z = 53 mm` quarter-turn
terminal plane. Above that plane, the two outer swept-duct side walls provide
the enclosure. This prevents a stationary full-height end wall from cutting
through the laterally shifted outer duct while retaining a `3 mm` overlap at
the foundation seam. The door-side part retains its full-height end walls
because its duct rises vertically without a lateral sweep.

The AC-facing inlet remains `50 mm` high. Revision 0001 places the provisional
rail top at `z = 98 mm`. The bed-side hook bridge top remains at
`z = 101.6 mm`, `48.6 mm` above the `z = 53 mm` inlet top. The door-side
bridges extend to `z = 103 mm`, flush with its duct top, so that top plane can
sit flat in the alternate print orientation; its inlet-to-hook-top difference
is `50 mm`. The rail-contacting bridge bottoms remain at `z = 98.6 mm`, so
this change does not alter the nominal `0.6 mm` vertical fit clearance. These
vertical datums are estimates from the photographs, not precision fit
measurements.

## AC Vent and Rail Mockup

The third manifest artifact is a full-width reference mockup, not a replacement
appliance component. It contains:

- the measured `406 x 50 mm` clear vent envelope
- a shallow `8 mm` visualization recess
- the approximately `64 mm` lower-vent-datum to casing-top height
- the approximately `56 mm` vent-face to vertical-rail setback
- the approximately `34 mm` vertical rail rise
- an assumed `3 mm` sheet thickness and `10 mm` upper/lower rail-lip depth

The rail's horizontal foot and upper rolled-lip envelope point rearward toward
the wood side of the installation. The hook rear drops sit beyond that
rear-facing lip.

## Installed Fit Check

The source preview (`part_id = 0`) aligns all three models in a shared installed
coordinate system:

- bed-side redirector: left `198 mm`, with its outlet swept outward
- center clearance: `10 mm`
- door-side redirector: right `198 mm`
- mockup vent width: `406 mm`
- vent face and lower vent datum: shared Y/Z origins

The hook bridges clear the `z = 98 mm` rail top by `0.6 mm`. The door-side
bridge extends upward from that unchanged contact datum until its top is flush
with the duct at `z = 103 mm`; the bed-side bridge retains its `3 mm`
thickness. The rear drops clear the back of the reversed rail lip by `0.6 mm`.
Boolean intersection probes against each redirector produce only a `y = 0`
coplanar vent-face surface with zero thickness; there is no positive-volume
collision with the mockup casing or rail. The former triangular below-rail
webs were removed because the probes showed that they intersected the casing.

The photo-derived dimensions are read from
`docs/PXL_20260723_234429149.jpg`,
`docs/PXL_20260723_234439209.jpg`, and
`docs/PXL_20260723_234511947.jpg`, with the adjacent images used to check jaw
placement and orientation. The plastic caliper, perspective, and rounded
housing surfaces limit precision, so the mockup should be treated as an
installation envelope rather than a metrology-grade replica.

## Structural Contract

- Minimum wall thickness: `3 mm`
- Minimum structural overlap: `3 mm`
- Minimum internal edge/material width: `3 mm`

Named assertions cover:

- Quarter-turn shell to each end wall
- End walls and hook bridges to the continuous mounting wall
- Door-side hook bridges to the continuous alignment spine
- Bed-side alignment spine to the continuous mounting wall
- Door guide to the quarter-turn terminal wall
- Door-duct front/back walls to both side walls
- Each swept bed duct to the quarter-turn terminal wall
- Bed swept side walls to the lower foundation end walls
- Front/back walls to both sides of every bed duct
- Hook-band width, hook engagement, yaw envelope, and complete build envelope
- Mockup casing-to-rail-foot overlap

The two redirectors have no subtractive cuts. The reference mockup has one
shallow outlet recess; it leaves a much thicker backing than the `3 mm`
minimum, with no neighboring cuts, so its pairwise cut-ligament inventory is
empty.

## Build

From the repository root:

```powershell
python scripts/scad_build_all.py `
  --design ac_redirectors `
  --config designs/ac_redirectors/configs/rev_0001.json
```

Audit the installed complete build:

```powershell
python scripts/scad_build_all.py `
  --design ac_redirectors `
  --config designs/ac_redirectors/configs/rev_0001.json `
  --audit-only
```

## Print Orientation and Fit Test

The initial orientation recommendation is the installed orientation, with the
flat bottom tangent of the quarter-turn shell on the build plate. This keeps
the 198 mm width inside the printer's 220 mm X limit and avoids turning the far
end wall into a large bridge. The curved shell rises progressively from the
bed. The provisional hooks may require localized support.

Before either complete print:

1. Crop or section a `20-30 mm` hook-and-side-wall coupon.
2. Test lowering it over the actual metal rail without forcing it.
3. Confirm that the rear drop has clearance from the wood, foam, and screws.
4. Adjust `rail_depth`, `hook_clearance`, `hook_engagement`,
   `rail_face_setback`, `ac_inlet_lower_datum_to_rail_base`, and
   `rail_flange_height`.
5. Confirm that the quarter-turn outlet projects beyond the shelf edge.

## Structural Verification Record

- Source revision/config: `designs/ac_redirectors/configs/rev_0001.json`
- Minimum wall thickness: `3 mm`
- Minimum structural overlap: `3 mm`
- Minimum internal edge width: `3 mm`
- Join inventory reviewed: scoop/end walls, end walls/hook bridges,
  door hooks/alignment spine, bed hooks/alignment spine/mounting wall,
  top-duct root/scoop, all door-duct corners, each swept bed duct root, and all
  bed-duct wall corners
- Internal edge/material-strip inventory reviewed: all structural sheets,
  end walls, hook bands, rear drops, spine, top-duct roots, and duct walls are
  at least `3 mm`; no subtractive cuts are present
- Section locations reviewed: door-side seam at the first end, width midpoint,
  and opposite end; bed-side front root plane through all five swept ducts
- Post-subtraction checks: redirectors have no subtractive geometry; the
  reference mockup's single vent recess retains a solid backing
- Unexpected positive-volume shells: none; each exported STL is one
  edge-connected component with watertight two-triangle edge incidence
- Export identity reviewed: each installed STL was import-rendered separately;
  the bed-side STL contains all five enclosed outlet ducts
- Slicer layer-path review: unavailable; no supported slicer executable was
  installed in the local environment
- Intentional disconnected geometry: the two manifest objects are independent
- Test coupon or draft print: not yet printed
- Result: unverified pending slicer review and physical rail-fit coupon
