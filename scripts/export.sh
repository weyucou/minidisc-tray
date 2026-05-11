#!/usr/bin/env bash
# Export all printable models to STL.
#
# Usage:
#   ./scripts/export.sh            # writes every STL under models/export/
#   ./scripts/export.sh --check    # validates geometry only, no files written
#
# Prerequisites:
#   openscad >= 2021.01  (https://openscad.org/downloads.html)
#
# Output units: millimetres (Afinia H400+ default).
# All dimension overrides live in models/src/dimensions.scad.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXPORT_DIR="$REPO_ROOT/models/export"

# (source .scad, output stem) pairs
PARTS=(
    "models/src/tray.scad:tray"
    "models/src/parts/spindle_adapter.scad:spindle_adapter"
)

if [[ "${1:-}" == "--check" ]]; then
    echo "Checking geometry only (no STL written)..."
    for entry in "${PARTS[@]}"; do
        src="$REPO_ROOT/${entry%%:*}"
        echo "  - ${entry%%:*}"
        openscad --export-format binstl -o /dev/null "$src"
    done
    echo "Geometry OK."
    exit 0
fi

mkdir -p "$EXPORT_DIR"
for entry in "${PARTS[@]}"; do
    src="$REPO_ROOT/${entry%%:*}"
    out="$EXPORT_DIR/${entry##*:}.stl"
    echo "Exporting $src → $out"
    openscad -o "$out" "$src"
done
echo "Done."
