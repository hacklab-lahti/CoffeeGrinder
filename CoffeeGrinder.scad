include <threads.scad>;

thread_diameter = 47.5;
thread_space = 1.5;

bolt_hole_diameter = 6.0;
bolt_thread_hole_diameter = 5.9;
separate_parts=false;


// part positions, separated or not
locknut_position= separate_parts == true ? [80,0,-30] : [0,0,-20];
grind_support_position= separate_parts == true ? [0,100,-20] : [0,0,2];
grind_support_extender_position= separate_parts == true ? [70,100,-20] : [48.5,0,2];
motor_mount_position= separate_parts == true ? [250,0,-10] : [90,0,140];
bean_funnel_position= separate_parts == true ? [-80,0,-30] : [0,0,25];

// grinder mount
union() {
    difference() {
        union() {
            // outer base
            translate([0,0,-7.5]) cylinder(r1=22,r2=22,h=50,center=true);
            // handle
            translate([0,0,-27.5]) cylinder(r1=30,r2=30,h=10,center=true,$fn=8);
            // thread
            translate([0,0,-23]) metric_thread (diameter=thread_diameter, pitch=3, length=45);
        }
        translate([0,0,-17.5]) cylinder(r1=17,r2=17,h=61,center=true);
        // grind mount hole
        difference() {
            translate([0,0,22.5]) cylinder(r1=19,r2=19,h=20,center=true,$fn=96);
            translate([20.5,0,22.5]) cube([5,20,30],true);
            translate([-20.5,0,22.5]) cube([5,20,30],true);
        }
    }

    // bearing support
    union() {
        translate([0,0,-12.5]) difference()  {
            cylinder(r1=14,r2=14,h=40,center=true);
            cylinder(r1=12,r2=12,h=42,center=true);
        }
        // bearing slides
        for(z=[0,45,90,135,180,225,270,315]) {
            rotate([0,0,z]) translate([0,11.5,-12.5]) cube([2,1,40],true);
        }
        
        // bearing support joins
        for(z=[0,90,180,270]) {
            rotate([0,0,z]) translate([16,0,0]) difference() {
                // join
                translate([0,0,-12.5]) cube([7,7,40],true);
                // bevels
                rotate([33,0,0]) translate([0,1,7.8]) cube([7,7,3],true);
                rotate([-33,0]) translate([0,-1,7.8]) cube([7,7,3],true);
            }
        }
    }
}

// lock nut
translate(locknut_position) {
    difference() {
        // handle
        translate([0,0,0.05]) cylinder(r1=30,r2=30,h=5.9,center=false,$fn=8);
        // thread
        translate([0,0,0]) metric_thread (internal=true, diameter=thread_diameter+thread_space, pitch=3, length=6);
    }
}

// grind support
translate(grind_support_position) {
    difference() {
        union() {
            // base
            translate([0,0,0.05]) cylinder(r1=31,r2=31,h=25.9,center=true,$fn=96);
            translate([30,0,0]) cube([62,62,26], center=true);
        }
        // thread
        translate([0,0,-13.1]) metric_thread (internal=true, diameter=thread_diameter+thread_space, pitch=3, length=26.2);

        // bolt holes
        for(multiplier=[[1,1,1],[1,-1,-1],[1,1,-1],[1,-1,1]]) {
            translate([multiplier[0]*50,multiplier[1]*23.4,multiplier[2]*6.5]) rotate([0,90,0]) cylinder(r1=bolt_thread_hole_diameter/2,r2=bolt_thread_hole_diameter/2,h=40,center=true);
        }
    }
}

// gring support extender
translate(grind_support_extender_position) {
    difference() {
        translate([30,0,0]) cube([34.5,62,26], center=true);
        // bolt holes
        for(multiplier=[[1,1,1],[1,-1,-1],[1,1,-1],[1,-1,1]]) {
            translate([multiplier[0]*30,multiplier[1]*23.4,multiplier[2]*6.5]) rotate([0,90,0]) cylinder(r1=bolt_hole_diameter/2,r2=bolt_hole_diameter/2,h=60,center=true);
        }
    }
}

