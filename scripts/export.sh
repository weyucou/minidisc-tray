#!/usr/bin/env bash
# Export tray.scad to a print-ready STL.
#
# Usage:
#   ./scripts/export.sh            # writes models/export/tray.stl
#   ./scripts/export.sh --check    # validates geometry only, no file written
#
# Prerequisites:
#   openscad >= 2021.01  (https://openscad.org/downloads.html)
#
# Output units: millimetres (Afinia H400+ default).
# All dimension overrides live in models/src/dimensions.scad.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO_ROOT/models/src/tray.scad"
OUT="$REPO_ROOT/models/export/tray.stl"

if [[ "${1:-}" == "--check" ]]; then
    echo "Checking geometry only (no STL written)..."
    openscad --export-format binstl -o /dev/null "$SRC"
    echo "Geometry OK."
    exit 0
fi

mkdir -p "$(dirname "$OUT")"
echo "Exporting $SRC → $OUT"
openscad -o "$OUT" "$SRC"
echo "Done: $OUT"
