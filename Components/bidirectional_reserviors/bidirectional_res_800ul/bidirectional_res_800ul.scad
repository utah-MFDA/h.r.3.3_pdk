
use <./../../scad_objects/reservoir.scad>
use <./../../scad_use/lef_helper.scad>

module bidirectional_res_800ul(xpos, ypos, zpos, orientation, px=7.6e-3, layer=10e-3, ren_lef=false)
{
    
    res_h = 140 ;
port_len = 10 ;
translate([0,0,(port_len)*layer])
p_reservoir(xpos, ypos, zpos, orientation,
    p1_dir="z-", p2_dir="z-", port_len1=port_len, p1_offset=[0,(100-14)/2], p2_offset=[0,-(100-14)/2], 
    size=[100, 100, res_h ], edge_rounding=0.2, 
    center=true, clr="gray",
    px=0.0076, layer=0.010, rot=false, pitch=30, layer_offset=10, $fs=0.04, $fa=1) ;
    
    module lef()
    {
        lef_size(150, 150) ;
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met5")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met7")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        lef_layer("met8")
        lef_obs("RECT", [30, 30, 115, 115]) ;
        
        lef_layer("met1")
        lef_port("in_fluid", "INPUT", "RECT", [72.5, 29.5, 73.5, 30.5]) ;
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [72.5, 114.5, 73.5, 115.5]) ;
    }
    if (ren_lef)
        lef() ;
}

bidirectional_res_800ul(0,0,0,"N", ren_lef=true) ;