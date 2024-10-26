use <../polychannel_v2.scad>
use <p_pvalve.scad>

module p_pump(xpos, ypos, zpos, orientation,
    r1=46, r2=46, r3=46,
    th1 = 10, th2 = 10, th3 = 10,
    fl_h1=10, fl_h2=10, fl_h3=10,
    pn_h1=14, pn_h2=14, pn_h3=14,
    len_sp=30, pn_out_len=20, 
    fl_extra_sp=4, pn_extra_sp="fill",
    fl_out_h=10, pn_out_h=10, ends_ex_len=10,
    dwn_chan_h=0, dwn_chan_w=0,
    port_chan_h=0, port_chan_w=0,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10,
    rot=false, no_obj=false, floor_area=false){
    
    module obj() {
        r_max = max(r1, r2, r3);
    
        //ex_len = 30*px;
        
        dimm  = [chan_w*px,chan_w*px,chan_h*layer] ;
        dimmp = [port_chan_w*px,port_chan_w*px,port_chan_h*layer] ;
        pt0_0 = [chan_w/2*px,(r_max-chan_w/2+pn_out_len)*px,chan_h/2*layer] ;
        pt0_1 = [ends_ex_len*px,0,0] ;
        
        pt1_0 = [
            (r1*2+r2*2+r3*2+len_sp*3+ends_ex_len+chan_w/2)*px,
            (r_max-chan_w/2+pn_out_len)*px,
            chan_h/2*layer] ;
        pt1_1 = [ends_ex_len*px,0,0] ;
        // check 1      
        //translate([0,(r_max-r1)*px,0])
        translate([(ends_ex_len+chan_w)*px, 0,0]){
        //translate([0, 0,0]){
        translate([0,0,0])
            p_pvalve(0,0,0,"N",
            valve_r=r1, 
            mem_th=th1,
            fl_extra_sp=fl_extra_sp,
            fl_chm_h=fl_h1, 
            pn_chm_h=pn_h1, 
            inport_center=true,
            pitch=0,
            fl_out_len=len_sp/2,
            pn_out_len=r_max-r1+pn_out_len,
            rot_pn=false,
            flip_fl=true,
            pn_extra_sp=pn_extra_sp,
            fl_out_h=fl_out_h,
            px=px,
            layer=layer,
            chan_h=chan_h, chan_w=chan_w,
            dwn_chan_h=dwn_chan_h, dwn_chan_w=dwn_chan_w,
            offset_layers=0
            );
        // pump
        translate([(r1*2+len_sp)*px,0,0])
            p_pvalve(0,0,0,"N",
            valve_r=r2, 
            mem_th=th2, 
            fl_chm_h=fl_h2, 
            pn_chm_h=pn_h2, 
            inport_center=false,
            pitch=0,
            fl_out_len=len_sp/2,
            pn_out_len=r_max-r2+pn_out_len,
            rot_pn=false,
            fl_extra_sp="fill",
            pn_extra_sp=pn_extra_sp,
            fl_out_h=fl_out_h,
            px=px,
            layer=layer,
            chan_h=chan_h, chan_w=chan_w,
            dwn_chan_h=dwn_chan_h, dwn_chan_w=dwn_chan_w,
            offset_layers=0);
        // check 2
        translate([((r1*2+len_sp)+(r2*2+len_sp))*px,0,0])
            p_pvalve(0,0,0,"N",
            valve_r=r3, 
            mem_th=th3,
            fl_extra_sp=fl_extra_sp,
            fl_chm_h=fl_h3, 
            pn_chm_h=pn_h3, 
            inport_center=true,
            pitch=0,
            fl_out_len=len_sp/2,
            pn_out_len=r_max-r3+pn_out_len,
            rot_pn=false,
            pn_extra_sp=pn_extra_sp,
            fl_out_h=fl_out_h,
            px=px,
            layer=layer,
            chan_h=chan_h, chan_w=chan_w,
            dwn_chan_h=dwn_chan_h, dwn_chan_w=dwn_chan_w,
            offset_layers=0);
        }
        polychannel(
        [[shape, (port_chan_w==0 || port_chan_h==0?dimm:dimmp), pt0_0, [0,[0,0,1]]],
        [shape, dimm, pt0_1, [0,[0,0,1]]],]) ;
        polychannel(
        [[shape, dimm, pt1_0, [0,[0,0,1]]],
        [shape, (port_chan_w==0 || port_chan_h==0?dimm:dimmp), pt1_1, [0,[0,0,1]]],]) ;
    }
    translate([xpos*px, ypos*px, zpos*layer])
    translate([(pitch-chan_w/2)*px, (pitch-chan_w/2)*px, offset_layers*layer])
        obj() ;
}

//p_pump(0,0,0,"N", r2=80);
p_pump (0, 0, 0, "N",
    r1=20, r2=40, r3=20,
    th1=0.6, th2=0.6, th3=0.6,
    fl_h1=3.1, fl_h2=3.1, fl_h3=3.1,
    pn_h1=4, pn_h2=4, pn_h3=4,
    len_sp=15,
    pn_out_len=25, ends_ex_len=10,
    fl_extra_sp=10, pn_extra_sp="fill-edge",
    dwn_chan_h=8, dwn_chan_w=10,
    port_chan_h=10, port_chan_w=14,
    //px=px, layer=layer, 
    lpv=20, chan_h=10, chan_w=14, shape="cube", 
    //pitch=pitch, 
    rot=false, no_obj=false, floor_area=false) ;    
