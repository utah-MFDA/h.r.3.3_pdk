
use <openmfda/components/lef_helper.scad>
use <openmfda/components/optical_view_centered.scad>
use <openmfda/components/orientation.scad>

module optical_measure_100_5ch(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, pitch=30, lpv=20, fn=30, offset_layer=0, chan=[14, 14, 10], ren_lef=false)
{
    module obj() {
        translate([30,40,3*lpv])
        optical_view_centered("N",
            r_ch=20, i_depth=10, d_depth=5, d_ch_distance=10, num_of_ch=5, init_path_len=27,
            
            chan_w=10, chan_h=14, shape="cube") ;

        chan_sz = chan;


        translate([29,120/2,(lpv*4-5)])
        cube(chan_sz, center=true) ;

        translate([331,120/2,(lpv*4-5)])
        cube(chan_sz, center=true) ;
    }
    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    orient([360,120], orientation)
    obj() ;

    module lef()
    {
        lef_size(360, 120) ;

        lef_layer("met1")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met3")
        lef_obs("RECT", [40, 30, 320, 90]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met5")
        lef_obs("RECT", [40, 30, 320, 90]) ;
        lef_layer("met6")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met7")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met8")
        lef_obs("RECT", [30, 30, 330, 90]) ;
        lef_layer("met9")
        lef_obs("RECT", [30, 30, 330, 90]) ;

        lef_layer("met4")
        lef_port("in_fluid", "INPUT", "RECT", [23, 53, 37, 67]) ;

        lef_layer("met4")
        lef_port("out_fluid", "OUTPUT", "RECT", [323, 53, 337, 67]) ;
    }
    if(ren_lef)
        lef() ;
}

optical_measure_100_5ch(0,0,0,"N", ren_lef=true) ;
