
use <./../polychannel_v2.scad>
use <./../lef_helper.scad>

module optical_view(xpos, ypos, zpos, orientation,
    r_ch=20, i_depth=10, d_depth=6, d_ch_distance=10, num_of_ch=5, init_path_len=27,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, fn=30, offset_layer=55,
   chan=[10, 10, 14], shape="cube", center_chambers=false, flip_z=false, ren_lef=false)
{
    // chamber defs
    r_chpx = r_ch*px ;
    ipx_dpth = i_depth*layer ;
    dpx_dpth = d_depth*layer ;
    dist_ch= d_ch_distance*px ;
    
    num_ch = num_of_ch ;
    
    // path defs
    //shape = "cube" ;
    i_dimm = [chan[0]*px, chan[1]*px, ipx_dpth] ;
    nr = [0,[0,0,1]] ;
    
    // cylinder curve correction
    cc = 3;
    
    i_path_len = init_path_len * px;
    
    module obj()
    {
        for(i = [0:num_ch-1])
        {
            translate([i*(2*r_chpx+dist_ch),0,(center_chambers?-dpx_dpth*i/2:0)])
            cylinder(r=r_chpx, h=ipx_dpth+dpx_dpth*i, $fn=fn) ;
            
            d1  = [i_dimm[0], i_dimm[1], ipx_dpth+dpx_dpth*i] ;
            d2  = [i_dimm[0], i_dimm[1], ipx_dpth+dpx_dpth*(i+1)] ;
            
            pt1 = [
                r_chpx+i*(2*r_chpx+dist_ch)+cc*px, 
                0, 
                (center_chambers?
                    i_dimm[2]/2:
                    i_dimm[2]/2+dpx_dpth/2*i)] ;
            pt2 = [
                dist_ch+i_dimm[0]/2-cc*px, 
                0, 
                (center_chambers?-dpx_dpth/2:0)+dpx_dpth/2] ;
            
            if(i < num_ch-1)
                polychannel([
                    [shape, d1, pt1, nr],
                    [shape, d2, pt2, nr],
                ]) ;
            polychannel([[shape, i_dimm, [-r_chpx,0,i_dimm[2]/2], nr],
                [shape, i_dimm, [-i_path_len,0,0], nr]]) ;
            
            f_dimm = [i_dimm[0], i_dimm[1], i_dimm[2]+(num_ch-1)*dpx_dpth] ;
            f_pt = 
                [(r_chpx*2+dist_ch)*(num_ch-1)+r_chpx-i_dimm[0]/2, 0, center_chambers?i_dimm[2]/2:f_dimm[2]/2] ;
            
            polychannel([[shape, f_dimm, f_pt, nr],
                [shape, i_dimm, [i_path_len/2, 0, (center_chambers?0:-f_dimm[2]/2+i_dimm[2]/2)], nr],
                [shape, i_dimm, [i_path_len/2, 0, 0], nr]]) ;
        }
    }
   
    translate([xpos*px, ypos*px, zpos*layer])
    translate([pitch*px, pitch*px, offset_layer*layer])
    translate([0,(30)*px-r_chpx,lpv*3*layer])
    mirror([0,0,(flip_z?1:0)])
    translate([i_path_len+r_chpx+i_dimm[0]/2, r_chpx, 0])
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
