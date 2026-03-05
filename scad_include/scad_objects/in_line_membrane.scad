use <../polychannel_v2.scad>

module in_line_membrane(xpos, ypos, zpos, orientation,
    mem_r, mem_th, fl_chm_h, pn_chm_h, inport_center=false,
    // length of channels extending outside of valve radius
    fl_out_len  = 30, pn_out_len=30,
    // extra center spacing if needed when inport_center=false
    extra_sp = 0,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, $fn=30,
    no_obj=false, floor_area=false)
{

    module obj()
    {
            chan_dimm = [chan_w, chan_w, chan_h];
        translate([0,0,fl_chm_h/2])
            cylinder(fl_chm_h, r=mem_r, center=true);
        translate([0,0,(fl_chm_h+mem_th+pn_chm_h/2)])
            cylinder(pn_chm_h, r=mem_r, center=true);

        polychannel([
        ["cube", chan_dimm, [-(mem_r+fl_out_len), 0, chan_h/2], [0,[0,0,1]] ],
        ["cube", chan_dimm, [(mem_r+fl_out_len)*2, 0, 0], [0,[0,0,1]], ]]);

        z_chan_offset = (fl_chm_h+pn_chm_h+mem_th-chan_h/2);

        polychannel([
        ["cube", chan_dimm, [0, -(mem_r+fl_out_len), z_chan_offset], [0,[0,0,1]] ],
        ["cube", chan_dimm, [0, (mem_r+fl_out_len)*2, 0], [0,[0,0,1]], ]]);
    }

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    width = (mem_r+fl_out_len)*2 + chan_w;
    height = width;
    orient(height, width, orientation)
    translate([(pitch-chan_w/2), (pitch-chan_w/2), 0])
        translate([width/2, height/2, 0])
            obj();

}
// in_line_membrane(0,0,0,"N", 50, 10, 20, 40);
