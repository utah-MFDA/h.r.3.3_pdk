
use <./../../scad_use/lef_helper.scad>
use <./../../scad_objects/optical_view.scad>

module optical_measure_100_5ch(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, pitch=30, lpv=20, fn=30, offset_layer=0, ren_lef=false)
{
    translate([0,0,15*layer])
    optical_view(xpos, ypos, zpos, orientation,
    r_ch=20, i_depth=10, d_depth=5, d_ch_distance=10, num_of_ch=5, init_path_len=27,
    px=px, layer=layer, lpv=lpv, pitch=pitch, fn=30, offset_layer=offset_layer,
   chan=[10, 10, 14], shape="cube", center_chambers=true, flip_z=false) ;
    
    module lef()
    {
        lef_size(360, 120) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met5")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met7")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met8")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met9")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        
        lef_layer("met4")
        lef_port("in_fluid", "INPUT", "RECT", [29.5, 59.5, 30.5, 60.5]) ;
        
        lef_layer("met4")
        lef_port("out_fluid", "OUTPUT", "RECT", [329.5, 59.5, 330.5, 60.5]) ;
    }
    if(ren_lef)
        lef() ;
}

optical_measure_100_5ch(0,0,0,"N", ren_lef=true) ;
