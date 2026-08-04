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

Stations are centered at `X = -3.9`, at front/rear `Y = 12.0 and 200.0 mm`.
Top fasteners install downward from the top exterior; bottom fasteners install
upward from the bottom exterior. Every 8.25 mm head/washer recess is 3.8 mm deep,
so installed hardware remains below the planar exterior. Captive 5.9 mm AF nut
recesses open into the empty equipment bay for installation before the device.

The left leaf owns each complete head recess, through-passage, and nut recess;
the right tongue owns its complete through-passage. These cuts are also applied
to the overlapping left shell so the later union cannot refill any portion of
an opening. Dedicated installed-artifact crops verify complete circular head
recesses and complete hexagonal nut recesses at all four stations.

## Captured Tongue-and-Socket Stack

| Feature | Value | Governing residual |
|---|---:|---:|
| total service/plate stack | 17.8 mm | outside 2U bay |
| exterior head wall | 6.8 mm | 3.0 mm behind head recess |
| socket clearance above tongue | 1.0 mm | fit allowance, not structure |
| right-leaf tongue | 3.0 mm | structural minimum |
| socket clearance below tongue | 1.0 mm | fit allowance, not structure |
| bay-facing nut wall | 6.0 mm | 3.2 mm behind nut recess |
| socket front/rear walls | 3.0 mm each | structural minimum |
| socket closed end | 3.2 mm | structural minimum |
| through-hole | 3.6 mm | 6.2 mm depthwise material in tongue |
| head/washer recess | 8.25 x 3.8 mm | 7.875 mm front/rear margin |
| captive-nut recess | 5.9 mm AF x 2.8 mm | 8.594 mm front/rear margin |
| candidate screw | M3 x 14 mm | flush with the service-zone bay boundary |

At every station the right tongue enters 7.8 mm through the center seam into a
left receiver cavity that is 8.8 mm deep, leaving 1 mm at the closed end. The
tongue is 16 mm deep inside an 18 mm cavity, leaving 1 mm on each front/rear
face. The left receiver is closed on the exterior, bay-facing, front, rear, and
closed-end faces; only the center-seam mouth remains open for lengthwise
assembly. The right tongue is rooted through a 3 mm full-height block that
positively overlaps its leaf's service structure.

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
