
use <openmfda/components/lef_helper.scad>
use <openmfda/components/optical_view_centered.scad>

use <openmfda/components/orientation.scad>

module optical_measure_300_5ch(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, pitch=30, lpv=20, fn=30, offset_layer=0, chan=[14, 14, 10], ren_lef=false)
{
    module obj() {
        translate([25,20,lpv*3])
        optical_view_centered("N",
            r_ch=40, i_depth=10, d_depth=5, d_ch_distance=20, num_of_ch=5, init_path_len=27,
            chan_h=10, chan_w=14, shape="cube") ;

        translate([29,120/2,(lpv*4-5)])
        cube(chan, center=true) ;
        translate([571,120/2,(lpv*4-5)])
        cube(chan, center=true) ;
    }
    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    orient([600, 150], orientation)
    translate([0, 15, 0])
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
        orient([600, 150]*px, orientation)
        lef() ;
}

optical_measure_300_5ch(0,0,0,"E", ren_lef=true,  offset_layer=0) ;
