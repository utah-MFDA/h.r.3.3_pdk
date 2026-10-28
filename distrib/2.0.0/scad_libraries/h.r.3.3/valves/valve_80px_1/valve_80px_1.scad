use <openmfda/components/valve.scad>
use <openmfda/components/lef_helper.scad>

module valve_80px_1(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=60)
{
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=40, mem_th=1, fl_chm_h=3, pn_chm_h=6,
        fl_out_len=27, fl_extra_sp = 4, dwn_chan_h=10,
        pn_out_len=27, pn_extra_sp="fill",
        px=px, layer=layer, lpv=lpv, chan_h=10, chan_w=14, shape="cube", pitch=pitch);
}

valve_80px_1(0,0,0,"N") ;
