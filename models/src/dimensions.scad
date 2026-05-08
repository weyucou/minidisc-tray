// dimensions.scad — single source of truth for all tray geometry constants.
//
// All values in millimetres unless otherwise noted.
// Sources:
//   - CD/DVD drive envelope: SFF-8551 (5.25" half-height) and laptop slim ODD (9.5 mm)
//   - CD disc geometry: ECMA-130
//   - MiniDisc cartridge: Sony MiniDisc specification (MD)
//   - Issues weyucou/minidisc-tray#1 (3D modeling format research) and
//     weyucou/minidisc-tray#2 (CD/DVD tray dimensions)


// ---------------------------------------------------------------------------
// CD/DVD drive envelope (target form factor)
// ---------------------------------------------------------------------------

// Primary target: 5.25" half-height (SFF-8551) drive body.
DRIVE_BODY_W = 146.1;   // outer width
DRIVE_BODY_H = 41.3;    // outer height
DRIVE_BODY_D = 170;     // outer depth (typical; range 170–203)

// Slim laptop ODD (9.5 mm) — secondary parametric variant.
SLIM_BODY_W = 128;
SLIM_BODY_H = 9.5;
SLIM_BODY_D = 127;


// ---------------------------------------------------------------------------
// CD tray envelope (the cavity the printed tray must fit into)
// ---------------------------------------------------------------------------

// Inner tray usable width — the lateral envelope between the tray side walls.
// Derived in #2: ~63 mm from spindle centre to each side wall.
TRAY_INNER_W = 126;

// Spindle-centre-to-front-bezel distance.
// Range observed across donor drives: 80–95 mm.
// Default = mid-range; UPDATE after physical measurement of the actual donor drive.
SPINDLE_TO_BEZEL = 88;

// CD program area (informational — used to validate spindle clearance).
// ECMA-130: program area lies between r=25 and r=58 mm.
CD_DISC_DIA = 120;
CD_CENTER_HOLE = 15;
CD_CLAMP_R_MIN = 26;
CD_CLAMP_R_MAX = 33;


// ---------------------------------------------------------------------------
// MiniDisc cartridge (the part the tray must position and shutter-actuate)
// ---------------------------------------------------------------------------

// Cartridge outer dimensions — Sony MD spec.
MD_W = 72;   // width  (along shutter slide axis)
MD_D = 68;   // depth  (perpendicular to shutter slide)
MD_H = 5;    // thickness

// Internal disc — used for spindle-clearance hole sizing and centring checks.
MD_DISC_DIA = 64;
MD_CENTER_HOLE = 11;


// ---------------------------------------------------------------------------
// Print and fit tolerances
// ---------------------------------------------------------------------------

// Per-side print clearance applied to mating surfaces (tray-to-cavity, MD pocket).
// Tuned for AFINIA H400+ FDM with default Afinia Studio profile.
FIT_CLEARANCE = 0.4;

// OpenSCAD render facet count for circular features.
// Higher = smoother curves at the cost of render time.
$fn = 64;
