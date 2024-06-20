
use <../../scad_use/polychannel_v2.scad>
use <../../scad_objects/p_pump.scad>
use <../../scad_use/lef_helper.scad>

module pump_20px_0(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, offset_layers=10,ren_lef=false)
{
    
    p_pump (xpos, ypos, zpos, orientation,
    r1=20, r2=20, r3=20,
    th1=0.6, th2=0.6, th3=0.6,
    fl_h1=3.1, fl_h2=3.1, fl_h3=3.1,
    pn_h1=4, pn_h2=4, pn_h3=4,
    len_sp=30, ends_ex_len=20,
    pn_out_len=20, 
    fl_extra_sp=10, pn_extra_sp="fill-edge", 
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=offset_layers,
    rot=false, no_obj=false, floor_area=false) ;
    
    
    module lef()
    {
        lef_layer("met1")
        lef_obs("rect",  [30,30,280,110]);
        lef_layer("met2")
        lef_obs("rect",  [30,30,280,110]);
        lef_layer("met3")
        lef_obs("rect",  [30,30,280,110]);
        
        lef_layer("met1")
        lef_port("rect", [29.5,62.5,30.5,63.5]) ;
        lef_layer("met1")
        lef_port("rect", [269,62.5,270.5,63.5]) ;
        
        lef_layer("met3")
        lef_port("rect", [77.5,99.5,78.5,100.5]) ;
        lef_layer("met3")
        lef_port("rect", [147.5,99.5,148.5,100.5]) ;
        lef_layer("met3")
        lef_port("rect", [217.5,99.5,218.5,100.5]) ;
        lef_layer("met3")
        lef_port("rect", [77.5,29.5,78.5,30.5]) ;
        lef_layer("met3")
        lef_port("rect", [147.5,29.5,148.5,30.5]) ;
        lef_layer("met3")
        lef_port("rect", [217.5,29.5,218.5,30.5]) ;
    }
    if(ren_lef)
    {
        lef();
    }
}

pump_20px_0(0,0,0,"N",offset_layers=0, ren_lef=true) ;