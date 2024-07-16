
use <../../scad_objects/p_pump.scad>
use <../../scad_use/lef_helper.scad>

module pump_20_40_20px_0(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    translate([0,9*px,-10*layer])
    p_pump (xpos, ypos, zpos, orientation,
    r1=20, r2=40, r3=20,
    th1=0.6, th2=0.6, th3=0.6,
    fl_h1=3.1, fl_h2=3.1, fl_h3=3.1,
    pn_h1=4, pn_h2=4, pn_h3=4,
    len_sp=30,
    pn_out_len=20, 
    fl_extra_sp=10, pn_extra_sp="fill-edge",
    px=px, layer=layer, lpv=lpv, chan_h=10, chan_w=14, shape="cube", pitch=pitch, 
    rot=false, no_obj=false, floor_area=false) ;
    
    module lef()
    {
        lef_size(320, 165) ;
        lef_layer("met1")
        lef_obs("rect",  [30,30,300,140]);
        lef_layer("met2")
        lef_obs("rect",  [30,30,300,140]);
        lef_layer("met3")
        lef_obs("rect",  [30,30,300,140]);
        
        lef_layer("met1")
        lef_port("fluid_in", "INPUT", "rect", [29.5,84.5,30.5,85.5]) ;
        lef_layer("met1")
        lef_port("fluid_out", "OUTPUT", "rect", [299.5,84.5,300.5,85.5]) ;
        
        lef_layer("met3")
        lef_port("a_out_air", "OUTPUT", "rect", [74.5,139.5,75.5,140.5]) ;
        lef_layer("met3")
        lef_port("b_out_air", "OUTPUT", "rect", [164.5,139.5,165.5,140.5]) ;
        lef_layer("met3")
        lef_port("c_out_air", "OUTPUT", "rect", [254.5,139.5,255.5,140.5]) ;
        lef_layer("met3")
        lef_port("a_in_air", "INPUT", "rect", [74.5,29.5,75.5,30.5]) ;
        lef_layer("met3")
        lef_port("b_in_air", "INPUT", "rect", [164.5,29.5,165.5,30.5]) ;
        lef_layer("met3")
        lef_port("c_in_air", "INPUT", "rect", [254.5,29.5,255.5,30.5]) ;
    }
    if(ren_lef)
        lef();
}

pump_20_40_20px_0(0,0,0,"N", ren_lef=true) ;