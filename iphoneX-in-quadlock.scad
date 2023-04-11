$fn = 100;
x = 152;
y = 76;
z = 16;
protrude = 10;

/**
 * This is the volume of an iPhoneX put into a Quad lock case.
 * The volume is designed so that when it is subtracted from a holder it leaves enough space for the phone to be inserted.
 * The weird protruding parts at the screen, power connector and at the camera will drill a hole into the wall of the holder.
 * Assume that the wall of the holder is not thicker than 'protrude' (10mm).
 */
module iPhoneX() {
    // the main body if the phone with the enclosure
    d = 5.9999;
    translate([d / 2, d / 2, d / 2])
        minkowski() {
            cube([x - d, y - d, z - d]);
            sphere(d = d);
        }
    // the opening for the camera
    translate([9, 11, z-1])
        minkowski() {
            dc = 11.9999;
            cube([24, 24 - dc, protrude]);
            cylinder(d = dc);
        }

    // the hill portuding on the back for the fixing
    translate([x / 2, y / 2, z / 2 + d])
        minkowski() {
            df = 1;
            cylinder(h = 2 - df / 2, r1 = 34 - df / 2, r2 = 20 - df / 2, $fn = 100);
            sphere(d = df);
        }

    // opening for the screen
    frame = 4;
    translate([frame, frame, - protrude+1])
        cube([x - 2 * frame, y - 2 * frame, protrude]);

    // opening for the power connector
    py = 24;
    pz = 8;
    translate([x, y / 2 - py / 2, z / 2])
        minkowski() {
            dp = pz - 0.0001;
            cube([protrude, py - dp, pz - dp]);
            rotate([0, 90, 0])
                cylinder(h = 1, d = dp);
        }
}

wall = 2.5;

module nakedCase() {
    difference() {
        cube([x + 2 * wall, y + 2 * wall, z + 2 * wall]);
        translate([wall, wall, wall])
            iPhoneX();
       translate([wall, - 1, - wall])
            cube([x, protrude, z + 2 * wall]);
    }
}

nakedCase();
