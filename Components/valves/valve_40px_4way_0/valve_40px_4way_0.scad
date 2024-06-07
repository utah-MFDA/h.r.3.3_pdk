
use <./../../scad_use/p_valve_4way.scad>

module valve_40px_4way_0 (xpos, ypos, zpos, orientation)
{
    p_valve_4way(xpos, ypos, zpos, orientation,
        valve_r=40, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false, 
        // extra center spacing if needed when inport_center=false
        out_len=30, 
        // length of channels extending outside of valve radius
        extra_sp=10, 
        px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, 
        no_obj=false, floor_area=false) ;
    
}

valve_40px_4way_0(0,0,0,"N") ;