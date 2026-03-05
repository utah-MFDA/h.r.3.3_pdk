module pinhole_320px_0(xpos, ypos, zpos, orientation, px=7.6e-3, layer=10e-3, d=140, l=260, h=67){
    d_pin   = d;
    l_pin   = l;
    h_cone  = h;

    module obj() {
        translate([0, d_pin/2, 0])
        rotate([0, 90, 0])
        union() {
            translate([0, 0, l_pin])
            cylinder(h = h_cone, d1 = d_pin, d2 = 0);

            cylinder(d = d_pin, h = l_pin);
        };
    }
    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    orient(l_pin+h_cone, d_pin, orientation)
    obj();

}
