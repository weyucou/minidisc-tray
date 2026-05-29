# Dimension Assumptions & Parameter Overrides

All constants are defined in [`models/src/dimensions.scad`](../../models/src/dimensions.scad).
Edit that file to tune values; re-run `scripts/export.sh` to regenerate the STL.

## Key assumptions

| Constant | Default | Source | Verify against |
|----------|---------|--------|----------------|
| `SPINDLE_TO_BEZEL` | 88 mm | Mid-range of observed 80–95 mm across donor drives | Measure the actual donor drive spindle-to-bezel distance |
| `TRAY_INNER_W` | 126 mm | ~63 mm each side from spindle centre | SFF-8551 / direct measurement |
| `TRAY_INNER_D` | derived | `SPINDLE_TO_BEZEL + 60 + 10` | Adjust rear margin if tray fouls the drive back wall |
| `FIT_CLEARANCE` | 0.4 mm per side | Tuned for AFINIA H400+ FDM default profile | Re-tune if pocket is too loose or too tight |
| `SHUTTER_TAB_X_OFFSET` | 5.0 mm | Approximate from Sony MD spec diagram | Refine against a physical MD cartridge |
| `SHUTTER_TAB_Y_OFFSET` | 4.0 mm | Approximate from Sony MD spec diagram | Refine against a physical MD cartridge |
| `SPINDLE_HUB_OD` | 15 mm | Mid-range of typical 5.25" half-height ODD spindles (~14–16 mm) | Caliper measurement of donor drive spindle hub OD |
| `SPINDLE_PEG_H` | 3.5 mm | Typical CD/DVD hub peg height | Caliper measurement of donor drive hub peg height |
| `SPINDLE_ADAPTER_LOWER_OD` | 22 mm | Provides ~3 mm wall around `SPINDLE_ADAPTER_BORE`; well below `MD_DISC_DIA` so the sleeve does not foul the cartridge floor | Confirm no contact with MD cartridge floor when assembled |

## How to override a parameter for a one-off test

Pass `-D` on the openscad command line:

```bash
openscad \
  -D "SPINDLE_TO_BEZEL=85" \
  -o models/export/tray_test.stl \
  models/src/tray.scad
```

Or edit `dimensions.scad` directly and re-run `scripts/export.sh`.

## Export units

All dimensions are in **millimetres**. Afinia H400+ (and Afinia Studio) use mm natively — no unit conversion required. Verify in Afinia Studio: the bounding box of the imported tray should read approximately 126 × 148 × 10 mm; the spindle adapter should read 22 × 22 × 3 mm.

## Geometry validation

The exported STL is water-tight (manifold) as verified by OpenSCAD's CGAL kernel.
For a quick geometry check without writing a file:

```bash
./scripts/export.sh --check
```

Afinia Studio import is the final acceptance gate per issue #6 acceptance criteria.

## Spindle adapter (issue #8)

The adapter (`models/src/parts/spindle_adapter.scad`, exported to `models/export/spindle_adapter.stl`) is a two-stage stacked-cylinder sleeve that lets the OEM CD/DVD spindle hub engage a MiniDisc internal-disc 11 mm center hole.

Derived dimensions at defaults:

- `SPINDLE_ADAPTER_BORE = SPINDLE_HUB_OD + 2 * FIT_CLEARANCE = 15 + 0.8 = 15.8 mm` (slip-fit on hub)
- `SPINDLE_ADAPTER_POST_OD = MD_CENTER_HOLE - 2 * FIT_CLEARANCE = 11 - 0.8 = 10.2 mm` (engages MD center hole)
- `SPINDLE_ADAPTER_TOTAL_H = SPINDLE_ADAPTER_LOWER_H + SPINDLE_ADAPTER_POST_H = 1.5 + 1.5 = 3.0 mm` (== `MD_POCKET_DEPTH`)

The total-height envelope is enforced by an `assert()` in the part file; rendering aborts if the constants are tuned past the pocket depth.

`SPINDLE_HUB_OD` and `SPINDLE_PEG_H` are placeholders until the donor drive is measured — a follow-up physical fit-test issue will calibrate press-fit tolerances on the AFINIA H400+ print.

## Physical fit test (issue #13)

The donor-drive measurements and the four acceptance-criteria results are
captured in [`fit-test-report.md`](./fit-test-report.md). Fill that report in
during the print + fit run; copy the verified measurements back into the
**Verify against** column above on sign-off.
