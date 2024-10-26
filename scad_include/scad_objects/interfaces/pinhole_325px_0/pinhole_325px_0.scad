module pinhole_325px_0(xpos, ypos, zpos, orientation){
    
    // Parameters
    d_pin   = 140*px;   // ~= 106*layer = 1.06mm;
    l_pin   = 260*px;   // ~= 2.00mm
    h_cone  = 67*px;    // ~= 0.46mm
    
    module obj(){
        rotate([-90, 0, 0]){
            translate([0, 0, l_pin]){
                cylinder(h = h_cone, d1 = d_pin, d2 = 0);
            }
        cylinder(d = d_pin, h = l_pin);
        }
    }
    
    if (orientation == "bottom"){
        translate([xpos*px, ypos*px, zpos*layer + 5 * layer])
        obj();
    }
    
    if (orientation == "left"){
        rotate([0, 0, -90])
        translate([-ypos*px, xpos*px, zpos*layer + 5 * layer])
        obj();
    }
    
    if (orientation == "top"){
        rotate([0, 0, -180])
        translate([-xpos*px, -ypos*px, zpos*layer + 5 * layer])
        obj();
    }
    
    if (orientation == "right"){
        rotate([0, 0, 90])
        translate([ypos*px, -xpos*px, zpos*layer+ 5 * layer])
        obj();
    }

}