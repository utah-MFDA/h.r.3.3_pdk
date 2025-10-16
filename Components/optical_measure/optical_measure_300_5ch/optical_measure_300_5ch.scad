
use <../../../scad_include/lef_helper.scad>
use <../../../scad_include/scad_objects/optical_view.scad>

module optical_measure_300_5ch(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, pitch=30, lpv=20, fn=30, offset_layer=0, chan=[14, 14, 10], ren_lef=false)
{
    module obj() {
        translate([0,0,(10)*layer])
        optical_view(xpos, ypos, zpos, orientation,
        r_ch=40, i_depth=10, d_depth=5, d_ch_distance=20, num_of_ch=5, init_path_len=27,
        px=px, layer=layer, lpv=lpv, pitch=pitch, fn=30, offset_layer=offset_layer,
       chan=[10, 10, 14], shape="cube", center_chambers=true, flip_z=false) ;
        
        chan_sz = [chan[0]*px, chan[1]*px, chan[2]*layer] ;
        
        translate([xpos*px, ypos*px, zpos*layer])
        translate([29*px,120/2*px,(lpv*4-5)*layer])
        cube(chan_sz, center=true) ;
        
        translate([xpos*px, ypos*px, zpos*layer])
        translate([571*px,120/2*px,(lpv*4-5)*layer])
        cube(chan_sz, center=true) ;
    }
    
    translate([0, 15*px, -lpv*layer])
    obj() ;
    
    module lef()
    {
        lef_size(600, 150) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        lef_layer("met3")
        lef_obs("RECT", [40, 30, 560, 120]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        lef_layer("met5")
        lef_obs("RECT", [40, 30, 560, 120]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        lef_layer("met7")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        lef_layer("met8")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        lef_layer("met9")
        lef_obs("RECT", [30, 30, 570, 120]) ;
        
        lef_layer("met4")
        lef_port("in_fluid", "INPUT", "RECT", [23, 68, 37, 82]) ;
        
        lef_layer("met4")
        lef_port("out_fluid", "OUTPUT", "RECT", [563, 68, 577, 82]) ;
    }
    if(ren_lef)
        lef() ;
}

optical_measure_300_5ch(0,0,0,"N", ren_lef=true, offset_layer=0) ;
