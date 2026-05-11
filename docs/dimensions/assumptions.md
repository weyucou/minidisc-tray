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

All dimensions are in **millimetres**. Afinia H400+ (and Afinia Studio) use mm natively — no unit conversion required. Verify in Afinia Studio: the bounding box of the imported tray should read approximately 126 × 148 × 10 mm.

## Geometry validation

The exported STL is water-tight (manifold) as verified by OpenSCAD's CGAL kernel.
For a quick geometry check without writing a file:

```bash
./scripts/export.sh --check
```

Afinia Studio import is the final acceptance gate per issue #6 acceptance criteria.
