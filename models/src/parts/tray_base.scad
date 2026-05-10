// tray_base.scad — flat tray plate with central spindle clearance hole.
//
// Coordinate system (shared across all tray parts):
//   - Origin: front-bezel-centre on the bottom face of the tray base
//   - +X: lateral (along bezel width)
//   - +Y: into the drive (away from bezel)
//   - +Z: up (out of the tray plane)
//
// Footprint defaults to the SFF-8551 (5.25" half-height) inner tray dimensions
// from dimensions.scad. Pass smaller values for slim laptop ODD form factor.

include <../dimensions.scad>;

module tray_base(
    inner_w = TRAY_INNER_W,
    inner_d = TRAY_INNER_D,
    thickness = TRAY_BASE_THICKNESS,
    spindle_to_bezel = SPINDLE_TO_BEZEL,
    spindle_clearance_r = SPINDLE_CLEARANCE_R
) {
    difference() {
        translate([-inner_w / 2, 0, 0])
            cube([inner_w, inner_d, thickness]);

        translate([0, spindle_to_bezel, -1])
            cylinder(h = thickness + 2, r = spindle_clearance_r);
    }
}

tray_base();
