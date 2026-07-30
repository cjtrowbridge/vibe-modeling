# Rev 0001 Fastener and Structure Report

## Flush Four-Station Seam Joint

The former external bumpouts are gone. The chassis now spans
`Z = -60.65 to +60.65 mm` with planar top and bottom plates. Four vertical M3
joints occupy only the 16.2 mm structural/service zones outside the preserved
`Z = -44.45 to +44.45 mm` device envelope.

Stations are centered at `X = 0`, at front/rear `Y = 9.0 and 202.7 mm`.
Top fasteners install downward from the top exterior; bottom fasteners install
upward from the bottom exterior. Every 8.25 mm head/washer recess is 3.8 mm deep,
so installed hardware remains below the planar exterior. Captive 5.9 mm AF nut
recesses open into the empty equipment bay for installation before the device.

## Layered Joint Stack

| Feature | Value | Governing residual |
|---|---:|---:|
| total service/plate stack | 16.2 mm | outside 2U bay |
| right-leaf head flange | 6.8 mm | 3.0 mm behind head recess |
| inter-layer assembly clearance | 0.3 mm | bridged at screw by compression land |
| left-leaf captive-nut flange | 9.1 mm | 6.3 mm behind nut recess |
| through-hole | 3.6 mm | 3.0 mm at crossed head edge |
| head/washer recess | 8.25 x 3.8 mm | 4.875 mm depthwise margin |
| captive-nut recess | 5.9 mm AF x 2.8 mm | 5.594 mm depthwise margin |
| candidate screw | M3 x 12 mm | 0.4 mm before 2U bay |

The right head flange crosses 7.8 mm into a left-plate clearance pocket. The
left nut flange crosses the same distance in the opposite layer and is tied back
to its exterior plate by a 3 mm vertical root web. A 9.6 mm-diameter, 0.3 mm-high
annular compression land bridges the general layer clearance directly around
the 3.6 mm through-hole. It retains exactly 3 mm radial material and gives the
vertical screw a positive clamping contact without sacrificing fit clearance
across the rest of the overlapping flanges.

## Device Rails and Load Paths

Each 3 x 20 mm lower shelf runs continuously from front to rear. Its outer 3 mm
intersects the corresponding side wall; its front and rear ends also intersect
the full-height front rail and integral rear wall. The shelf extends 3 mm under
the maximum 220 mm device footprint. This supplies continuous side support plus
positive-volume endpoint supports rather than relying only on the rack ears.

Production assertions pass for walls, rail thickness/overlap, joint-layer
residuals, root width, head/nut margins, screw reach, bay keepout, and transformed
print bounds. Physical nut/head fit, tightening torque, material creep, shock
loading, rail contact, and device load distribution remain unverified.
