use <openmfda/components/pinhole.scad>

module pinhole_325px_0(xpos, ypos, zpos, orientation){
    pinhole(xpos, ypos, zpos, orientation, diameter=140, length=260, cone=67);
}