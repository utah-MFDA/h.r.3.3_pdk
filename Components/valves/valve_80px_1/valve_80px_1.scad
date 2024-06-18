
use <./../../scad_objects/p_valve.scad>

module valve_80px_1(xpos, ypos, zpos, orientation)
{
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=40, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=true,
        // length of channels extending outside of valve radius
        out_len=30, fl_extra_sp = 4, fl_chan_down_layers=30, 
        pn_extra_sp="fill", pn_chan_up_layers=30, rot_pn="true",
        // extra center spacing if needed when inport_center=false
        extra_sp = 0,
        px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, 
        no_obj=false, floor_area=false) ;
}

valve_80px_1(0,0,0,"N") ;