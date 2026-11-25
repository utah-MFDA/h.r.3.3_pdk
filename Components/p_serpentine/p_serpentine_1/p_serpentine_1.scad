
// use <openmfda/polychannel/polychannel.scad>
use <openmfda/components/serpentine.scad>
use <openmfda/components/lef_helper.scad>

module p_serpentine_1(xpos, ypos, zpos, orientation, L1, L2, turns,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, 
    clr="RosyBrown")
{

      p_serpentine(xpos, ypos, zpos+28+lpv, orientation,
      L1=L1, L2=L2, turns=turns, chan_layers=2, rot=true,
      px=px, layer=layer, lpv=lpv, chan_h=chan_h, chan_w=chan_w, pitch=pitch) ;

}

p_serpentine_1(0,0,0,"FN", 300, 50, 12);
