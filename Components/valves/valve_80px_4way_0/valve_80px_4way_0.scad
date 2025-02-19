use <../../../scad_include/scad_objects/p_valve_4way.scad>
use <../../../scad_include/lef_helper.scad>

module valve_80px_4way_0 (xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    translate([7*px,-3*px,0])
    // the geometry may not match the lef here, but works in flow
    p_valve_4way(xpos, ypos, zpos, orientation,
        valve_r=40, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false,
        pn_up_layers=15,
        // extra center spacing if needed when inport_center=false
        fl_out_len=27, pn_out_len=-3, 
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
        lef_port("b_fluid", "INOUT", "RECT", [149.5, 89.5, 150.5, 90.5]) ;
        lef_layer("met1")
        lef_port("c_fluid", "INOUT", "RECT",  [89.5, 29.5, 90.5, 30.5]) ;
        lef_layer("met1")
        lef_port("d_fluid", "INOUT", "RECT", [89.5, 149.5, 90.5, 150.5]) ;
        
        lef_layer("met3")
        lef_port("in_air", "INPUT", "RECT", [89.5, 59.5, 90.5, 60.5]) ;
        lef_layer("met3")
        lef_port("out_air", "OUTPUT", "RECT", [89.5, 119.5, 90.5, 120.5]) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 150, 150]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 150, 150]) ;
        lef_layer("met3")
        lef_obs("RECT", [60, 60, 120, 120]) ;
    }
    if (ren_lef)
        lef() ;
}

valve_80px_4way_0(0,0,0,"N", ren_lef=true) ;
