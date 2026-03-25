use <../polychannel_v2.scad>
use <../orientation.scad>

/**
 * xpos, ypos: position in pixels.
 * zpos: position in layers
 * orientation: string enum, see orient module.
 * valve_r: valve chamber radius in pixels.
 * mem_th: membrane thickness in layers.
 * fl_chm_h: fluid chamber depth in layers.
 * pn_chm_h: pneumatic chamber depth in layers.
 * inport_center: boolean, changes location of ports.
 * fl_out_len: channel leads length, in pixels.
 * fl_out_h: channel leads height, in layers.
 * pn_out_len: channel leads length, in pixels.
 * pn_out_h: channel leads height, in layers.
 * dwn_chan_h, dwn_chan_w: cross section of depthwise channels, in pixels.
 * fl_extra_sp, pn_extra_sp: offset in pixels
 * rot_pn: rotate the pneumatic axis, boolean.
 * flip_fl: boolean
 * px: millimeters per pixel
 * layer: millimeters per layer
 * chan_h: channel height in layers.
 * chan_w: channel width in pixels.
 * shape: channel shape, see polychannel.
 * pitch: distance between channels, in pixels
*/
module valve(
    valve_r, mem_th, fl_chm_h, pn_chm_h, inport_center=false,
    // length of channels extending outside of valve radius
    fl_out_len=20, pn_out_len=20,
    fl_out_h  =10, pn_out_h  =10,
    //l1_dwn=1,
    dwn_chan_h=0, dwn_chan_w=0,
    // extra center spacing if needed when inport_center=false
    fl_extra_sp = 0, pn_extra_sp = 0, rot_pn=true,flip_fl=false,
    chan_h=10, chan_w=14, shape="cube", $fn=30)
{

    chan_dimm     = [chan_w, chan_w, chan_h];
    chan_dimm_dwn = [dwn_chan_w, dwn_chan_w, chan_h];
    translate([0,0,fl_chm_h/2])
        cylinder(fl_chm_h, r=valve_r, center=true);
    translate([0,0,(fl_chm_h+mem_th+pn_chm_h/2)])
        cylinder(pn_chm_h, r=valve_r, center=true);

    // fluid connection channel definitions

    inp_pos = (inport_center?
        0:
        (fl_extra_sp=="fill"?-(valve_r-chan_w/2-1):-((valve_r/4+fl_extra_sp))));

    outp_pos= (inport_center?
        (valve_r-chan_w/2+fl_extra_sp):
        -inp_pos);

    // -----


    fl_len_0 = (inport_center?
            (fl_out_len>fl_extra_sp?(valve_r-chan_w/2+fl_out_len):
            (valve_r-chan_w/2+fl_out_len))
        : //inport_center (false)
        (fl_extra_sp=="fill"?(fl_out_len+1):
        (valve_r*3/4-chan_w/2-fl_extra_sp+fl_out_len)));
    fl_len_1 = (inport_center?
            //(fl_out_len>fl_extra_sp?
            abs(fl_out_len-fl_extra_sp)
            //:(0))
        : //inport_center (false)
        (fl_extra_sp=="fill"?(fl_out_len+1):
        (valve_r*3/4-chan_w/2-fl_extra_sp+fl_out_len)));


    // flip fluid ports
    if(flip_fl)
    {
        polychannel(
            [
            [shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:chan_dimm_dwn), [-inp_pos,0,-chan_h/2], [0,[0,0,1]]],
            //[shape, chan_dimm_dwn, [0,0,-l1_dwn], [0,[0,0,1]]],
            //[shape, chan_dimm, [0,0,-l2_dwn], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h], [0,[0,0,1]]],
            [shape, chan_dimm, [fl_len_0,0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:(inport_center?chan_dimm:chan_dimm_dwn)),
            [-outp_pos,0,-chan_h/2], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h], [0,[0,0,1]]],
            [shape, chan_dimm, [-fl_len_1,0,0], [0,[0,0,1]]]
        ]);
    } else {
        polychannel(
            [
            [shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:chan_dimm_dwn), [inp_pos,0,-chan_h/2], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h], [0,[0,0,1]]],
            [shape, chan_dimm, [-fl_len_0,0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:(inport_center?chan_dimm:chan_dimm_dwn)),
            [outp_pos,0,-chan_h/2], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h], [0,[0,0,1]]],
            [shape, chan_dimm, [fl_len_1,0,0], [0,[0,0,1]]]
        ]);
    }


    // pneumatic channel definitions
    init_z_off = (fl_chm_h+mem_th+pn_chm_h+chan_h/2);
    pn_pos_lat = (pn_extra_sp=="fill"?
        (valve_r-chan_w/2-1):
        (pn_extra_sp=="fill-edge"?(valve_r+chan_w/2-4):
            (valve_r/4+chan_w/2)));
    pn_len     = (pn_extra_sp=="fill"?
        (pn_out_len+1):
        (pn_extra_sp=="fill-edge"?(pn_out_len-chan_w+4):
            (valve_r*3/4-chan_w+pn_out_len)));

    rotate([0,0,(rot_pn?90:0)])
    {
        polychannel(
            [[shape, chan_dimm, [0,pn_pos_lat,init_z_off], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,pn_out_h], [0,[0,0,1]]],
            [shape, chan_dimm, [0,pn_len,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, chan_dimm, [0,-pn_pos_lat,init_z_off], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,pn_out_h], [0,[0,0,1]]],
            [shape, chan_dimm, [0,-pn_len,0], [0,[0,0,1]]]
        ]);
    }
}




