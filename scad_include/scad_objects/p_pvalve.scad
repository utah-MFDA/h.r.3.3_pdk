
use <../polychannel_v2.scad>

module p_pvalve(xpos, ypos, zpos, orientation,
    valve_r, mem_th, fl_chm_h, pn_chm_h, inport_center=false, 
    // length of channels extending outside of valve radius
    fl_out_len=20, pn_out_len=20,
    fl_out_h  =10, pn_out_h  =10,
    //l1_dwn=1, 
    dwn_chan_h=0, dwn_chan_w=0,
    // extra center spacing if needed when inport_center=false
    fl_extra_sp = 0, pn_extra_sp = 0, rot_pn="true",
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10, $fn=30, flip_fl=false,
    rot=false, no_obj=false, floor_area=false)
{
   
    
    module obj()
    {
        chan_dimm     = [chan_w*px, chan_w*px, chan_h*layer];
        chan_dimm_dwn = [dwn_chan_w*px, dwn_chan_w*px, chan_h*layer];
        translate([0,0,fl_chm_h/2*layer])
            cylinder(fl_chm_h*layer, r=valve_r*px, center=true);
        translate([0,0,(fl_chm_h+mem_th+pn_chm_h/2)*layer])
            cylinder(pn_chm_h*layer, r=valve_r*px, center=true);
        
        // fluid connection channel definitions
        
        inp_pos = (inport_center?
            0:
            (fl_extra_sp=="fill"?-(valve_r-chan_w/2-1)*px:-((valve_r/4+fl_extra_sp)*px)));
        
        outp_pos= (inport_center?
            (valve_r-chan_w/2+fl_extra_sp)*px:
            -inp_pos);
        
        // -----
        
        
        fl_len_0 = (inport_center?
                (fl_out_len>fl_extra_sp?(valve_r-chan_w/2+fl_out_len)*px:
                (valve_r-chan_w/2+fl_out_len)*px)
            : //inport_center (false)
            (fl_extra_sp=="fill"?(fl_out_len+1)*px:
            (valve_r*3/4-chan_w/2-fl_extra_sp+fl_out_len)*px));
        fl_len_1 = (inport_center?
                //(fl_out_len>fl_extra_sp?
                abs(fl_out_len-fl_extra_sp)*px
                //:(0)*px)
            : //inport_center (false)
            (fl_extra_sp=="fill"?(fl_out_len+1)*px:
            (valve_r*3/4-chan_w/2-fl_extra_sp+fl_out_len)*px));
            
        //l2_dwn = fl_out_h*layer - l1_dwn*layer ;
        
        // flip fluid ports
        if(flip_fl)
        {
        polychannel(
            [
            [shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:chan_dimm_dwn), [-inp_pos,0,-chan_h*layer/2], [0,[0,0,1]]],
            //[shape, chan_dimm_dwn, [0,0,-l1_dwn*layer], [0,[0,0,1]]],
            //[shape, chan_dimm, [0,0,-l2_dwn], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [fl_len_0,0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:(inport_center?chan_dimm:chan_dimm_dwn)), 
            [-outp_pos,0,-chan_h*layer/2], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [-fl_len_1,0,0], [0,[0,0,1]]]
        ]);
        } else {
        polychannel(
            [
            [shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:chan_dimm_dwn), [inp_pos,0,-chan_h*layer/2], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [-fl_len_0,0,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, (dwn_chan_h==0 || dwn_chan_w==0?chan_dimm:(inport_center?chan_dimm:chan_dimm_dwn)), 
            [outp_pos,0,-chan_h*layer/2], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,-fl_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [fl_len_1,0,0], [0,[0,0,1]]]
        ]); 
        }
        
        
        // pneumatic channel definitions
        init_z_off = (fl_chm_h+mem_th+pn_chm_h+chan_h/2)*layer;
        pn_pos_lat = (pn_extra_sp=="fill"?
            (valve_r-chan_w/2-1)*px:
            (pn_extra_sp=="fill-edge"?(valve_r+chan_w/2-4)*px:
                (valve_r/4+chan_w/2)*px));
        pn_len     = (pn_extra_sp=="fill"?
            (pn_out_len+1)*px:
            (pn_extra_sp=="fill-edge"?(pn_out_len-chan_w+4)*px:
                (valve_r*3/4-chan_w+pn_out_len)*px));
        
        rotate([0,0,(rot_pn?90:0)])
        {
        polychannel(
            [[shape, chan_dimm, [0,pn_pos_lat,init_z_off], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,pn_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,pn_len,0], [0,[0,0,1]]]
        ]);
        polychannel(
            [[shape, chan_dimm, [0,-pn_pos_lat,init_z_off], [0,[0,0,1]]],
            [shape, chan_dimm, [0,0,pn_out_h*layer], [0,[0,0,1]]],
            [shape, chan_dimm, [0,-pn_len,0], [0,[0,0,1]]]
        ]);
        }
    }
    
    tran_x_offset = (valve_r+fl_out_len)*px;
    tran_y_offset = (valve_r+pn_out_len)*px;
    
    //translate([xpos*px, ypos*px, zpos*layer])
    translate([(pitch-chan_w/2)*px,(pitch-chan_w/2)*px,offset_layers*layer])
    translate([
        (rot?tran_y_offset:tran_x_offset),
        (rot?tran_x_offset:tran_y_offset),
        (fl_out_h+chan_h)*layer]) // hard coded
        rotate([0,0,(rot?90:0)])
        mirror([(orientation=="FN"||orientation=="FS"?1:0),0,0])
        mirror([0,(orientation=="S"||orientation=="FS"?1:0), 0])
            obj();
}

//p_pvalve(0,0,0,"N", 
//    46,4,10,20, inport_center=true, pitch=30, fl_extra_sp=10, pn_extra_sp="fill-edge", offset_layers=0, flip_fl=false);

p_pvalve(0,0,0,"N",
            valve_r=20, 
            mem_th=0.6,
            fl_extra_sp=10,
            fl_chm_h=3.1, 
            pn_chm_h=4, 
            inport_center=true,
            pitch=0,
            fl_out_len=15/2,
            pn_out_len=30/2,
            rot_pn=false,
            pn_extra_sp="fill",
            fl_out_h=10,
            //px=px,
            //layer=layer,
            //chan_h=chan_h, chan_w=chan_w,
            //dwn_chan_h=dwn_chan_h, dwn_chan_w=dwn_chan_w,
            offset_layers=0);
