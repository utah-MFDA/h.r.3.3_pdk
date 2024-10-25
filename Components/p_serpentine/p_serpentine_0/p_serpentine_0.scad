
// use <polychannel_v2_testing.scad>
use <./../../scad_objects/p_serpentine.scad>
use <../../scad_use/lef_helper.scad>

module p_serpentine_0(xpos, ypos, zpos, orientation, L1, L2, turns,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30,
    no_obj=false, floor_area=false, chan_layers=1, rot=0, clr="RosyBrown")
{
  p_serpentine(xpos, ypos, zpos, orientation,
    L1=L1, L2=L2, turns=turns, chan_layers=1, rot=true,
    px=px, layer=layer, lpv=lpv, chan_h=chan_h, chan_w=chan_w, pitch=pitch) ;
}

p_serpentine_0(0,0,0,"N", 200, 50, 4, floor_area=true, rot=0);
