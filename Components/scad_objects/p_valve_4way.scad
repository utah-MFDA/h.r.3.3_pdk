
use <polychannel_v2_testing.scad>

module p_valve_4way(xpos, ypos, zpos, orientation,
    valve_r, mem_th, fl_chm_h, pn_chm_h, 
    // extra center spacing if needed when inport_center=false
    inport_center=false, 
    out_len=30, fl_out_h=10,
    // length of channels extending outside of valve radius
    extra_sp=10, pn_up_layers=10, rot_pn=false,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10,
    no_obj=false, floor_area=false)
{
    
    module obj()
    {
        $fn=30;
        chan_dimm = [chan_w*px, chan_w*px, chan_h*layer];
        translate([0,0,fl_chm_h/2*layer])
            cylinder(fl_chm_h*layer, r=valve_r*px, center=true);
        translate([0,0,(fl_chm_h+mem_th+pn_chm_h/2)*layer])
            cylinder(pn_chm_h*layer, r=valve_r*px, center=true);
        
        // fluid connection channel definitions
        
        //inp_pos = (inport_center?
            //0:
        inp_pos = -(valve_r/4+extra_sp)*px;
        //outp_pos= (inport_center?
            //(valve_r-chan_w/2)*px:
        outp_pos= -inp_pos;
        
        fl_len_0 = (inport_center?
            (valve_r/2+chan_w-extra_sp+out_len)*px:
            (valve_r*3/4-chan_w/2-extra_sp+out_len)*px);
        fl_len_1 = (inport_center?
            (out_len-chan_w/4)*px:
            (valve_r*3/4-chan_w/2-extra_sp+out_len)*px);
        
        polychannel(
            [[shape, chan_dimm, [inp_pos,0,-chan_h/2*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [-fl_len_0,0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, chan_dimm, [outp_pos,0,-chan_h/2*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [fl_len_1,0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, chan_dimm, [0,inp_pos,-chan_h/2*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,-fl_len_0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, chan_dimm, [0,outp_pos,-chan_h/2*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,fl_len_1,0], [0,[0,0,1]]]
        ]);
        
        // pneumatic channel definitions
        init_z_off = (fl_chm_h+mem_th+pn_chm_h)*layer;
        pn_pos_lat = (valve_r/4+chan_w/2)*px;
        pn_len     = (valve_r*3/4-chan_w+out_len)*px;
        
        rotate([0,0,(rot_pn?90:0)])
        {
        polychannel(
            [[shape, chan_dimm, [0,pn_pos_lat,init_z_off], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,pn_up_layers*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,pn_len,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, chan_dimm, [0,-pn_pos_lat,init_z_off], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,pn_up_layers*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,-pn_len,0], [0,[0,0,1]]]
        ]);
        }
    }
    
    tran_offset = (out_len+valve_r)*px;
    
    translate([xpos, ypos, zpos])
    translate([pitch*px,pitch*px,layer*offset_layers])
    translate([tran_offset,tran_offset,(20+chan_h)*layer])
        obj();
}

p_valve_4way(0,0,0,"N", 
    50,4,10,20, false);