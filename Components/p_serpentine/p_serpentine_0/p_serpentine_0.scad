
// use <openmfda/polychannel/polychannel.scad>
use <openmfda/components/serpentine.scad>
use <openmfda/components/lef_helper.scad>

module p_serpentine_0(xpos, ypos, zpos, orientation, L1, L2, turns,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30,
    no_obj=false, floor_area=false, chan_layers=1, rot=0, clr="RosyBrown",
    show_lef=false
    )
{
  
    p_serpentine(xpos, ypos, zpos+20, orientation,
      L1=L1, L2=L2, turns=turns, chan_layers=1,
      px=px, layer=layer, lpv=lpv, chan_h=chan_h, chan_w=chan_w, pitch=pitch) ;
  
    
    // this is intentially wrong to prevent from being parsed
    //  keep this as lef_
    module lef_() {
        lef_layer("met1")
        lef_port("in_fluid", "INPUT", "RECT", [23, 23, 37, 37]) ;
        lef_layer("met1")
        lef_port("out_fluid", "INPUT", "RECT", [turns*L2+23, ((turns+1)%2)*L1+23, turns*L2+37, ((turns+1)%2)*L1+37]) ;
    }

    if (show_lef)
        lef_() ;
}

p_serpentine_0(0,0,0,"FN", 200, 50, 4, floor_area=true, rot=0, show_lef=true);
