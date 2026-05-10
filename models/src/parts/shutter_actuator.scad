// shutter_actuator.scad — fixed pin that engages the MD shutter tab.
//
// Produces a positive cylinder intended to be unioned with the tray base.
// The pin runs from the bottom of the tray base (Z = 0) up to (pocket-floor +
// pin_h), so its lower portion fuses with the pocket floor and its upper
// portion stands proud inside the pocket — engaging the cartridge shutter
// tab as the MD is slid into final position.
//
// Pin position is derived from the MD pocket's near corner (the loading-side
// corner of the cartridge). Offsets are approximate; refine against a
// physical Sony MD cartridge.

include <../dimensions.scad>;

module shutter_actuator(
    spindle_to_bezel = SPINDLE_TO_BEZEL,
    base_thickness = TRAY_BASE_THICKNESS,
    pocket_depth = MD_POCKET_DEPTH,
    pin_dia = SHUTTER_PIN_DIA,
    pin_h = SHUTTER_PIN_H,
    tab_x_offset = SHUTTER_TAB_X_OFFSET,
    tab_y_offset = SHUTTER_TAB_Y_OFFSET
) {
    pin_x = -MD_W / 2 + tab_x_offset;
    pin_y = spindle_to_bezel - MD_D / 2 + tab_y_offset;
    floor_z = base_thickness - pocket_depth;

    translate([pin_x, pin_y, 0])
        cylinder(h = floor_z + pin_h, d = pin_dia);
}

shutter_actuator();
