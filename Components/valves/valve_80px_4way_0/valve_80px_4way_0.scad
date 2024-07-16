
use <./../../scad_objects/p_valve_4way.scad>
use <./../../scad_use/lef_helper.scad>

module valve_80px_4way_0 (xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    p_valve_4way(xpos, ypos, zpos, orientation,
        valve_r=40, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false, 
        // extra center spacing if needed when inport_center=false
        fl_out_len=30, pn_out_len=30, 
        // length of channels extending outside of valve radius
        fl_extra_sp=10, pn_extra_sp=10, 
        px=px, layer=layer, lpv=lpv, chan_h=10, chan_w=14, shape="cube", pitch=pitch, offset_layers=-10,
        no_obj=false, floor_area=false) ;
    
    module lef()
    {
        color("yellow")
        lef_size(190, 190);
        
        lef_layer("met1")
        lef_port("a_fluid", "INOUT", "RECT",  [29.5, 89.5, 30.5, 90.5]) ;
        lef_layer("met1")
        lef_port("b_fluid", "INOUT", "RECT", [159.5, 89.5, 160.5, 90.5]) ;
        lef_layer("met1")
        lef_port("c_fluid", "INOUT", "RECT",  [89.5, 29.5, 90.5, 30.5]) ;
        lef_layer("met1")
        lef_port("d_fluid", "INOUT", "RECT", [89.5, 159.5, 90.5, 160.5]) ;
        
        lef_layer("met3")
        lef_port("in_air", "INPUT", "RECT", [89.5, 29.5, 90.5, 30.5]) ;
        lef_layer("met3")
        lef_port("out_air", "OUTPUT", "RECT", [89.5, 159.5, 90.5, 160.5]) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 160, 160]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 160, 160]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 160, 160]) ;
    }
    if (ren_lef)
        lef() ;
}

valve_80px_4way_0(0,0,0,"N", ren_lef=true) ;
