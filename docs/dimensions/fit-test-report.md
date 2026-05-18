# Physical Fit Test Report — Issue #13

Fill in this report as each physical step is completed. Defaults are pulled from
[`models/src/dimensions.scad`](../../models/src/dimensions.scad); any deviation
becomes an edit to that file followed by re-export (`./scripts/export.sh`) and
re-print.

> **Status:** template — awaiting hardware execution (AFINIA H400+ print,
> LG GH24NS90 donor drive, Sony MiniDisc cartridge). All `☐` boxes and blank
> cells are intentional.

## Operator & run

| Field | Value |
|-------|-------|
| Date (YYYY-MM-DD) | |
| Operator | |
| Iteration # | 1 |

## Hardware inventory

| Item | Expected | Actual / serial |
|------|----------|-----------------|
| Printer | AFINIA H400+ | |
| Slicer | Afinia Studio | version: |
| Material | PLA | brand / colour: |
| Donor drive | LG GH24NS90 | serial: |
| MD cartridge | Sony MiniDisc | model / capacity: |

## 1. Donor drive measurements

Caliper measurements of the donor drive. These resolve the open risks listed in
[`assumptions.md`](./assumptions.md) and parent issues #2, #3, #8.

| Constant | Default | Measured | Δ | Action |
|----------|---------|----------|---|--------|
| `SPINDLE_TO_BEZEL` | 88 mm | | | |
| Bezel / lip height | unmeasured | | | |
| `TRAY_INNER_W` | 126 mm | | | |
| `TRAY_INNER_D` | 148 mm (derived) | | | |
| `SPINDLE_HUB_OD` | 15 mm | | | |
| `SPINDLE_PEG_H` | 3.5 mm | | | |

Reference photos: `docs/dimensions/photos/` (commit alongside this report).

## 2. Afinia Studio import

| Check | Result |
|-------|--------|
| `models/export/tray.stl` imports without errors | ☐ pass ☐ fail |
| `models/export/spindle_adapter.stl` imports without errors | ☐ pass ☐ fail |
| Tray bounding box ≈ 126 × 148 × 10 mm | ☐ pass ☐ fail |
| Adapter bounding box ≈ 22 × 22 × 3 mm | ☐ pass ☐ fail |
| Both models manifold (CGAL clean) | ☐ pass ☐ fail |

Screenshots: `docs/import-tray.png`, `docs/import-spindle-adapter.png`.

## 3. Print settings & outcome

| Part | Layer | Infill | Supports | Print time | Result |
|------|-------|--------|----------|------------|--------|
| `tray.stl` | 0.2 mm | 20% | none | | |
| `spindle_adapter.stl` | 0.2 mm | 20% | none | | |

## 4. Acceptance criteria

The four ACs from issue #13. Photo per result; commit photos alongside this report.

| # | Criterion | Result | Notes / photo |
|---|-----------|--------|---------------|
| AC1 | Tray fits in LG GH24NS90 drive bay without force | ☐ pass ☐ fail | |
| AC2 | MD cartridge sits centred and constrained over spindle position | ☐ pass ☐ fail | |
| AC3 | MD protective shutter opens when tray is closed | ☐ pass ☐ fail | |
| AC4 | Spindle adapter engages OEM hub without wobble or binding | ☐ pass ☐ fail | |

## 5. `dimensions.scad` updates

Record every constant edit driven by a failed AC or a measured Δ. Re-export and
re-print after each batch.

| Constant | Was | Now | Reason |
|----------|-----|-----|--------|
| | | | |

## 6. Iteration log

| # | Date | Changes (constants / orientation / profile) | Outcome |
|---|------|---------------------------------------------|---------|
| 1 | | | |

## 7. Sign-off

When all four ACs pass and the iteration is stable:

- [ ] Confirmed measurements copied into the **Verify against** column of
      [`assumptions.md`](./assumptions.md)
- [ ] "Open risk" comments in `dimensions.scad` removed or reduced to "verified"
- [ ] Final verified dimensions committed in the same PR as this report
- [ ] Issue #13 transitioned to `in-review`
