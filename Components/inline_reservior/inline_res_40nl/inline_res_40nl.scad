
use <./../../scad_objects/p_chamber.scad>

module inline_res_40nl(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30)
{
    /*
    
    
    */
    
    p_chamber(xpos, ypos, zpos, orientation,
    chm_r=30, chm_h=20, chm_len=120,
    conn_ch_w=14, conn_ch_h=10, conn_ch_l=20, 
    px=px, layer=layer, lpv=lpv, chan_h=10, chan_w=14, shape="cube", pitch=pitch, offset_layers=10, $fn=50,
    rot=false, no_obj=false, floor_area=false) ;
    
}

inline_res_40nl(0,0,0,"N") ;