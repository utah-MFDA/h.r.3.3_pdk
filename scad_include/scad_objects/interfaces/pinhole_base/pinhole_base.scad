module pinhole_base(xpos, ypos, zpos, orientation,
  d_pin=140, l_pin=260, h_cone=67,
  px=7.6e-3, layer=10e-3
){
    
    // Parameters
    // d_pin   = 140*px;   // ~= 106*layer = 1.06mm;
    // l_pin   = 260*px;   // ~= 2.00mm
    // h_cone  = 67*px;    // ~= 0.46mm

    d_pin_px  = d_pin*px ;
    l_pin_px  = l_pin*px ;
    h_cone_px = h_cone*px ;
    
    module obj(){
        rotate([-90, 0, 0]){
            translate([0, 0, l_pin_px]){
                cylinder(h = h_cone_px, d1 = d_pin_px, d2 = 0);
            }
        cylinder(d = d_pin_px, h = l_pin_px);
        }
    }
    
    if (orientation == "bottom" || orientation == "y+"){
        translate([xpos*px, ypos*px, zpos*layer + 5 * layer])
        obj();
    }
    
    if (orientation == "left" || orientation == "x+"){
        rotate([0, 0, -90])
        translate([-ypos*px, xpos*px, zpos*layer + 5 * layer])
        obj();
    }
    
    if (orientation == "top" || orientation == "y-"){
        rotate([0, 0, -180])
        translate([-xpos*px, -ypos*px, zpos*layer + 5 * layer])
        obj();
    }
    
    if (orientation == "right" || orientation == "x-"){
        rotate([0, 0, 90])
        translate([ypos*px, -xpos*px, zpos*layer+ 5 * layer])
        obj();
    }

}
