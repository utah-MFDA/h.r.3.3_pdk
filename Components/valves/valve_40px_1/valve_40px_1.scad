
use <./../../scad_objects/p_valve.scad>
use <./../../scad_use/lef_helper.scad>

module valve_40px_1(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=20, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=true,
        // length of channels extending outside of valve radius
        out_len=14, fl_extra_sp = 4, fl_chan_down_layers=10, 
        pn_extra_sp="fill", pn_chan_up_layers=10, rot_pn=false,
        // extra center spacing if needed when inport_center=false
        extra_sp = 0, 
        px=px, layer=layer, lpv=lpv, chan_h=6, chan_w=8, shape="cube", pitch=pitch, 
        no_obj=false, floor_area=false) ;
    
    module lef()
    {
        color("blue")
        lef_size(120, 120);
        
        lef_layer("met1")
        lef_port("in_fluid", "INPUT", "RECT",  [29.5, 59.5, 30.5, 60.5]) ;
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [89.5, 59.5, 90.5, 60.5]) ;
        
        lef_layer("met3")
        lef_port("in_air", "INPUT", "RECT", [59.5, 29.5, 60.5, 30.5]) ;
        lef_layer("met3")
        lef_port("out_air", "OUTPUT", "RECT", [59.5, 89.5, 60.5, 90.5]) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 90, 90]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 90, 90]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 90, 90]) ;
    }
    if (ren_lef)
        lef() ;
    
}

valve_40px_1(0,0,0,"N", ren_lef=true) ;//, px=1, pitch=0) ;
