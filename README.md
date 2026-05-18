# minidisc-tray

## Goals

Design and produce a 3D printable CD/DVD drive tray replacement that allows placement of a Sony MiniDisc and automatically opens the MiniDisc protective cover.

## Repository Layout

```
models/
  src/                  ← OpenSCAD source (.scad) — single source of truth
    dimensions.scad     ← all geometry constants (drive, tray, MD, tolerances)
  export/               ← print artifacts (STL) generated from src/
docs/
  dimensions/           ← measurement notes, sources, photos
```

All dimensions live in [`models/src/dimensions.scad`](models/src/dimensions.scad). Geometry files (added in Phase 2) `include <dimensions.scad>` so any value (form factor, measured bezel offset, tolerance) can be tuned without rewriting geometry.

## Toolchain

### OpenSCAD

The model source is authored in [OpenSCAD](https://openscad.org/), a script-based parametric CAD tool. `.scad` files are plain text and diff cleanly in git, which makes design changes reviewable in a PR.

Install (Ubuntu/Debian):

```bash
sudo apt install openscad
```

Install (macOS):

```bash
brew install --cask openscad
```

Verify:

```bash
openscad --version
```

### Editing

Open `models/src/<file>.scad` in the OpenSCAD GUI and press **F5** to preview, **F6** to render. The OpenSCAD VS Code extension also works for inline editing with syntax highlighting.

### Exporting STL from the CLI

STL is the print-ready format consumed by the AFINIA H400+ slicer. Render every printable model from the command line via the helper script:

```bash
./scripts/export.sh            # writes every STL under models/export/
./scripts/export.sh --check    # validates geometry only (no files written)
```

The script renders:

- `models/export/tray.stl` from `models/src/tray.scad` ([#3](https://github.com/weyucou/minidisc-tray/issues/3))
- `models/export/spindle_adapter.stl` from `models/src/parts/spindle_adapter.scad` ([#8](https://github.com/weyucou/minidisc-tray/issues/8))

Either part can be rendered individually with `openscad -o <out>.stl <src>.scad`.

## Slicer — Afinia Studio (AFINIA H400+)

The target printer is the **AFINIA H400+** running **Afinia Studio**.

- Import the exported `.stl` into Afinia Studio (`File → Open Model`).
- Recommended starting profile: PLA, 0.2 mm layer height, 20% infill, no supports for the flat-tray geometry.
- Confirm orientation with the tray base flat on the build plate before slicing.
- Afinia Studio reads STL natively; no intermediate format conversion is required.

> The `FIT_CLEARANCE = 0.4` constant in `dimensions.scad` is tuned for AFINIA H400+ FDM with the default Afinia Studio profile. Re-tune if a different printer or material is used.

## Open Dimensions

Several dimensions in [`dimensions.scad`](models/src/dimensions.scad) are placeholders pending physical measurement of the donor drive — see [#2](https://github.com/weyucou/minidisc-tray/issues/2) and [#8](https://github.com/weyucou/minidisc-tray/issues/8):

- `SPINDLE_TO_BEZEL` — currently 88 mm (mid-range default; range 80–95 mm)
- Bezel/lip height — not yet measured
- `SPINDLE_HUB_OD` — currently 15 mm (mid-range of typical 5.25" half-height ODD spindles)
- `SPINDLE_PEG_H` — currently 3.5 mm (typical hub peg height)

Measurements should be added to `docs/dimensions/` and the corresponding constants updated when the physical donor drive is available. The physical fit test (donor drive + AFINIA H400+ print + MD cartridge) is tracked in [#13](https://github.com/weyucou/minidisc-tray/issues/13); record measurements and AC results in [`docs/dimensions/fit-test-report.md`](docs/dimensions/fit-test-report.md).

## Related Repositories

None yet.
