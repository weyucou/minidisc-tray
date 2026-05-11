// spindle_adapter.scad — slip-fit sleeve that adapts the OEM CD/DVD drive
// spindle hub to engage a Sony MiniDisc internal-disc center hole.
//
// Two-stage stacked-cylinder sleeve:
//   - Lower sleeve  : slip-fits over the OEM hub via SPINDLE_ADAPTER_BORE.
//   - Upper post    : enters the MD 11 mm center hole (SPINDLE_ADAPTER_POST_OD).
//   - Top chamfer   : 0.5 mm × 45° lead-in for MD loading.
//
// Total stacked height must not exceed MD_POCKET_DEPTH so the adapter stays
// inside the cartridge pocket envelope defined by the parent tray (#3, #5).
//
// Coordinate system:
//   - Origin at the bottom face of the lower sleeve, on the central axis.
//   - +Z up (out of the OEM spindle hub).
//
// Render with:
//   openscad -o models/export/spindle_adapter.stl models/src/parts/spindle_adapter.scad

include <../dimensions.scad>;

// Hard envelope check — total stacked height must fit inside the pocket.
assert(
    SPINDLE_ADAPTER_TOTAL_H <= MD_POCKET_DEPTH,
    "SPINDLE_ADAPTER_TOTAL_H exceeds MD_POCKET_DEPTH; reduce SPINDLE_ADAPTER_LOWER_H or SPINDLE_ADAPTER_POST_H."
);

// Echo derived dimensions on render — visible in OpenSCAD console / CLI output.
echo(str(
    "[spindle_adapter] total_h=", SPINDLE_ADAPTER_TOTAL_H,
    " mm (envelope <= ", MD_POCKET_DEPTH,
    " mm); bore=", SPINDLE_ADAPTER_BORE,
    " mm; post_od=", SPINDLE_ADAPTER_POST_OD,
    " mm; lower_od=", SPINDLE_ADAPTER_LOWER_OD, " mm"
));

module spindle_adapter(
    bore = SPINDLE_ADAPTER_BORE,
    lower_od = SPINDLE_ADAPTER_LOWER_OD,
    lower_h = SPINDLE_ADAPTER_LOWER_H,
    post_od = SPINDLE_ADAPTER_POST_OD,
    post_h = SPINDLE_ADAPTER_POST_H,
    chamfer = SPINDLE_ADAPTER_CHAMFER
) {
    difference() {
        union() {
            // Lower sleeve — clamps the OEM hub.
            cylinder(d = lower_od, h = lower_h);

            // Upper post — straight cylinder body + chamfered top edge.
            translate([0, 0, lower_h]) {
                cylinder(h = post_h - chamfer, d = post_od);
                translate([0, 0, post_h - chamfer])
                    cylinder(
                        h = chamfer,
                        d1 = post_od,
                        d2 = post_od - 2 * chamfer
                    );
            }
        }

        // Through-bore in the lower sleeve for slip-fit on the OEM hub.
        // The +1 extension above and below guarantees a clean cut.
        translate([0, 0, -1])
            cylinder(d = bore, h = lower_h + 2);
    }
}

spindle_adapter();
