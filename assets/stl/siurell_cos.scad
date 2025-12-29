// ================================
// SIURELL - COS BUIT TRADICIONAL
// ================================

$fn = 100;

// ---------- PARÀMETRES ----------
cos_h = 90;
cos_r1 = 28;
cos_r2 = 18;
gruix_paret = 2.5;

forat_sortida = 10;
encaix_xiulet_w = 11;
encaix_xiulet_h = 7;
encaix_xiulet_d = 20;

// ---------- COS EXTERIOR ----------
module cos_exterior() {
    union() {
        cylinder(h=cos_h, r1=cos_r1, r2=cos_r2);
        translate([0,0,cos_h])
            sphere(r=cos_r2);
    }
}

// ---------- COS INTERIOR (BUIT) ----------
module cos_interior() {
    translate([0,0,gruix_paret])
        union() {
            cylinder(
                h=cos_h - gruix_paret,
                r1=cos_r1 - gruix_paret,
                r2=cos_r2 - gruix_paret
            );
            translate([0,0,cos_h])
                sphere(r=cos_r2 - gruix_paret);
        }
}

// ---------- ENCAIX XIULET ----------
module encaix_xiulet() {
    translate([
        -encaix_xiulet_w/2,
        cos_r1 - encaix_xiulet_d,
        cos_h/2
    ])
    cube([
        encaix_xiulet_w,
        encaix_xiulet_d,
        encaix_xiulet_h
    ]);
}

// ---------- FORAT SORTIDA ----------
module forat_inferior() {
    translate([0,0,-1])
        cylinder(h=10, r=forat_sortida/2);
}

// ---------- COS FINAL ----------
difference() {
    cos_exterior();
    cos_interior();
    encaix_xiulet();
    forat_inferior();
}
