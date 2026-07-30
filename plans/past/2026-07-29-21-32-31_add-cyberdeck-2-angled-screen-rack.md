---
plan_id: 2026-07-29-21-32-31_add-cyberdeck-2-angled-screen-rack
title: Add Cyberdeck-2 45-Degree Shallow 2U Screen Rack
summary: Add an open-roof, shallow 2U screen receiver at 45 degrees on the rearward end of the current enclosure.
status: past
created_at: 2026-07-29-21-32-31
---

# Add Cyberdeck-2 45-Degree Shallow 2U Screen Rack

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Direction and Scope Assumption

For this change, the existing integral closed wall at model `Y = 215 mm` is the
user-facing **front**. The existing open receiver end at model `Y = 0` is the
**back**. The screen rack will sit as close as possible to that open/back end,
with its 45-degree face oriented toward the closed/user-facing end. “Behind the
screen” means the face-normal depth on the back side of that face.

The screen rack is a shallow 2U **screen interface**, not yet a complete second
equipment receiver. Its local face preserves the ten-inch 2U width/height
envelope and M3 rail pattern; final screen panel, connectors, roof, and lid are
explicitly out of scope. The roof and upper rear closure remain intentionally
open for a later separately planned part.

## 1. Establish the Screen-Rack Contract

- [x] 1.1 Preserve the existing lower receiver: its `254 mm` outer width,
  `222.25 x 88.90 mm` exact opening, 215 mm exterior depth, rear closure,
  lower rails, insert-bores, two-leaf split, and captured center seam.
- [x] 1.2 Define a face-local 2U screen rack with the same 254 mm outer width,
  222.25 mm clear span, 88.90 mm face-local U height, and two M3 mounting
  columns; distinguish its screen-panel aperture and mounting pattern from the
  lower receiver's device bay.
- [x] 1.3 Define a 45-degree face profile and a `50.8 mm` maximum face-normal
  rear clearance envelope. Derive its horizontal/vertical projections,
  location against the model-Y back end, face thickness, opening margins, and
  screen hardware keepouts from named parameters.
- [x] 1.4 State the intentional open boundaries: no top roof, no upper rear
  panel, and no claim of weather, dust, or accidental-contact enclosure until a
  later roof/lid plan supplies that separate part.

## 2. Model the Two-Piece Angled Structure

- [x] 2.1 Extend each printable chassis half with the corresponding half of the
  45-degree face, local 2U rails, face frame, and shallow side/support walls;
  retain the longitudinal split and avoid creating an ungoverned third leaf.
- [x] 2.2 Place the screen rack at the model-Y back end without protruding past
  the 215 mm lower-chassis footprint unless a named, approved projection is
  required; preserve the lower receiver insertion/removal envelope.
- [x] 2.3 Form the 45-degree foot, side-wall, face-frame, and base attachments
  as continuous profiles or deliberate positive-volume overlaps of at least
  3 mm. Give every span two verified support endpoints.
- [x] 2.4 Keep the screen rack upper roof area deliberately open while closing
  only the walls required to carry the face and preserve the claimed shallow
  rear-clearance envelope.

## 3. Screen and Rack Interfaces

- [x] 3.1 Add a face-normal screen aperture, screen mounting holes, and rails
  with named 3 mm minimum ligaments to every edge, neighboring hole, and 2U
  mounting column; do not reuse the other Cyberdeck's provisional 210 x 87 mm
  opening without re-deriving it for the exact 88.90 mm local face envelope.
- [?] 3.2 Preserve access to M3 heads/nuts or heat-set inserts and define
  screen-panel installation direction, cable exit/service space, and the 50.8
  mm behind-screen keepout. Mark exact screen hardware and cable-bend geometry
  `BLOCKED_UNKNOWN` until supplied.
- [x] 3.3 Declare a logical angled-screen subassembly and its interface IDs in
  `assembly.json`; retain the two existing printable leaf identities unless a
  new decomposition is explicitly needed.

## 4. Structural, Fit, and Print Verification

- [x] 4.1 Add assertions for 45-degree rise/run, face-local 2U dimensions,
  shallow-depth envelope, 3 mm wall/overlap/throat/ligament minima, screen and
  rack-hole pairwise margins, base engagement, and transformed print bounds.
- [x] 4.2 Add governed face, side-profile, base-foot, screen-mount, open-roof,
  and exploded assembly views. Inspect both ends and midpoint of each angled
  join and the complete screen installation/removal path.
- [x] 4.3 Verify that the updated leaves remain within the 220 mm printer axis
  limit in their required print orientations; create a derived coupon plan if
  screen-frame, 45-degree foot, or insert fit is not physically validated.

## 5. Build, Review, and Checkpoint

- [x] 5.1 Rebuild the full two-part printable manifest and full assembly review
  through the normal pipeline into only `output/cyberdeck-2/`.
- [x] 5.2 Pass the ten-inch-rack reference validator, assembly contract,
  OpenSCAD assertions, exact unified artifact audits, bounds/connectivity
  checks, and real-artifact visual review.
- [x] 5.3 Update the Cyberdeck-2 README, rack/depth and structural reports,
  validation log, assembly review, journal, and plan indexes with exact
  geometry, open-roof scope, hashes, and physical/slicer limitations.
- [x] 5.4 Archive this plan, review the complete diff, commit all approved
  changes, and push only when requested.

## Planned Files

- `designs/cyberdeck-2/configs/rev_0001.json`
- `designs/cyberdeck-2/src/lib/defaults.scad`
- `designs/cyberdeck-2/src/parts/enclosure_blockout.scad`
- `designs/cyberdeck-2/assembly.json`
- `designs/cyberdeck-2/docs/*.md`
- `journal/2026-07-29.md`
- this plan and plan indexes

## Acceptance

The current enclosure retains its complete lower receiver functionality. A
two-piece, 45-degree, shallow 2U screen interface rises from the model-Y back
end, faces the closed/user-facing front, and has no more than 50.8 mm of
face-normal behind-screen clearance. The screen face, rails, and supports have
documented 3 mm structural material/overlap after all cuts. The upper roof area
is visibly and intentionally open, with no claim that it is enclosed until the
future roof piece exists.
