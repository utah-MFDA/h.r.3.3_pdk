
use <../../scad_objects/p_pump.scad>
use <./../../scad_use/lef_helper.scad>

module pump_40px_0(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    translate([0,0,-10*px])
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
    module lef()
    {
        color("blue")
        lef_size(285, 135);
        
        lef_layer("met1")
        lef_port("in_fluid", "INPUT", "RECT",  [29.5, 69.5, 30.5, 70.5]) ;
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [254.5, 69.5, 255.5, 70.5]) ;
        
        lef_layer("met3")
        lef_port("a_in_air", "INPUT", "RECT",   [69.5, 29.5, 70.5, 30.5]) ;
        lef_layer("met3")
        lef_port("a_out_air", "OUTPUT", "RECT", [69.5, 109.5, 70.5, 110.5]) ;
        lef_layer("met3")
        lef_port("b_in_air", "INPUT", "RECT",   [139.5, 29.5, 140.5, 30.5]) ;
        lef_layer("met3")
        lef_port("b_out_air", "OUTPUT", "RECT", [139.5, 109.5, 140.5, 110.5]) ;
        lef_layer("met3")
        lef_port("c_in_air", "INPUT", "RECT",   [209.5, 29.5, 210.5, 30.5]) ;
        lef_layer("met3")
        lef_port("c_out_air", "OUTPUT", "RECT", [209.5, 109.5, 210.5, 110.5]) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 255, 110]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 255, 110]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 255, 110]) ;
    }
    if (ren_lef)
        lef() ;
}

pump_40px_0(0,0,0,"N", ren_lef=true) ;//, px=1, layer=1/20*10, pitch=0) ;