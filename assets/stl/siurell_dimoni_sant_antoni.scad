// ==================================================
// SIURELL DIMONI DE SANT ANTONI - COS TRADICIONAL
// Compatible amb mòdul de xiulet funcional
// ==================================================

$fn = 100;

// ---------- PARÀMETRES GENERALS ----------
gruix = 2.5;

// Cos (més esvelt)
cos_h = 95;
cos_r1 = 26;
cos_r2 = 18;

// Cap (integrat, no massa rodó)
cap_h = 28;
cap_r = 17;

// Banyes (llargues i cap enrere)
banya_h = 30;
banya_r1 = 5;
banya_r2 = 1.8;
banya_angle = 35;

// Acústica
forat_sortida = 10;

// Encaix xiulet (mateix estàndard)
encaix_w = 11;
encaix_h = 7;
encaix_d = 20;

// ---------- COS EXTERIOR ----------
module cos_exterior() {
    union() {
        // Cos principal
        cylinder(h=cos_h, r1=cos_r1, r2=cos_r2);

        // Cap allargat
        translate([0,0,cos_h])
            scale([1,1,1.2])
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
                scale([1,1,1.2])
                sphere(r=cap_r - gruix);
        }
}

// ---------- BANYA ----------
module banya(xdir=1) {
    translate([xdir*(cap_r-3), -2, cos_h + cap_h])
        rotate([0, xdir*banya_angle, -20])
        cylinder(h=banya_h, r1=banya_r1, r2=banya_r2);
}

// ---------- ULLS ----------
module ulls() {
    for (x=[-6,6])
        translate([x, cap_r-4, cos_h + cap_h/1.8])
            sphere(r=2.2);
}

// ---------- BOCA (DISCRETA) ----------
module boca() {
    translate([-6, cap_r-3, cos_h + cap_h/3])
        cube([12,2,2]);
}

// ---------- ENCAIX XIULET ----------
module encaix_xiulet() {
    translate([
        -encaix_w/2,
        cos_r1 - encaix_d,
        cos_h/2
    ])
    cube([
        encaix_w,
        encaix_d,
        encaix_h
    ]);
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
