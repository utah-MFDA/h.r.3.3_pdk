
use <../polychannel_v2.scad>
use <p_squeeze_valve.scad>

module p_squeeze_pump(xpos, ypos, zpos, orientation,
    mem_th, fl_chm_h,
    valve_sp=30,
    // fluid channel parameters
    fl_ext_len=30, fl_tran_len=5, fl_ext_th_len=4, 
    // pneumatic channel parameters
    pn_ch_w=14, pn_pad = 14, pn_len = 40, pn_bttm_chm_h=20, 
    // set if transition state
    no_out_transition=false, no_in_transition=false,
    // extra center spacing if needed when inport_center=false
    extra_sp = 0,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10,
    no_obj=false, floor_area=false)
{
    module obj() {
        
        p_squeeze_valve(0,0,0,"N",
            mem_th, fl_chm_h,
            fl_ext_len=fl_ext_len,
            fl_tran_len=fl_tran_len,
            fl_ext_th_len=fl_ext_th_len,
            pn_ch_w=pn_ch_w,
            pn_pad=pn_pad,
            pn_len=pn_len,
            pn_bttm_chm_h=pn_bttm_chm_h,
            pitch=0, 
            offset_layers=offset_layers,
            px=px, layer=layer,
            no_out_transition=true);
        p_squeeze_valve((valve_sp+pn_ch_w)*px,0,0,"N",
            mem_th, fl_chm_h,
            pn_ch_w=pn_ch_w,
            pn_pad=pn_pad,
            pn_len=pn_len,
            pn_bttm_chm_h=pn_bttm_chm_h,
            pitch=0, 
            offset_layers=offset_layers,
            px=px, layer=layer,
            no_out_transition=true,
            no_in_transition=true);
        p_squeeze_valve((valve_sp+pn_ch_w)*px*2,0,0,"N",
            mem_th, fl_chm_h,
            fl_ext_len=fl_ext_len,
            fl_tran_len=fl_tran_len,
            fl_ext_th_len=fl_ext_th_len,
            pn_ch_w=pn_ch_w,
            pn_pad=pn_pad,
            pn_len=pn_len,
            pitch=0, 
            offset_layers=offset_layers,
            px=px, layer=layer,
            pn_bttm_chm_h=pn_bttm_chm_h,
            no_in_transition=true);
    }
    
    translate([xpos, ypos, zpos])
    translate([(pitch-chan_w/2)*px, (pitch-chan_w/2)*px, 0])
        obj();
}

p_squeeze_pump(0,0,0,"N", mem_th=4, fl_chm_h=6,
    pn_ch_w=18);
