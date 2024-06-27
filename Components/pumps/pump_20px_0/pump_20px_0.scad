
use <../../scad_use/polychannel_v2.scad>
use <../../scad_objects/p_pump.scad>
use <../../scad_use/lef_helper.scad>

module pump_20px_0(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, offset_layers=10,ren_lef=false)
{
    translate([0,-0*px,0])
    p_pump (xpos, ypos, zpos, orientation,
    r1=20, r2=20, r3=20,
    th1=0.6, th2=0.6, th3=0.6,
    fl_h1=3.1, fl_h2=3.1, fl_h3=3.1,
    pn_h1=4, pn_h2=4, pn_h3=4,
    len_sp=30, ends_ex_len=22,
    pn_out_len=22, 
    fl_extra_sp=10, pn_extra_sp="fill-edge", 
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=offset_layers,
    rot=false, no_obj=false, floor_area=false) ;
    
    
    module lef()
    {
        lef_size(300, 130) ;
        lef_layer("met1")
        lef_obs("rect",  [30,30,270,100]);
        lef_layer("met2")
        lef_obs("rect",  [30,30,270,100]);
        lef_layer("met3")
        lef_obs("rect",  [30,30,270,100]);
        
        lef_layer("met1")
        lef_port("fluid_in", "INPUT", "rect", [29.5,64.5,30.5,65.5]) ;
        lef_layer("met1")
        lef_port("fluid_out", "OUTPUT", "rect", [269.5,64.5,270.5,65.5]) ;
        
        lef_layer("met3")
        lef_port("air_out_a", "OUTPUT", "rect", [79.5,99.5,80.5,100.5]) ;
        lef_layer("met3")
        lef_port("air_out_b", "OUTPUT", "rect", [149.5,99.5,150.5,100.5]) ;
        lef_layer("met3")
        lef_port("air_out_c", "OUTPUT", "rect", [219.5,99.5,220.5,100.5]) ;
        lef_layer("met3")
        lef_port("air_in_a", "INPUT", "rect", [79.5,29.5,80.5,30.5]) ;
        lef_layer("met3")
        lef_port("air_in_b", "INPUT", "rect", [149.5,29.5,150.5,30.5]) ;
        lef_layer("met3")
        lef_port("air_in_c", "INPUT", "rect", [219.5,29.5,220.5,30.5]) ;
    }
    if(ren_lef)
        lef();
}

pump_20px_0(0,0,0,"N",offset_layers=0, ren_lef=true) ;