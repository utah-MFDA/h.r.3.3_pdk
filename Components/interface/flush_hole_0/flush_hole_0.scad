module flush_hole_0(xpos, ypos, zpos, orient){
    translate([xpos*px, ypos*px, zpos*px])
    orientation(20*px, 20*px, orient)
    cube([20*px,20*px, 20*px]);
}
