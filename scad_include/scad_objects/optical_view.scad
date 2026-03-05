
use <./../polychannel_v2.scad>
use <./../lef_helper.scad>

module optical_view(xpos, ypos, zpos, orientation,
    r_ch=20, i_depth=10, d_depth=6, d_ch_distance=10, num_of_ch=5, init_path_len=27,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, fn=30, offset_layer=55,
   chan=[10, 10, 14], shape="cube", center_chambers=false, ren_lef=false)
{

    num_ch = num_of_ch ;

    // path defs
    //shape = "cube" ;
    i_dimm = [chan[0], chan[1], i_depth] ;
    nr = [0,[0,0,1]] ;

    // cylinder curve correction
    cc = 3;


    module obj()
    {
        for(i = [0:num_ch-1])
        {
            translate([i*(2*r_ch+d_ch_distance),0,(center_chambers?-d_depth*i/2:0)])
            cylinder(r=r_ch, h=i_depth+d_depth*i, $fn=fn) ;

            d1  = [i_dimm[0], i_dimm[1], i_depth+d_depth*i] ;
            d2  = [i_dimm[0], i_dimm[1], i_depth+d_depth*(i+1)] ;

            pt1 = [
                r_ch+i*(2*r_ch+d_ch_distance)+cc,
                0,
                (center_chambers?
                    i_dimm[2]/2:
                    i_dimm[2]/2+d_depth/2*i)] ;
            pt2 = [
                d_ch_distance+i_dimm[0]/2-cc,
                0,
                (center_chambers?-d_depth/2:0)+d_depth/2] ;

            if(i < num_ch-1)
                polychannel([
                    [shape, d1, pt1, nr],
                    [shape, d2, pt2, nr],
                ]) ;
            polychannel([[shape, i_dimm, [-r_ch,0,i_dimm[2]/2], nr],
                [shape, i_dimm, [-init_path_len,0,0], nr]]) ;

            f_dimm = [i_dimm[0], i_dimm[1], i_dimm[2]+(num_ch-1)*d_depth] ;
            f_pt =
                [(r_ch*2+d_ch_distance)*(num_ch-1)+r_ch-i_dimm[0]/2, 0, center_chambers?i_dimm[2]/2:f_dimm[2]/2] ;

            polychannel([[shape, f_dimm, f_pt, nr],
                [shape, i_dimm, [init_path_len/2, 0, (center_chambers?0:-f_dimm[2]/2+i_dimm[2]/2)], nr],
                [shape, i_dimm, [init_path_len/2, 0, 0], nr]]) ;
        }
    }
    width = 360;
    height = 90;

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    translate([pitch, pitch, offset_layer])
    translate([0,(30)-r_ch,lpv*3])
    translate([init_path_len+r_ch+i_dimm[0]/2, r_ch, 0])
    orient(width, height, orientation)
    obj();

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

optical_view(0,0,0,"N", center_chambers=true) ;
