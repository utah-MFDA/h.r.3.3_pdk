
use <../polychannel_v2.scad>

module p_tall_mixer(xpos, ypos, zpos, orientation,
    mix_l, mix_w, mix_h,
    chan_io_len=20, chan_tran_len=10, mix_z_offset=0,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, 
    no_obj=false, floor_area=false)
{
    chan_io_dimm = [px, chan_w*px, chan_h*layer];
    chan_mix_dimm= [px, mix_w*px, mix_h*layer] ;
    //chan_io_len  = 20 ;
    //chan_tran_len = 5;
    
    init_l_offset = (chan_io_len+chan_tran_len+mix_l/2);
    
    module obj() {
        polychannel([
        ["cube", chan_io_dimm, [-init_l_offset*px, 0, 0], [0,[0,0,1]]],
        ["cube", chan_io_dimm, [chan_io_len*px, 0, 0], [0,[0,0,1]]],
        ["cube", chan_mix_dimm,[chan_tran_len*px, 0, mix_z_offset*layer], [0,[0,0,1]]],
        ["cube", chan_mix_dimm,[mix_l*px, 0, 0], [0,[0,0,1]]],
        ["cube", chan_io_dimm, [chan_tran_len*px, 0, -mix_z_offset*layer], [0,[0,0,1]]],
        ["cube", chan_io_dimm, [chan_io_len*px, 0, 0], [0,[0,0,1]]],
        ]) ;
    }
    
    translate([(pitch-chan_w/2)*px, (pitch-chan_w/2)*px, 0])
        translate([init_l_offset*px, chan_w/2*px, mix_h/2*layer])
            obj();
    
}

p_tall_mixer(0,0,0,"N", 100, 6, 50, mix_z_offset=10);
