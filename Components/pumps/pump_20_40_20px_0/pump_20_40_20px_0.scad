
use <../../scad_objects/p_pump.scad>
use <../../scad_use/lef_helper.scad>

module pump_20_40_20px_0(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
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
        lef_size(300, 170) ;
        lef_layer("met1")
        lef_obs("rect",  [30,30,286,136]);
        lef_layer("met2")
        lef_obs("rect",  [30,30,286,136]);
        lef_layer("met3")
        lef_obs("rect",  [30,30,286,136]);
        
        lef_layer("met1")
        lef_port("fluid_in", "INPUT", "rect", [29.5,82.5,30.5,83.5]) ;
        lef_layer("met1")
        lef_port("fluid_out", "OUTPUT", "rect", [285.5,82.5,286.5,83.5]) ;
        
        lef_layer("met3")
        lef_port("air_out_a", "OUTPUT", "rect", [67.5,135.5,68.5,136.5]) ;
        lef_layer("met3")
        lef_port("air_out_b", "OUTPUT", "rect", [157.5,135.5,158.5,136.5]) ;
        lef_layer("met3")
        lef_port("air_out_c", "OUTPUT", "rect", [247.5,135.5,248.5,136.5]) ;
        lef_layer("met3")
        lef_port("air_in_a", "INPUT", "rect", [79.5,29.5,80.5,30.5]) ;
        lef_layer("met3")
        lef_port("air_in_b", "INPUT", "rect", [157.5,29.5,158.5,30.5]) ;
        lef_layer("met3")
        lef_port("air_in_c", "INPUT", "rect", [247.5,29.5,248.5,30.5]) ;
    }
    if(ren_lef)
        lef();
}

pump_20_40_20px_0(0,0,0,"N", ren_lef=true) ;