/**
 * xpos, ypos: position in pixels.
 * zpos: position in layers
 * orientation: string enum, see orient module.
 * valve_r: valve chamber radius in pixels.
 * mem_th: membrane thickness in layers.
 * fl_chm_h: fluid chamber depth in layers.
 * pn_chm_h: pneumatic chamber depth in layers.
 * inport_center: boolean, changes location of ports.
 * fl_out_len: channel leads length, in pixels.
 * fl_out_h: channel leads height, in layers.
 * pn_out_len: channel leads length, in pixels.
 * pn_out_h: channel leads height, in layers.
 * dwn_chan_h, dwn_chan_w: cross section of depthwise channels, in pixels.
 * fl_extra_sp, pn_extra_sp: offset in pixels
 * rot_pn: rotate the pneumatic axis, boolean.
 * flip_fl: boolean
 * px: millimeters per pixel
 * layer: millimeters per layer
 * chan_h: channel height in layers.
 * chan_w: channel width in pixels.
 * shape: channel shape, see polychannel.
 * pitch: distance between channels, in pixels
*/
module p_valve(xpos, ypos, zpos, orientation,
    valve_r, mem_th, fl_chm_h, pn_chm_h, inport_center=false,
    // length of channels extending outside of valve radius
    fl_out_len=20, pn_out_len=20,
    fl_out_h  =10, pn_out_h  =10,
    //l1_dwn=1,
    dwn_chan_h=0, dwn_chan_w=0,
    // extra center spacing if needed when inport_center=false
    fl_extra_sp = 0, pn_extra_sp = 0, rot_pn=true,flip_fl=false,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, $fn=30)
{
    // If the channels are inline, pick the biggest
    height = rot_pn
            ? 2*valve_r
            : 2*(valve_r + fl_out_len);
    width = rot_pn
            ? 2*(valve_r + max(pn_out_len, fl_out_len))
            : 2*(valve_r + pn_out_len);

    pitch_offset = pitch - chan_w;

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    translate([pitch_offset/2, pitch_offset/2, 0])
    orient([width, height], orientation)
    translate([width/2, height/2, fl_out_h+chan_h])
        valve(
            valve_r, mem_th, fl_chm_h, pn_chm_h, inport_center,
            fl_out_len, pn_out_len,
            fl_out_h  , pn_out_h  ,
            dwn_chan_h, dwn_chan_w,
            fl_extra_sp, pn_extra_sp, rot_pn,flip_fl,
            chan_h, chan_w, shape, $fn);
}

p_valve(0, 0, 0, "E", 100, 5, 10, 15);
