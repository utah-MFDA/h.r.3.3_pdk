use <../polychannel_v2.scad>

module multi_in_chamber(xpos, ypos, zpos, orientation,
    num_inputs, input_sp, chm_h, chm_l,
    chan_out_w, chan_out_h, has_nozzle=false, nozzle_l,
    px=7.6e-3, layer=10e-3,
    chan_h=10, chan_w=14, shape="cube", pitch=30, rot=false,
    no_obj=false, floor_area=false
)
{
    chm_w = (input_sp*(num_inputs-1)+chan_w);
    chm_l_s1 = (has_nozzle?chm_l - nozzle_l:chm_l);
    chm_l_s2 = (has_nozzle?nozzle_l:0);
    chan_in_l  = 30;
    chan_out_l = 30;


    module obj(){
        translate([0,(chm_l-chm_l_s1)/2,0])
        cube([chm_w,
            chm_l_s1,
            chm_h], center=true) ;
        translate([chm_w/2-chan_w/2, chm_l/2, 0])
            for(i = [0:num_inputs-1])
                translate([-input_sp*i, chan_in_l/2, 0])
                    cube([chan_w, chan_in_l, chan_h], center=true);
        if(has_nozzle)
        {
            polychannel(
                [["cube", [chm_w, 1/10, chm_h], [0,-(chm_l/2-chm_l_s2),0], [0,[0,0,1]]],
                ["cube", [chan_w, 1/10, chan_h],  [0,-chm_l_s2,0], [0,[0,0,1]]]]);
        }
        translate([0,-chm_l/2-chan_out_l/2, 0])
            cube([chan_w, chan_out_l, chan_h], center=true);
    }

    widht = chm_w;
    height = 2*chan_out_l+chm_l;
    depth = chm_h;

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    translate([(pitch-chan_w/2),(pitch-chan_w/2),0])
    orient(width, height, orientation)
    translate([width/2, height/2, depth/2])
    obj();

    if (floor_area)
        color("blue")
        translate([0,0,-1/10])
            cube([(pitch*2+chm_l)+chan_in_l+chan_out_l,
                    (pitch*2)+chm_w,
                    (l/10)]);
}

//multi_in_chamber(0,0,0,"N",3,50,10,20);
multi_in_chamber(0,0,0,"FS",5,50,10,40, has_nozzle=true, nozzle_l=10,rot=true, floor_area=false);
