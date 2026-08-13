# Rev 0001 Fastener and Structure Report

## Removable Top Plate (Mutable Candidate)

| Item | Resolved geometry | Status |
| --- | --- | --- |
| Plate exterior | 254 x 88.90 x 3 mm assembled, split into two 127 mm printable leaves | PASS geometrically |
| Leaf registration | 3 mm positive tongue overlap, 1 mm socket sliding clearance | PASS geometrically |
| Retention hardware | Twelve M3 3.6 mm clearance holes, six per side at canonical 2U stations | Candidate; hardware stack unverified |
| Roof rails | 16 mm retained rails with local 8.9 mm-deep underside nut lands | Candidate; post-cut sections unverified |
| Opening lips | 3 mm front lip and 3 mm margin before seam block | PASS geometrically |
| Rear seam access | plate ends Y=189.632; head recess/tool envelope begins no earlier than Y=195.875 | PASS geometrically |
| Port/button geometry and physical FDM hardware fit | No chosen component or print calibration | BLOCKED_UNKNOWN |

## Flush Four-Station Seam Joint

The former external bumpouts are gone. The chassis now spans
`Z = -62.25 to +62.25 mm` with planar top and bottom plates. Four vertical M3
joints occupy only the 17.8 mm structural/service zones outside the preserved
`Z = -44.45 to +44.45 mm` device envelope.

Stations are centered at `X = -8.0`, at front/rear `Y = 12.0 and 200.0 mm`.
Top fasteners install downward from the top exterior; bottom fasteners install
upward from the bottom exterior. Every 8.25 mm head/washer recess is 3.8 mm deep,
so installed hardware remains below the planar exterior. Captive 5.9 mm AF nut
recesses open into the empty equipment bay for installation before the device.

The left leaf has an 18 mm-wide enclosed receiver.  Its complete 8.25 mm head
recess, through-passage, and nut recess remain in that printable leaf: the head
recess has 3.875 mm material to the `X = 0` split and 5.875 mm to the receiver's
outer edge.  The right leaf supplies a 14 mm tongue insertion plus a 3 mm
root-overlap block, so the 3.6 mm passage clamps both leaves rather than merely
passing through the receiver.  Dedicated left-leaf crops show complete circular
head recesses at the front and rear top stations; all four stations are generated
from the same named geometry. Physical hardware and driver access remain
unverified.

## Captured Tongue-and-Socket Stack

| Feature | Value | Governing residual |
|---|---:|---:|
| total service/plate stack | 17.8 mm | outside 2U bay |
| exterior head wall | 6.8 mm | 3.0 mm behind head recess |
| socket clearance above tongue | 1.0 mm | fit allowance, not structure |
| left receiver width | 18.0 mm | 3.0 mm minimum outer/split edge assertions |
| right-leaf tongue insertion | 14.0 mm | 3.0 mm root overlap in right leaf |
| socket clearance below tongue | 1.0 mm | fit allowance, not structure |
| bay-facing nut wall | 6.0 mm | 3.2 mm behind nut recess |
| socket front/rear walls | 3.0 mm each | structural minimum |
| socket closed end | 3.0 mm | structural minimum |
| through-hole | 3.6 mm | 4.2 mm to tongue closed end; 6.2 mm to split |
| head/washer recess | 8.25 x 3.8 mm | 3.875 mm split; 5.875 mm outer receiver margin |
| captive-nut recess | 5.9 mm AF x 2.8 mm | at least 3 mm split/outer receiver assertions |
| candidate screw | M3 x 14 mm | flush with the service-zone bay boundary |

At every station the right tongue enters 14 mm through the center seam into a
15 mm-deep receiver cavity, leaving 1 mm fit clearance at the closed end. The
tongue is 16 mm deep inside an 18 mm receiver cavity, leaving 1 mm on each
front/rear face. The left receiver is closed on the exterior, bay-facing,
front, rear, and closed-end faces; only the center-seam mouth remains open for
lengthwise assembly. The right tongue is rooted through a 3 mm full-height block
that positively overlaps its leaf's service structure.

## Main-Chamber 2U Through-Bolt Rails

The main-chamber face now uses two 3 mm-deep rails around the exact
`222.25 x 88.90 mm` opening. Each canonical station is a 3.6 mm through-passage,
not a blind insert bore. A local land extends 5.8 mm into the chamber at each
hole: it overlaps the face rail through the full 3 mm wall and contains a
chamber-open 2.8 mm-deep hex M3 nut pocket. Nuts insert from the open chamber;
the screw is driven from the exterior.

The proposed stack is an M3 x 8 low-profile button-head screw and captive M3
nut, without an ISO 7089 washer at the canonical end stations. A 7 mm washer
would leave only 2.85 mm to the 2U opening there, below the host's 3 mm minimum;
the low-profile head keeps 3.5 mm at that location. Final head diameter,
driver envelope, print calibration, and a physical nut-fit coupon remain
`BLOCKED_UNKNOWN`.

## Device Rails and Load Paths

