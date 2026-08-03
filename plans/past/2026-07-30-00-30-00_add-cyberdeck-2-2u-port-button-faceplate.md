---
plan_id: 2026-07-30-00-30-00_add-cyberdeck-2-2u-port-button-faceplate
title: Add Cyberdeck-2 2U Port and Button Faceplate
summary: Add a removable front-biased 2U cover plate and protected recessed opening in the remaining upper roof.
status: past
created_at: 2026-07-30-00-30-00
---

# Add Cyberdeck-2 2U Port and Button Faceplate

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Interface Contract

Create a separate assembled `254 x 88.90 mm` (2U) port/button faceplate over the remaining
flat upper roof. The declared 220 mm printer-axis limit requires two printable
`127 x 88.90 mm` leaves: a left leaf with a 3 mm center tongue and a right leaf
with a 1 mm-clearance receiving socket. Place it forward-biased from the roof's `Y = 100.732 mm` edge,
ending before the seam screw at `Y = 200 mm`. It may overlap the solid seam-block
region but must not cover, cut, or obstruct the head recess/tool path.

The fixed chassis opening beneath it is deliberately smaller than 2U: preserve a
minimum 3 mm support lip on the left, right, and front; reserve a larger rear lip
so the opening keeps a full 3 mm structural margin from the seam block beginning
at `Y = 188 mm`. The faceplate is therefore a standard 2U exterior component,
not a claim of a full 2U receiver opening.

## Checklist

- [x] Define two printable faceplate leaves, their assembled 2U exterior bounds, 3 mm registration tongue, 1 mm socket clearance, and M3 mounting
  strategy, installation direction, washer/tool envelopes, and `BLOCKED_UNKNOWN`
  port/button cutout geometry pending actual chosen hardware.
- [x] Add named chassis-opening/lip/plate-overlap parameters and assertions for
  3 mm wall, structural overlap, opening-to-seam margin, screw-head tool access,
  and all post-cut ligaments.
- [x] Cut the bounded fixed-chassis opening and add continuous support rails/lips
  with positive overlap into the roof and side structure; preserve all screen,
  lower-receiver, and seam interfaces.
- [x] Add both faceplate leaves as third and fourth authoritative printable parts and logical
  assembly member, with a defined transform and installation/removal path.
- [x] Defer port/button cutouts until dimensions, mounting hardware, cable bends,
  and service access are supplied; do not guess them.
- [x] Add roof-opening, rear seam/tool-access, plate-edge, split-seam, and exploded assembly
  views; inspect all four plate corners and the seam-side rear lip.
- [x] Build/audit the complete multipart manifest and full artifact-bound review
  in `output/cyberdeck-2/`; validate contracts, reference data, bounds, and
  connectivity; update docs/journal, archive plan, and commit the checkpoint.

## Acceptance

The design contains a removable standard-size 2U plate supported on a protected
recessed roof opening. The chassis retains at least 3 mm material around the
opening and before the rear seam block; the Y=200 seam screw/head recess stays
visible and tool-accessible. Ports and buttons are intentionally absent until
their exact interfaces are known.

## Execution Record

- Approved split amendment: the 254 mm assembled plate is two 127 mm printable
  leaves because the configured printer axis is 220 mm.
- Complete manifest build and audit: PASS; 4 printable STL + 68 printable PNG.
- Full artifact-bound assembly review and audit: PASS; 1 combined STL + 31 PNG.
- Unified canonical output: PASS; 5 STL + 99 PNG + 2 manifests = 106 files.
- Installed-artifact review: PASS for the roof opening, plate center seam, and
  rear seam-head/tool-access crops.
