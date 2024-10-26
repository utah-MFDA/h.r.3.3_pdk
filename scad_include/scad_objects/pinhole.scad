layer = 0.010;
px = 0.0076;

module pinhole(d=106*layer, l=200*px, orth=0, ychan_z_angle=0) {
    // This module operates on a standard of 10um layers and 7.6 um pixels
    rotate([-90, 0, orth]){
        union(){
            cylinder(d = d, h = l, $fn = 100);
            translate([0, 0, l])
                cylinder(h=300*px, r1=d/4, r2=2*layer, $fn = 100);
        }
    }
}

pinhole();