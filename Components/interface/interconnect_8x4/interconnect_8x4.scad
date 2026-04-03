use <openmfda/components/interconnect.scad>

module interconnect_8x4(xpos, ypos, zpos, orient,px = 7.6e-3,
layer = 10e-3,) {
    interconnect_grid(xpos, ypos, zpos, orient, gasket_grid=[4,8], px=px, layer=layer);
}
interconnect_8x4(0,0,0,"N");