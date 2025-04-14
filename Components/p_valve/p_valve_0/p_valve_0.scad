
use <../../../scad_include/scad_objects/p_valve.scad>
use <../../../scad_include/lef_helper.scad>

module p_valve_0(xpos, ypos, zpos, orientation,
    D,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    // olen = (((D/pitch) - D%pitch/pitch +2)*pitch - D)/2;
    olen = 5 ;
    
    translate([
        (2+(D/(pitch*2) - D%(pitch*2)/(pitch*2)))*px, 
        (2+(D/(pitch*2) - D%(pitch*2)/(pitch*2)))*px, 
        1*lpv*layer])
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=D/2, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false,
        // length of channels extending outside of valve radius
        out_len=olen, fl_extra_sp = 4, fl_chan_down_layers=10, 
        pn_extra_sp="fill", pn_chan_up_layers=12, rot_pn=false,
        // extra center spacing if needed when inport_center=false
        extra_sp = 0, 
        px=px, layer=layer, lpv=lpv, chan_h=6, chan_w=8, shape="cube", pitch=pitch, 
        offset_layers=5, no_obj=false, floor_area=false) ;
    
    if (ren_lef)
        lef() ;
    
}

p_valve_0(0,0,0,"N", 40, ren_lef=false) ;//, px=1, pitch=0) ;
