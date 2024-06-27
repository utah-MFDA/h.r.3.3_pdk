

use <./../../scad_objects/reservoir.scad>


module directional_res_600nl(xpos, ypos, zpos, orientation)
{
    
    res_h = 104 ;

p_reservoir(xpos, ypos, zpos, orientation,
    p1_dir="x-", p2_dir="x+", p1_offset=[0,(res_h-10)/2], p2_offset=[0,-(res_h-10)/2], 
    size=[100, 100, res_h ], edge_rounding=0.2, 
    center=true, clr="gray",
    px=0.0076, layer=0.010, rot=false, pitch=30, layer_offset=10, $fs=0.04, $fa=1) ;
}

directional_res_600nl(0,0,0,"N") ;