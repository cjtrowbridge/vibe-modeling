# Comrade core base

The first printable structural component for the progressive modular **Comrade** robot: a flat base plate that supports the [battery holder](https://amzn.to/4weQo6L), Raspberry Pi 5, and NVMe HAT stack with LLM 8850 while reserving four independently accessible outer mounting points for later modules.

## Revision 0001 interface record

Coordinate datum: the lower-left inner mounting-hole centre is `[0, 0, 0]`; x runs along the 81 mm hole spacing and y runs along the 49 mm hole spacing. The plate bottom is `z = 0`.

| Value | Classification | Source / confidence |
| --- | --- | --- |
| Inner mounting pattern: 81 x 49 mm | Measured / user-provided | High confidence |
| Electronics stack reference height: about 100 mm | User-provided, includes clearance | Reference only; does not drive base geometry |
| Plate extension: 15 mm per side | Approved design choice | Replaces the initial 10 mm request because two recessed M3 patterns need 3 mm material ligaments |
| M3 clearance hole: 3.4 mm | Provisional print-fit allowance | Needs validation on the intended printer/material |
| Counterbore: 6.5 mm diameter x 3.2 mm deep | Approved socket-head hardware envelope | Confirm against the actual screw-head diameter before printing |
| Plate thickness: 7 mm | Approved design choice | Leaves 3.8 mm below each counterbore |

The stack mounts through the **four inner holes** using screws inserted from the bottom; their counterbores are on the bottom face. The four **outer holes** are inset 7 mm from the plate edges, at the four corners, and have counterbores on the top face for screws inserted downward by future modules.

The 15 mm extension produces a `111 x 79 mm` plate. It is intentional: a 10 mm extension cannot place full M3 head recesses beside the inner hole pattern without violating the 3 mm edge/ligament contract.

## Structural verification record

- Source revision/config: `rev_0001` / `configs/rev_0001.json`
- Minimum wall thickness: 3 mm
- Minimum structural overlap: 3 mm (no assembled structural joins in this monolithic plate)
- Minimum internal edge width: 3 mm
- Fastener inventory: four underside-recessed inner M3 holes; four top-recessed outer M3 holes
- Model checks passed during the `rev_0001` build: 3.8 mm counterbore floors, 3.75 mm outer counterbore edge margins, and about 4.81 mm projected ligament between opposing inner and outer counterbores.
- Installed-artifact review: the top and bottom isometric views show the recesses on their specified opposite faces. The final artifact set contains one connected monolithic plate by source construction; no intentionally separate geometry exists.
- Physical fit and slicer layer-path review: unverified. Confirm the actual M3 head envelope and slice the STL using the intended printer/material/profile before fabrication.
- Intentional disconnected geometry: none.

## Build

```powershell
python scripts/scad_build.py --design comrade --config designs/comrade/configs/rev_0001.json
```

This is a single-part design, so it does not use a multipart `parts.json` manifest.
