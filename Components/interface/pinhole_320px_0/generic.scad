module pinhole_320px_0(xpos, ypos, zpos, orient, d=140, l=260, h=67){
    d_pin   = d*px;
    l_pin   = l*px;
    h_cone  = h*px;

    module obj() {
        translate([0, d_pin/2, 0])
        rotate([0, 90, 0])
        union() {
            translate([0, 0, l_pin])
            cylinder(h = h_cone, d1 = d_pin, d2 = 0);

            cylinder(d = d_pin, h = l_pin);
        };
    }
    translate([xpos*px, ypos*px, zpos*layer])
    orientation(l_pin+h_cone, d_pin, orient)
    obj();

}
