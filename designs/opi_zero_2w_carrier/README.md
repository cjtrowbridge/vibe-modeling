# opi_zero_2w_carrier

Parametric Orange Pi Zero 2W mounting plate.

## What it does

- Builds a flat rectangular base plate (`2.0 mm` default thickness)
- Places 4 studs at the board mounting-hole pattern (`58 x 23`, `3.5 mm` inset)
- Adds M3 clearance holes through studs and base
- Adds underside counterbores so screw heads sit flush with the base underside

## Part IDs

- `part_id = 0`: base plate with studs
- `part_id = 1`: board mockup
- `part_id = 2`: assembly preview

## Notes

- Mount pattern values in `defaults.scad` came from the supplied `Opi ZERO 2W TOP.dxf` footprint extraction.
- This is a mechanical holder model only; it is not an electrical carrier PCB design.
