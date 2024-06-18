
use <../../scad_objects/p_pump.scad>

module pump_20px_0(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30)
{
    p_pump (xpos, ypos, zpos, orientation,
    r1=20, r2=20, r3=20,
    th1=0.6, th2=0.6, th3=0.6,
    fl_h1=3.1, fl_h2=3.1, fl_h3=3.1,
    pn_h1=4, pn_h2=4, pn_h3=4,
    len_sp=30,
    pn_out_len=25, 
    fl_extra_sp=4, pn_extra_sp="fill-edge",
    px=px, layer=layer, lpv=lpv, chan_h=5, chan_w=6, shape="cube", pitch=pitch, 
    rot=false, no_obj=false, floor_area=false) ;
        
}

pump_20px_0(0,0,0,"N") ;//, px=1, layer=1/20*10, pitch=0) ;