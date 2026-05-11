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

// Inner tray usable depth — derived from spindle-to-bezel + CD radius + rear margin.
// Matches typical 5.25" half-height CD tray depth. Refine when donor drive measured.
TRAY_INNER_D = SPINDLE_TO_BEZEL + CD_DISC_DIA / 2 + 10;

// Spindle clearance hole radius — clears the CD spindle hub / clamp area.
// Sized at CD_CLAMP_R_MAX + 1 mm safety; also clears the MD internal disc edge.
SPINDLE_CLEARANCE_R = CD_CLAMP_R_MAX + 1;


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


// ---------------------------------------------------------------------------
// Tray geometry (design constants)
// ---------------------------------------------------------------------------

// Tray base plate thickness — chosen for FDM stiffness across the full footprint.
// Must exceed MD_POCKET_DEPTH so the pocket leaves a continuous floor.
TRAY_BASE_THICKNESS = 4.0;

// MD pocket recess depth — how far the cartridge sits below the tray surface.
// MD_H = 5 mm; a 3 mm recess leaves the cartridge ~2 mm proud, easy to grip.
MD_POCKET_DEPTH = 3.0;

// Shutter actuator pin geometry — engages the MD cartridge shutter tab from
// inside the pocket as the cartridge is slid into final position.
SHUTTER_PIN_DIA = 3.0;
SHUTTER_PIN_H = 6.0;

// Shutter tab engagement position, measured from the leading corner of the
// MD pocket. Approximate; refine against a physical Sony MD cartridge.
SHUTTER_TAB_X_OFFSET = 5.0;
SHUTTER_TAB_Y_OFFSET = 4.0;


// ---------------------------------------------------------------------------
// Spindle adapter (issue #8) — OEM CD/DVD spindle hub ↔ MD center hole
// ---------------------------------------------------------------------------
//
// Two-stage stacked-cylinder sleeve. Lower sleeve slip-fits over the OEM hub;
// upper post engages the MD internal-disc 11 mm center hole.
//
// SPINDLE_HUB_OD and SPINDLE_PEG_H are OPEN RISKS — placeholders pending
// physical measurement of the project donor drive. See
// docs/dimensions/assumptions.md.

// OEM spindle hub outer diameter — mid-range default from typical 5.25"
// half-height ODD spindles (~14–16 mm). VERIFY against donor drive.
SPINDLE_HUB_OD = 15;

// OEM spindle hub peg height — typical default; VERIFY against donor drive.
SPINDLE_PEG_H = 3.5;

// Adapter inner bore — slip-fit on the OEM hub.
SPINDLE_ADAPTER_BORE = SPINDLE_HUB_OD + 2 * FIT_CLEARANCE;

// Adapter upper-post OD — enters the MD center hole with FIT_CLEARANCE on
// each side. With MD_CENTER_HOLE = 11 and FIT_CLEARANCE = 0.4 → 10.2 mm.
SPINDLE_ADAPTER_POST_OD = MD_CENTER_HOLE - 2 * FIT_CLEARANCE;

// Adapter lower-sleeve OD — kept well below the MD internal disc edge
// (MD_DISC_DIA = 64 mm) so the sleeve does not foul the cartridge floor.
// Provides ~3 mm wall around the bore for FDM strength.
SPINDLE_ADAPTER_LOWER_OD = 22;

// Adapter stack heights — split so total height fits inside the cartridge
// pocket envelope (MD_POCKET_DEPTH = 3.0 mm).
SPINDLE_ADAPTER_LOWER_H = 1.5;
SPINDLE_ADAPTER_POST_H = 1.5;

// Total stacked height. MUST satisfy SPINDLE_ADAPTER_TOTAL_H <= MD_POCKET_DEPTH;
// enforced by an assert() in parts/spindle_adapter.scad.
SPINDLE_ADAPTER_TOTAL_H = SPINDLE_ADAPTER_LOWER_H + SPINDLE_ADAPTER_POST_H;

// Lead-in chamfer on the top edge of the upper post (0.5 mm × 45°) to ease
// loading of the MD cartridge over the post.
SPINDLE_ADAPTER_CHAMFER = 0.5;
