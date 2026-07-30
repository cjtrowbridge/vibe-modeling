# Rev 0001 Multipart Assembly Review

- Design/config: `cyberdeck-2`, `designs/cyberdeck-2/configs/rev_0001.json`
- Product: `cyberdeck_2_product`
- Config SHA-256:
  `6c7d709591c9359da1119626386aa6de1f91eb111b5081dc7504d767f3acd860`
- Parts SHA-256:
  `c2470a109124d57db0d4d0ad030a21eee9eeec9dcbe635554581ab225225aca8`
- Assembly SHA-256:
  `4936443d05871a063ae354005ae4453a4dcb5a21eface18336d3a1fcf0c1ced1`
- Source SHA-256:
  `6570ae5c13fcb337aa816b7688bd61fc0f5a924f1bd62fdbfcbefcfdc7cf66aa`
- Installed build-manifest SHA-256:
  `5faa0e62fb5e1620f3e79da673d7547beb4e36d8460625c304c2592b0dbddff7`
- Assembly-review manifest SHA-256:
  `683469cdb01ce664d3b55980181ca0fbe1f7591bfee08d1a7954d59e50d1eed8`
- Generated Git state: commit `e653631c37a620346af19f854f37c522b968d2bd`, dirty candidate

## Findings

| Area | Evidence | Result |
|---|---|---|
| hierarchy | exploded and isolated leaf views show exactly two printable leaves | PASS |
| exterior footprint | top, bottom, side, and leaf views show planar outer faces with no projecting seam bumpouts | PASS |
| front receiver | front/isometric views show the unobstructed 2U insertion bay and twelve insert bores | PASS |
| rear closure | rear, side, isometric, and leaf views show an uninterrupted integral rear | PASS |
| rack positions | front view and rack-insert section show six canonical blind bores per rail | PASS |
| seam stations | top/bottom crops and four orthographic sections show one internal joint at every split corner | PASS |
| head/nut recesses | four dedicated installed-artifact crops show complete circular head recesses and complete hexagonal nut recesses at top/bottom and front/rear, each with a centered through-passage | PASS |
| joint load path | sections show layered flanges, 3 mm root webs, and annular compression lands across the 0.3 mm general clearance | PASS |
| device envelope | proxy and sections preserve the 222.25 x 88.90 mm opening and generic 220 mm body envelope | PASS geometrically |
| lower supports | support-rail section and assembly views show two full-depth rails tied into side walls, front rails, and rear wall | PASS |
| rear/service fit | specific connector, cable, airflow, and service envelopes are unknown | UNVERIFIED |

The compression land is intentionally local to each fastener. It provides
clamped contact around the 3.6 mm passage while retaining the 0.3 mm general
layer clearance elsewhere. The land has exactly 3 mm radial material around the
passage. The lower rails are 3 mm thick, 20 mm wide, 215 mm deep, overlap the
maximum device footprint by 3 mm, and positively intersect both end structures
and their exterior side walls.

## Installed Printable Artifacts

- Exact set: `2 STL + 34 PNG = 36` modeled artifacts; audit PASS.
- Left STL SHA-256:
  `7cb0a5a0b116fa1ed35b996dffeff6d1fc48765e23f11f07b4abae0d1ca2e2c6`
- Right STL SHA-256:
  `d4056d49e2ccdfa77209b5ae91f9f62a086d5489e23d3fca25a392209d1c4ffd`
- Left and right print spans: `121.3 x 215.0 x 134.8 mm` each.
- Both leaves are simple 3D objects and report one bounded connected solid plus
  exterior volume in the OpenSCAD CGAL report.

## Artifact-Bound Assembly Set

- Exact set: `22 PNG + 1 STL = 23` review artifacts; audit PASS.
- Manifest binds the exact installed build-manifest and both installed STL
  hashes above.
- Combined product STL:
  `output/cyberdeck-2/cyberdeck_2_assembled.stl`
- Combined STL SHA-256:
  `e9157ae36bacea8718dca1bd4650aa7ffd6d4f1fa67e73302ffa0d05c70982c3`
- Combined bounds: `[-127, 0, -60.65]` to `[127, 215, 60.65]`;
  span `254 x 215 x 121.3 mm`.

The printable and assembly sets coexist in one flat governed directory. The
unified exact set is `3 STL + 56 PNG + 2 manifests = 61 files`; both audits pass
and no staging directory remains.

The seam-opening regression evidence is
`cyberdeck_2_product_top_head_openings.png`,
`cyberdeck_2_product_top_nut_openings.png`,
`cyberdeck_2_product_bottom_head_openings.png`, and
`cyberdeck_2_product_bottom_nut_openings.png`. These installed renders were
reviewed at original resolution; no crescent or shell-filled opening remains.

## Acceptance and Limits

Canonical decomposition, artifact integrity, assembly transforms, flush exterior
faces, rear closure, rack-hole count/placement, seam geometry, rail load paths,
structural minima, and print bounds pass for this exact candidate. Slicer layers,
support behavior, calibrated insert/nut/joint fit, specific-device fit, and
physical loading remain unverified. The candidate is not an immutable or
fabrication-ready revision.
