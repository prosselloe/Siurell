// =======================================
// SIURELL DIMONI - COS TRADICIONAL BUIT
// =======================================

$fn = 100;

// ---------- PARÀMETRES GENERALS ----------
gruix = 2.5;

// Cos
cos_h = 85;
cos_r1 = 30;
cos_r2 = 22;

// Cap
cap_r = 20;

// Banyes
banya_h = 22;
banya_r1 = 6;
banya_r2 = 2;
banya_angle = 25;

// Forat acústic
forat_sortida = 10;

// Encaix xiulet
encaix_w = 11;
encaix_h = 7;
encaix_d = 20;

// ---------- COS EXTERIOR ----------
module cos_exterior() {
    union() {
        // Cos
        cylinder(h=cos_h, r1=cos_r1, r2=cos_r2);

        // Cap
        translate([0,0,cos_h])
            sphere(r=cap_r);
    }
}

// ---------- COS INTERIOR (BUIT) ----------
module cos_interior() {
    translate([0,0,gruix])
        union() {
            cylinder(
                h=cos_h - gruix,
                r1=cos_r1 - gruix,
                r2=cos_r2 - gruix
            );

            translate([0,0,cos_h])
                sphere(r=cap_r - gruix);
        }
}

// ---------- BANYA ----------
module banya(xdir=1) {
    translate([xdir*(cap_r-4), 0, cos_h + cap_r - 6])
        rotate([0, xdir*banya_angle, 20])
        cone();
}

module cone() {
    cylinder(h=banya_h, r1=banya_r1, r2=banya_r2);
}

// ---------- ULLS ----------
module ulls() {
    for (x=[-7,7])
        translate([x, cap_r-2, cos_h + cap_r/2])
            sphere(r=2.5);
}

// ---------- BOCA (DECORATIVA) ----------
module boca() {
    translate([-8, cap_r-2, cos_h + cap_r/4])
        cube([16,3,3]);
}

// ---------- ENCAIX XIULET ----------
module encaix_xiulet() {
    translate([
        -encaix_w/2,
        cos_r1 - encaix_d,
        cos_h/2
    ])
    cube([encaix_w, encaix_d, encaix_h]);
}

// ---------- FORAT INFERIOR ----------
module forat_inferior() {
    translate([0,0,-1])
        cylinder(h=10, r=forat_sortida/2);
}

// ---------- COS FINAL ----------
difference() {
    union() {
        cos_exterior();
        banya(1);
        banya(-1);
        ulls();
    }
    cos_interior();
    encaix_xiulet();
    forat_inferior();
    boca();
}
