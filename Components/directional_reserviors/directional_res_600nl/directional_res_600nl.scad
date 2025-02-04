use <./../../../scad_include/scad_objects/reservoir.scad>
use <./../../../scad_include/lef_helper.scad>

module directional_res_600nl(xpos, ypos, zpos, orientation, px=7.6e-3, layer=10e-3, ren_lef=false)
{
    
    module obj() {
      res_h = 104 ;
      port_len = 25 ;
      translate([(port_len+7)*px,0,0])
      p_reservoir(xpos, ypos, zpos, orientation,
        p1_dir="x-", p2_dir="x+", port_len1=port_len, p1_offset=[13,(res_h-10)/2],
        p2_offset=[13,-(res_h-10)/2], size=[100, 100, res_h ], edge_rounding=0.2, 
        center=true, clr="gray",
        px=0.0076, layer=0.010, rot=false, pitch=30, layer_offset=0, $fs=0.04, $fa=1) ;
    }

    obj() ;
    
    module lef()
    {
        lef_size(210, 150) ;
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 180, 120]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 180, 120]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 180, 120]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 180, 120]) ;
        lef_layer("met5")
        lef_obs("RECT", [30, 30, 180, 120]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 30, 180, 120]) ;
        
        lef_layer("met6")
        lef_port("in_fluid", "INPUT", "RECT", [23, 53, 37, 67]) ;
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [173, 53, 187, 67]) ;
    }
    if (ren_lef)
        lef() ;
}

directional_res_600nl(0,0,0,"N", ren_lef=true) ;
