use <./../../../scad_include/scad_objects/reservoir.scad>
use <./../../../scad_include/lef_helper.scad>


module directional_res_1000nl(xpos, ypos, zpos, orientation,
  px=0.0076, layer=0.01
)
{
    
    res_h = 140 ;

    translate([37*px,0,0])
p_reservoir(xpos, ypos, zpos, orientation,
    p1_dir="x-", p2_dir="x+",
    p1_offset=[0,(res_h-10)/2], p2_offset=[0,-(res_h-10)/2], 
    port_len1=30,
    size=[124, 100, res_h ], edge_rounding=0.2, 
    center=true, clr="gray",
    px=0.0076, layer=0.010, rot=false, pitch=30, layer_offset=0, $fs=0.04, $fa=1,
    ren_lef=false
    ) ;

    module lef()
    {
        lef_size(245, 150) ;
        lef_layer("met1")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met5")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met7")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        lef_layer("met8")
        lef_obs("RECT", [30, 20, 215, 130]) ;
        
        lef_layer("met8")
        lef_port("in_fluid", "INPUT", "RECT", [23, 66, 37, 80]) ;
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [208, 66, 222, 80]) ;
    }
    if (ren_lef)
        lef() ;
}

directional_res_1000nl(0,0,0,"N", ren_lef=true) ;
