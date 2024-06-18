
use <polychannel_v2_testing.scad>
use <p_pvalve.scad>

module p_pump(xpos, ypos, zpos, orientation,
    r1=46, r2=46, r3=46,
    th1 = 10, th2 = 10, th3 = 10,
    fl_h1=10, fl_h2=10, fl_h3=10,
    pn_h1=14, pn_h2=14, pn_h3=14,
    len_sp=30, pn_out_len=20, 
    fl_extra_sp=4, pn_extra_sp="fill",
    fl_out_h=10, pn_out_h=10,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layer=10,
    rot=false, no_obj=false, floor_area=false)
{
    //r1 = 46; r2 = 76; r3 = 46;
    //th1 = 10; th2 = 10; th3 = 10;
    //len_sp = 30;
    
    r_max = max(r1, r2, r3);
    
    
    module obj() {
        // check 1      
        //translate([0,(r_max-r1)*px,0])
        translate([0,0,0])
            p_valve(0,0,0,"N",
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
            offset_layers=0
            );
        // pump
        translate([(r1*2+len_sp)*px,0,0])
            p_valve(0,0,0,"N",
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
            offset_layers=0);
        // check 2
        translate([((r1*2+len_sp)+(r2*2+len_sp))*px,0,0])
            p_valve(0,0,0,"N",
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
            offset_layers=0);
    }
    translate([pitch*px, pitch*px, offset_layer*layer])
        obj() ;
}

p_pump(0,0,0,"N", r2=80);