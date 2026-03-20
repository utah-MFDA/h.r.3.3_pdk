use <../polychannel_v2.scad>
use <../orientation.scad>

/**
 * xpos, ypos: position in pixels.
 * zpos: position in layers
 * orientation: string enum, see orient module.
 * fl_ext_len, fl_tran_len, fl_ext_th_len: fluid channel parameters, in pixels.
 * pn_ch_w, pn_pad, pn_len: pneumatic channel parameters, in pixels.
 * pn_bttm_chm_h: pneumatic channel parameters in layers
 * px: millimeters per pixel
 * layer: millimeters per layer
 * chan_h: channel height in layers.
 * chan_w: channel width in pixels.
 * shape: channel shape, see polychannel.
 * pitch: distance between channels, in pixels
*/
module p_squeeze_valve(xpos, ypos, zpos, orientation,
    mem_th, fl_chm_h,
    // fluid channel parameters
    fl_ext_len=30, fl_tran_len=5, fl_ext_th_len=4,
    // pneumatic channel parameters
    pn_ch_w=14, pn_pad = 10, pn_len = 30, pn_bttm_chm_h=20,
    // set if transition state
    no_out_transition=false, no_in_transition=false,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10)
{
    no_rot = [0,[0,0,1]];

    pn_chan_dimm = [pn_ch_w, chan_w, chan_h];
    pn_chm_offset= (mem_th*2+fl_chm_h);
    pn_chm_h = pn_bttm_chm_h;

    //fl_ext_len  = 30;
    //fl_tran_len = 5;
    ifl_chan_dimm = [1, chan_w, chan_h] ;
    fl_chan_dimm  = [1, chan_w, fl_chm_h] ;

    module obj() {

        //pneumatic channel
        polychannel([
            [shape, pn_chan_dimm, [0,-pn_len,0], no_rot],
            [shape, pn_chan_dimm, [0,2*pn_len,0], no_rot]
        ]);
        translate([0,(chan_w/2+pn_pad),-pn_chm_offset/2-chan_h/2])
            cube([pn_ch_w, chan_w, pn_chm_offset], center=true);
        translate([0,-(chan_w/2+pn_pad),-pn_chm_offset/2-chan_h/2])
            cube([pn_ch_w, chan_w, pn_chm_offset], center=true);
        bttm_chm_l = (chan_w*2+pn_pad*2);
        translate([0,0,-pn_chm_offset-(chan_h/2+pn_chm_h/2)])
            cube([pn_ch_w, bttm_chm_l, pn_chm_h], center=true);

        //fluid channel

        fl_z_offset = (chan_h/2+mem_th+fl_chm_h/2) ;
        fl_pt_1 = (fl_ext_len-fl_tran_len-pn_ch_w/2-fl_ext_th_len) ;

        polychannel([
            [shape, (no_in_transition?fl_chan_dimm:ifl_chan_dimm), [-fl_ext_len, 0, -fl_z_offset], no_rot],
            [shape, (no_in_transition?fl_chan_dimm:ifl_chan_dimm), [fl_pt_1, 0,0], no_rot],
            [shape, fl_chan_dimm, [fl_tran_len, 0,0], no_rot],
            [shape, fl_chan_dimm, [(pn_ch_w+fl_ext_th_len*2), 0,0], no_rot],
            [shape, (no_out_transition?fl_chan_dimm:ifl_chan_dimm), [fl_tran_len, 0,0], no_rot],
            [shape, (no_out_transition?fl_chan_dimm:ifl_chan_dimm), [fl_pt_1, 0,0], no_rot],

        ]);
    }

    z_offset = (chan_h/2+mem_th*2+fl_chm_h+pn_bttm_chm_h) ;
    x_off = (fl_ext_len+0.5) ;
    y_off = (pn_len+chan_w/2) ;
    pitch_offset = pitch - chan_w;

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    translate([pitch_offset/2, pitch_offset/2, 0])
    orient([2*x_off, 2*y_off], orientation)
    translate([x_off, y_off, z_offset])
        obj();

}

p_squeeze_valve(0,0,0,"N",4,8);
