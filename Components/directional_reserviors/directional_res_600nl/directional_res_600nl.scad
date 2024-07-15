

use <./../../scad_objects/reservoir.scad>
use <./../../scad_use/lef_helper.scad>



module directional_res_600nl(xpos, ypos, zpos, orientation, px=7.6e-3, layer=10e-3, ren_lef=false)
{
    
    res_h = 104 ;
    port_len = 10 ;
translate([(port_len+7)*px,0,0])
p_reservoir(xpos, ypos, zpos, orientation,
    p1_dir="x-", p2_dir="x+", port_len1=port_len, p1_offset=[0,(res_h-10)/2], p2_offset=[0,-(res_h-10)/2], 
    size=[100, 100, res_h ], edge_rounding=0.2, 
    center=true, clr="gray",
    px=0.0076, layer=0.010, rot=false, pitch=30, layer_offset=0, $fs=0.04, $fa=1) ;
    
    module lef()
    {
        lef_size(160, 160) ;
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 150, 115]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 150, 115]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 150, 115]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 150, 115]) ;
        lef_layer("met5")
        lef_obs("RECT", [30, 30, 150, 115]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 30, 150, 115]) ;
        
        lef_layer("met6")
        lef_port("in_fluid", "INPUT", "RECT", [29.5, 72.5, 30.5, 73.5]) ;
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [149.5, 72.5, 150.5, 73.5]) ;
    }
    if (ren_lef)
        lef() ;
}

directional_res_600nl(0,0,0,"N", ren_lef=true) ;
