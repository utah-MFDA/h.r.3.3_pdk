module marker(xpos, ypos, zpos){
    marker_height = 80;
    marker_diameter = 200;

    module obj(){
        cylinder(h = marker_height, d = marker_diameter);
    }

    translate([xpos, ypos, zpos]){
        obj();
    }
}
