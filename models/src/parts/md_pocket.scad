// md_pocket.scad — MD cartridge recess, sized for a 72 × 68 × 5 mm Sony MD.
//
// Produces a negative volume intended to be subtracted from the tray base.
// Pocket is centred laterally on X = 0 and over the spindle on Y, so the
// cartridge sits centred over the spindle position.
//
// MD orientation in the pocket:
//   - MD_W (72 mm, shutter-slide axis) along X
//   - MD_D (68 mm)                      along Y

include <../dimensions.scad>;

module md_pocket(
    spindle_to_bezel = SPINDLE_TO_BEZEL,
    base_thickness = TRAY_BASE_THICKNESS,
    pocket_depth = MD_POCKET_DEPTH,
    clearance = FIT_CLEARANCE
) {
    pocket_w = MD_W + 2 * clearance;
    pocket_d = MD_D + 2 * clearance;
    // The cube extends 1 mm above the tray top to guarantee a clean cut
    // through the top surface when this volume is subtracted.
    translate([
        -pocket_w / 2,
        spindle_to_bezel - pocket_d / 2,
        base_thickness - pocket_depth
    ])
        cube([pocket_w, pocket_d, pocket_depth + 1]);
}

md_pocket();
