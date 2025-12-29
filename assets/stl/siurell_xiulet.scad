// ================================
// SIURELL - MÒDUL XIULET FUNCIONAL
// ================================

$fn = 80;

// ---------- PARÀMETRES CRÍTICS ----------
windway_w = 7;      // amplada conducte (mm)
windway_h = 1.2;    // alçada conducte (mm)  <-- ajustar en iteracions
windway_l = 18;     // longitud conducte (mm)

labium_h = 5;
labium_angle = 90;  // graus (85–90)

// ---------- COS BASE ----------
module bloc_base() {
    cube([windway_w + 4, windway_l + 8, labium_h + 6]);
}

// ---------- CONDUCTE D'AIRE ----------
module windway() {
    translate([2, 2, 2])
        cube([windway_w, windway_l, windway_h]);
}

// ---------- BISSELL (LABIUM) ----------
module labium() {
    translate([2, windway_l + 2, 2])
        rotate([labium_angle, 0, 0])
        cube([windway_w, 0.8, labium_h]);
}

// ---------- SORTIDA ----------
module air_exit() {
    translate([0, windway_l + 2, 2])
        cube([windway_w + 4, 4, labium_h + 4]);
}

// ---------- MÒDUL FINAL ----------
difference() {
    bloc_base();
    windway();
    labium();
    air_exit();
}