// motor mount plate
translate(motor_mount_position) {
    // back
    difference() {
        union() {
            // back plate
            cube([12,106,42], center=true);
            // base plate
            difference() {
                translate([-57.5,0,-17.5]) cube([105,106,7], center=true);
                // base plate shaft hole
                translate([-90.5,0,-17]) rotate([0,0,0]) cylinder(r1=12,r2=12,h=20,center=true);
                // motor bolt holes
                for(multiplier=[[1,1,1],[1,-1,-1],[1,1,-1],[1,-1,1]]) {
                    translate([multiplier[0]*90.5,multiplier[1]*26.2,multiplier[2]*25]) cylinder(r1=2.5,r2=2.5,h=20,$fn=12);
                }
                
            }
            // motor stands
            difference() {
                translate([-90.5,26.2,-14]) cylinder(r1=5,r2=5,h=5);
                translate([-90.5,26.2,-25]) cylinder(r1=2.5,r2=2.5,h=20,$fn=12);
            }
            difference() {
                translate([-90.5,-26.2,-14]) cylinder(r1=5,r2=5,h=5);
                translate([-90.5,-26.2,-25]) cylinder(r1=2.5,r2=2.5,h=20,$fn=12);
            }
            difference() {
                translate([-30.5,26.2,-14]) cylinder(r1=5,r2=5,h=5);
                translate([-30.5,26.2,-25]) cylinder(r1=2.5,r2=2.5,h=20,$fn=12);
            }
            difference() {
                translate([-30.5,-26.2,-14]) cylinder(r1=5,r2=5,h=5);
                translate([-30.5,-26.2,-25]) cylinder(r1=2.5,r2=2.5,h=20,$fn=12);
            }
        }
        // upper holes
        translate([7,47,13.75]) rotate([0,90,0]) cylinder(r1=bolt_thread_hole_diameter/2,r2=bolt_thread_hole_diameter/2,h=30,center=true);
        translate([7,-47,13.75]) rotate([0,90,0]) cylinder(r1=bolt_thread_hole_diameter/2,r2=bolt_thread_hole_diameter/2,h=30,center=true);
        // lower holes
        translate([-8,47,-13.75]) rotate([0,90,0]) cylinder(r1=bolt_thread_hole_diameter/2,r2=bolt_thread_hole_diameter/2,h=80,center=true);
        translate([-8,-47,-13.75]) rotate([0,90,0]) cylinder(r1=bolt_thread_hole_diameter/2,r2=bolt_thread_hole_diameter/2,h=80,center=true);
    }
    
    // supports between base and back
    difference() {
        translate([-29,47,0]) cube([46,12,42], center=true);
        rotate([0,-40,0]) translate([-29,47,42]) cube([145,14,36], center=true);
    }
    difference() {
        translate([-29,-47,0]) cube([46,12,42], center=true);
        rotate([0,-40,0]) translate([-29,-47,42]) cube([145,14,36], center=true);
    }
    
    // base plate border
    translate([-105,44.5,-14.5]) cube([65,5,2]);
    translate([-105,-49.5,-14.5]) cube([65,5,2]);
    translate([-108,-49.5,-14.5]) cube([5,99,2]);
}


// bean funnel
translate(bean_funnel_position) {
        difference() {
            cylinder(r1=21.75,r2=21.75,h=5,$center=true);
            translate([0,0,-0.1]) cylinder(r1=19.75,r2=19.75,h=6,$center=true);
        }

        translate([0,0,5]) {
            difference() {
                cylinder(r1=21.75,r2=42,h=50,$center=true);
                translate([0,0,-0.1]) cylinder(r1=19.75,r2=40,h=51,$center=true);
            }
        }
}