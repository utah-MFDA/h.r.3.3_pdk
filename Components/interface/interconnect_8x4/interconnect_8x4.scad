use <openmfda/components/interconnect.scad>

module interconnect_8x4(xpos, ypos, zpos, orient="N",px = 7.6e-3,
layer = 10e-3,) {
    p_interconnect_grid(xpos=xpos, ypos=ypos, zpos=zpos, orientation=orient, gasket_grid=[4,8], px=px, layer=layer);
}
