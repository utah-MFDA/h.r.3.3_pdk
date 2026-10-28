module flush_hole_0(xpos, ypos, zpos, orient
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false) {
    width = 20*px;
    height = 20*px;
    depth = 20*px;
    translate([xpos*px, ypos*px, zpos*px])
    orientation(width, height, orient)
    cube([width, height, depth);
}
