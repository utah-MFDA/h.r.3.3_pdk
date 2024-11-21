use <../../../scad_include/scad_objects/p_chamber.scad>
use <../../../scad_include/lef_helper.scad>

module inline_res_40nl(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    /*
    
    
    */
    translate([0,7*px,0])
    p_chamber(xpos, ypos, zpos, orientation,
    chm_r=30, chm_h=20, chm_len=120,
    conn_ch_w=14, conn_ch_h=10, conn_ch_l=22, 
    px=px, layer=layer, lpv=lpv, chan_h=10, chan_w=14, shape="cube", pitch=pitch, offset_layers=-5, $fn=50,
    rot=false, no_obj=false, floor_area=false) ;
    
    module lef()
    {
        color("blue")
        lef_size(210, 120) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 180, 90]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 180, 90]) ;
        
        lef_layer("met1") 
        lef_port("in_fluid", "INPUT", "RECT", [23, 53, 37, 67]) ;
        lef_layer("met1") 
        lef_port("out_fluid", "INPUT", "RECT", [173, 53, 187, 67]) ;
        
    }
    if(ren_lef)
        lef() ;
    
}

inline_res_40nl(0,0,0,"N", ren_lef=true) ;
