# Rev 0001 Multipart Assembly Review

- Design/config: `cyberdeck-2`, `designs/cyberdeck-2/configs/rev_0001.json`
- Product: `cyberdeck_2_product`
- Config SHA-256:
  `c4f8051f4b3842b781d7daaab4adfe86a734440f7d0cf88da1c89d5f93143692`
- Parts SHA-256:
  `c2470a109124d57db0d4d0ad030a21eee9eeec9dcbe635554581ab225225aca8`
- Assembly SHA-256:
  `f66d5c282a636922223fb5545a503c7f47b5481b55d395187c9a2319cf6d7592`
- Source SHA-256:
  `48b18be4fa9e656e3face8ea127f1c3054728187c949b74181fce9cad3a75bdc`
- Installed build-manifest SHA-256:
  `0ee51d5094473d19ebcbee365ea0492f3ba1e04e90099deb236c2a22337d5871`
- Assembly-review manifest SHA-256:
  `f2cfac5ce17e07a612c6185443a5888c8ae74bb23152c321b4d307fa11a54b91`
- Generated Git state: commit `bded770a42bce24f6677ffabaddc4f05f4588472`, dirty candidate

## Findings

| Area | Evidence | Result |
|---|---|---|
| hierarchy | exploded and isolated leaf views show exactly two printable leaves | PASS |
| exterior footprint | top, bottom, side, and leaf views show planar outer faces with no projecting seam bumpouts | PASS |
| front receiver | front-fascia section shows a continuous 3 mm top/bottom frame outside the unobstructed 222.25 x 88.90 mm insertion bay and twelve insert bores | PASS |
| rear closure | rear, side, isometric, and leaf views show an uninterrupted integral rear | PASS |
| rack positions | front view and rack-insert section show six canonical blind bores per rail | PASS |
| seam stations | exploded, leaf, top/bottom crops, and four orthographic sections show a right tongue entering a left closed-end receiver at every split corner | PASS |
| head/nut recesses | four dedicated installed-artifact crops show complete circular head recesses and complete hexagonal nut recesses at top/bottom and front/rear, each with a centered through-passage | PASS |
| joint load path | sections show 3 mm tongue roots, 3 mm socket front/rear/closed-end walls, 1 mm fit clearance, and head/tongue/nut clamping layers | PASS geometrically |
| device envelope | proxy and sections preserve the 222.25 x 88.90 mm opening and generic 220 mm body envelope | PASS geometrically |
| lower supports | support-rail section and assembly views show two full-depth rails tied into side walls, front rails, and rear wall | PASS |
| rear/service fit | specific connector, cable, airflow, and service envelopes are unknown | UNVERIFIED |

Each right-leaf tongue is 3 mm thick and enters 7.8 mm through the seam into an
8.8 mm-deep left-leaf cavity. It has 1 mm clearance at the closed end and 1 mm
on each front/rear and head/nut side. The receiver remains closed on all faces
other than the center-seam insertion mouth. The lower rails are 3 mm thick,
20 mm wide, 215 mm deep, overlap the maximum device footprint by 3 mm, and
positively intersect both end structures and their exterior side walls.

## Installed Printable Artifacts

- Exact set: `2 STL + 34 PNG = 36` modeled artifacts; audit PASS.
- Left STL SHA-256:
  `82a62424882db4bc5adb3dbf1125bbdf9b81b2123c3c5070f00145cfa08bc1be`
- Right STL SHA-256:
  `39788b8ec3fabeb79c54b6a8587c75332e1578b660abfcc958a19c25b949bfb6`
- Left print span: `124.5 x 215.0 x 127.0 mm`; right print span:
  `124.5 x 215.0 x 134.8 mm`.
- Both leaves are simple 3D objects and report one bounded connected solid plus
  exterior volume in the OpenSCAD CGAL report.

## Artifact-Bound Assembly Set

- Exact set: `23 PNG + 1 STL = 24` review artifacts; audit PASS.
- Manifest binds the exact installed build-manifest and both installed STL
  hashes above.
- Combined product STL:
  `output/cyberdeck-2/cyberdeck_2_assembled.stl`
- Combined STL SHA-256:
  `6c424bb0e9254afda88840ad29259f7f4369998def6f467ab86f17c8c034800a`
- Combined bounds: `[-127, 0, -62.25]` to `[127, 215, 62.25]`;
  span `254 x 215 x 124.5 mm`.

The printable and assembly sets coexist in one flat governed directory. The
unified exact set is `3 STL + 57 PNG + 2 manifests = 62 files`; both audits pass
and no staging directory remains.

The seam-opening regression evidence is
`cyberdeck_2_product_top_head_openings.png`,
`cyberdeck_2_product_top_nut_openings.png`,
`cyberdeck_2_product_bottom_head_openings.png`, and
`cyberdeck_2_product_bottom_nut_openings.png`. These installed renders were
reviewed at original resolution; no crescent or shell-filled opening remains.

`cyberdeck_2_product_front_fascia_section.png` confirms the continuous front
frame outside the exact 2U opening and its attachment to both insert rails.

## Acceptance and Limits

Canonical decomposition, artifact integrity, assembly transforms, flush exterior
faces, rear closure, rack-hole count/placement, seam geometry, rail load paths,
structural minima, and print bounds pass for this exact candidate. Slicer layers,
support behavior, calibrated insert/nut/joint fit, specific-device fit, and
physical loading remain unverified. The candidate is not an immutable or
fabrication-ready revision.
