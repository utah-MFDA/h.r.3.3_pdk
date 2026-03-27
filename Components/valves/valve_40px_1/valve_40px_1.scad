use <openmfda/objects/p_valve.scad>


module valve_40px_1(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=60)
{
    translate([1*px,0,1.2*lpv*layer])
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=20, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false,
        fl_out_len=43, fl_extra_sp = 2, dwn_chan_h=10,
        pn_out_len=43,
        pn_extra_sp="fill", rot_pn=false,
        px=px, layer=layer, lpv=lpv, chan_h=6, chan_w=8, shape="cube", pitch=pitch);
}

valve_40px_1(0,0,0,"E");
