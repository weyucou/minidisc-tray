// tray.scad — composed tray solid: base + MD pocket + shutter actuator.
//
// Produces a single solid body representing the complete printable tray.
// Render with:
//   openscad -o models/export/tray.stl models/src/tray.scad

include <dimensions.scad>;
use <parts/tray_base.scad>;
use <parts/md_pocket.scad>;
use <parts/shutter_actuator.scad>;

union() {
    difference() {
        tray_base();
        md_pocket();
    }
    shutter_actuator();
}
