module marker(xpos, ypos, zpos){
    marker_height = 80*layer;
    marker_diameter = 200*px;
    
    module obj(){
        cylinder(h = marker_height, d = marker_diameter);
    }

    translate([xpos, ypos, zpos]){
        obj();
    }
}