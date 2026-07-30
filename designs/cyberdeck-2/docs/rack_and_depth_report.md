# Rev 0001 Rack and Depth Report

## Selected Reference

- Specification: `ten-inch-rack-m3-printed-design-spec` v2.0.0
- Bundle manifest SHA-256:
  `330051136930b54f0abf91ff81ea217d0e6cad2dbe6503375ffb219e59e0210d`
- Reference validation: passed; rack depth remains specification-level unknown
  and is resolved here only by the printer limit.

## Requirement Matrix

| Requirement | Candidate | Result |
|---|---:|---|
| front width | 254.0 mm | PASS |
| clear equipment width | 222.25 mm | PASS |
| maximum generic body width | 220.0 mm | PASS, 2.25 mm total clearance |
| 2U clear height | 88.90 mm | PASS |
| rail-hole column spacing | 236.525 mm | PASS |
| hole sequence | 15.875 / 15.875 / 12.700 mm | PASS |
| M3 insert positions | 6 per rail, 12 total | PASS |
| insert bore | 4.0 mm finished, 7.0 mm blind depth | PROVISIONAL |
| minimum wall/material width | 3.0 mm | PASS analytically |

Hole centers are at `X = +/-118.2625 mm` and
`Z = -38.100, -22.225, -6.350, 6.350, 22.225, 38.100 mm`.
With a 4.0 mm bore, the minimum hole-to-hole ligament is 8.7 mm. Horizontal
material from a bore to the rail edges is 5.1375 mm inward and 6.7375 mm
outward. The minimum vertical bore-to-clear-opening material is 4.35 mm.
The 10 mm rail depth leaves 3 mm behind each 7 mm blind bore.

## Depth Budget

| Interval | Depth |
|---|---:|
| outer enclosure | 215.0 mm |
| integral rear wall | 3.0 mm |
| internal front-to-rear interval | 212.0 mm |
| front/rear reserved service depth | 0 / 0 mm |
| generic front/rear fit allowance | 0.5 / 0.5 mm |
| generic proxy depth | 211.0 mm |

The enclosure uses the established 220 mm printer axis with 5 mm reserve. A
specific device may require additional connector, cable-bend, airflow, or
service depth; those inputs are `BLOCKED_UNKNOWN` and may reduce the 211 mm
generic device allowance.
