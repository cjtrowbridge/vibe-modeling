---
plan_id: 2026-07-30-00-30-00_add-cyberdeck-2-2u-port-button-faceplate
title: Add Cyberdeck-2 2U Port and Button Faceplate
summary: Add a removable front-biased 2U cover plate and protected recessed opening in the remaining upper roof.
status: future
created_at: 2026-07-30-00-30-00
---

# Add Cyberdeck-2 2U Port and Button Faceplate

Key: `[ ]` pending task, `[x]` completed task, `[?]` needs validation, `[-]` closed task

## Interface Contract

Create a separate `254 x 88.90 mm` (2U) port/button faceplate over the remaining
flat upper roof. Place it forward-biased from the roof's `Y = 100.732 mm` edge,
ending before the seam screw at `Y = 200 mm`. It may overlap the solid seam-block
region but must not cover, cut, or obstruct the head recess/tool path.

The fixed chassis opening beneath it is deliberately smaller than 2U: preserve a
minimum 3 mm support lip on the left, right, and front; reserve a larger rear lip
so the opening keeps a full 3 mm structural margin from the seam block beginning
at `Y = 188 mm`. The faceplate is therefore a standard 2U exterior component,
not a claim of a full 2U receiver opening.

## Checklist

- [ ] Define a new printable faceplate leaf, its 2U exterior bounds, M3 mounting
  strategy, installation direction, washer/tool envelopes, and `BLOCKED_UNKNOWN`
  port/button cutout geometry pending actual chosen hardware.
- [ ] Add named chassis-opening/lip/plate-overlap parameters and assertions for
  3 mm wall, structural overlap, opening-to-seam margin, screw-head tool access,
  and all post-cut ligaments.
- [ ] Cut the bounded fixed-chassis opening and add continuous support rails/lips
  with positive overlap into the roof and side structure; preserve all screen,
  lower-receiver, and seam interfaces.
- [ ] Add the faceplate as a third authoritative printable part and logical
  assembly member, with a defined transform and installation/removal path.
- [ ] Defer port/button cutouts until dimensions, mounting hardware, cable bends,
  and service access are supplied; do not guess them.
- [ ] Add roof-opening, rear seam/tool-access, plate-edge, and exploded assembly
  views; inspect all four plate corners and the seam-side rear lip.
- [ ] Build/audit the complete multipart manifest and full artifact-bound review
  in `output/cyberdeck-2/`; validate contracts, reference data, bounds, and
  connectivity; update docs/journal, archive plan, and commit the checkpoint.

## Acceptance

The design contains a removable standard-size 2U plate supported on a protected
recessed roof opening. The chassis retains at least 3 mm material around the
opening and before the rear seam block; the Y=200 seam screw/head recess stays
visible and tool-accessible. Ports and buttons are intentionally absent until
their exact interfaces are known.