Each 3 x 20 mm lower shelf runs continuously from front to rear. Its outer 3 mm
intersects the corresponding side wall; its front and rear ends also intersect
the full-height front rail and integral rear wall. The shelf extends 3 mm under
the maximum 220 mm device footprint. This supplies continuous side support plus
positive-volume endpoint supports rather than relying only on the rack ears.

Production assertions pass for walls, fascia/rail overlap, socket walls,
tongue root, closed-end clearance, head/nut margins, screw reach, bay keepout,
and transformed print bounds. Physical nut/head fit, sliding clearance,
tightening torque, material creep, shock loading, rail contact, and device load
distribution remain unverified.

## Angled Screen Rail and Support Load Paths

The 45-degree screen interface has two 15.875 mm-wide face rails with the same
six-position M3 pattern as the lower 2U receiver. The current candidate replaces
the former 7 mm blind insert bores with 3.6 mm through-holes in a 3 mm face
flange, preserving the full `222.25 x 88.90 mm` aperture. A chamber-side nut,
washer, driver, and insertion stack has not yet been designed or verified, so
this interface remains structurally and serviceability unverified.

At each outer edge, a 3 mm side support wall runs from the face to the 50.8 mm
rear envelope. It overlaps the corresponding 3 mm existing chassis side wall by
more than 3 mm below the lower chassis top, and it overlaps the face rail by 3 mm
across the full local 2U height. Thus every face rail has two continuous structural
support paths: its outer support wall and the lower chassis side wall. No roof,
upper rear panel, or centre web is claimed as structural support.

## 2026-08-12 Upper Exterior Wall Recovery (Mutable Candidate)

The left and right upper exterior side-wall profiles now continue from the
horizontal roof-front datum to `screen_rack_base_y`, closing the triangular
outside-wall gaps left by the prior rectangular-only replacement.  Each profile
is a named 3 mm exterior skin; it is not the removed full wedge/infill, and the
screen-rail rear hardware remains independently modeled inboard.

Assertions require the 3 mm wall thickness, rear-wall engagement at the
roof-front datum, and a meaningful (at least 3 mm) forward transition.  The
complete printable build passes, but the new left/right wall crops and full
artifact-bound assembly review have not yet completed in this environment.
Accordingly, roof/lower-support overlap after every subtraction, screen
nut/driver clearance, and the changed wall's complete structural verification
remain `UNVERIFIED`; this candidate is not fabrication-ready.

## 2026-08-12 High-Roof Lock and Lower Screen-Hardware Recovery

The high-roof lock's M3 through passage and 8.25 mm head/washer seat are now
also cut from the master roof shell.  Previously, those cuts existed only in
the separate lock receiver, allowing the continuous roof solid to cover the
hole after union.  The lock height is now 18 mm, leaving the 8.25 mm head seat
plus three independent 3 mm material bands by assertion; the other four seam
stations are unchanged.

Its longitudinal seam geometry now deliberately matches all four standard
stations: an 18 mm receiver from `X = -18..0`, a 14 mm tongue insertion from
`X = -14`, a 3 mm tongue root across the seam, 1 mm closed-end clearance, and
the M3 axis at `X = -8 mm`. The high roof changes only the lock's vertical
placement and 18 mm service-band height. Its captive-nut pocket is inserted
from the lower screen-service cavity, not through the closed-end receiver.

At the lower station on each angled-screen rail, a bounded rear hardware
keepout removes the exterior-wall triangle that obstructed nut/tool approach.
The cut spans only the lowest M3 station's rear approach and preserves the
remaining outer support.  Its depth includes the 5.8 mm local nut land plus a
3 mm tool clearance, and its lower rail ligament is asserted at 3 mm or more.

## 2026-08-12 Side-Wall Perforation and Lock-Thickness Correction

The rectangular lower-hardware keepout was removed after it was shown to cut
through both exterior side skins. The existing rear-open hexagonal M3 nut
pockets remain; no broad rectangular subtraction crosses either 3 mm outer
wall.

The high-roof lock now uses the standard seam's complete 17.8 mm vertical
stack: 6.8 mm head layer, 5 mm socket cavity, and 6 mm nut layer. Its roof-band
depth remains 20 mm, because extending it to the normal 24 mm pad depth would
cross the required 3 mm forward roof-edge margin. Its standard X geometry
(receiver, tongue, clearance, and `X = -8 mm` screw axis) is unchanged.

## 2026-08-13 End-Wall, Flat-Rail, and Angled-Rail-Back Recovery

The two required exterior end-wall fills are restored as named 3 mm
`angled_screen_end_wall_fill()` solids. They are separate from the roof-opening
geometry and must not be confused with the former inboard obstructions.

`merged_roof_opening_cut()` now uses the constant 16 mm flat-rail boundary for
its full length. It no longer tapers from the 3 mm screen margin, so neither
flat-rail end leaves the triangular remnant that blocked a lower angled-screen
M3 station.

Each angled screen rail has its continuous 7 mm rear face restored. Its local
nut lands are 12.8 mm deep: 7 mm continuous rail back, 2.8 mm hex recess, and
3 mm retained material behind the recess. The recess cutter is limited to the
2.8 mm nut depth. The complete printable manifest build and installed audit
pass; rail-joint engagement and full artifact-bound assembly review remain
`UNVERIFIED`.
