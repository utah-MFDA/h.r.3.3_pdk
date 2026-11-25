$fa = 1;
$fs = 0.04;

layer = 0.010;
px = 0.0076;

channel_width_thick = 20 * px;
channel_height_thick = 15 * layer;
channel_width_default = 6*px;
channel_height_default = 5*layer;

module xchan(l, w = channel_width_default, h = channel_height_default) {
    color("lightblue")
    if (l < 0)
        mirror([1, 0, 0])
    translate([0, -floor(w / px / 2) * px, 0]) cube([-l, w, h]);
    else
    translate([0, -floor(w / px / 2) * px, 0]) cube([l, w, h]);
}

module ychan(l, w = channel_width_default, h = channel_height_default) {
    color("lightblue")
    if (l < 0)
        mirror([0, -1, 0])
    translate([-floor(w / px / 2) * px, 0, 0]) cube([w, -l, h]);
    else
    translate([-floor(w / px / 2) * px, 0, 0]) cube([w, l, h]);
}

module zchan(l, xy = channel_width_default) {
    color("lightblue")
    translate([-xy / 2, -xy / 2, 0]) {
        if (l < 0)
            mirror([0, 0, 1])
        cube([xy, xy, -l]);
        else
        cube([xy, xy, l]);
    }
}

module 1way_valve_membrane(
    input_channel_length=15*px,
    top_chamber_h=8*layer,
    bottom_chamber_h= 4*layer,
    membrane_diameter=50*px,
    membrane_thickness=layer,
    u_channel_length=10*px,
    u_channel_height=15*layer,
    angle_offset_u_channel=0,
    angle_offset_input_channel=0
    ){
    // Top chamber
    cylinder(h=top_chamber_h, d=membrane_diameter);

    // Bottom chamber
    translate([0, 0, -(membrane_thickness+bottom_chamber_h)])
        cylinder(h=bottom_chamber_h, d=membrane_diameter);

    // Input channel
    color("red")
    rotate([0, 0, angle_offset_input_channel])
    translate([-(input_channel_length + membrane_diameter/2) + px, 0, 0])
        xchan(input_channel_length);

    // U channel
    rotate([0, 0, angle_offset_u_channel])
    translate([membrane_diameter/2 - px, 0, channel_height_default/2]){
        xchan(u_channel_length, h=channel_height_default/2);
        translate([u_channel_length, 0, channel_height_default/2]){
            zchan(-u_channel_height);
            translate([0, 0, -u_channel_height]){
                xchan(-u_channel_length -px, h=channel_height_default/2);
                translate([-u_channel_length - channel_height_default/2, 0, 0]){
                    zchan(u_channel_height-(bottom_chamber_h + membrane_thickness + channel_height_default/2));
                }
            }
        }
    }

    // Output channel
    color("green")
    translate([0, 0, -(membrane_thickness + bottom_chamber_h)]){
        zchan(-5*layer);
    }
}

module 1way_valve_ribbon(
    membrane_width=18*px,
    membrane_thickness=layer,
    membrane_top_gap=4*layer,
    membrane_bottom_gap=2*layer,
    membrane_side_gap=6*px,
    main_chamber_x=48*px,
    inlet_x=6*px,
    inlet_z=3*layer
    ){
    main_chamber_y = membrane_width+2*membrane_side_gap;
    main_chamber_z = membrane_top_gap + membrane_thickness + membrane_bottom_gap;
    translate([-main_chamber_x/2, -main_chamber_y/2, 0]){
        difference(){
            // Main chamber
            cube([main_chamber_x, main_chamber_y, main_chamber_z]);

            // Ribbon membrane
            translate([0, membrane_side_gap, membrane_bottom_gap])
                cube([main_chamber_x, membrane_width, membrane_thickness]);
        }
        // Top thick outlet
        translate([0.5*(main_chamber_x-inlet_x), 0, main_chamber_z]){
            cube([inlet_x, main_chamber_y, inlet_z]);
            color("red")
            translate([inlet_x/2, main_chamber_y/2, inlet_z])
                zchan(4*layer);
        }
        // Bottom narrow inlet
        color("green")
        translate([main_chamber_x/2, main_chamber_y/2, 0])
            zchan(-4*layer);
    }
}

module 1way_valve_squeeze(
    length=24*px,
    height=14*layer
    ){
    ch_w = 8*px;
    ch_wtwo = 10*px;

    wall_w = 8*px;
    mem_h = layer;
    squeeze = 2*layer;
    squeezer = (height-2*mem_h-squeeze)/2;

    translate([-(length+ch_w+wall_w)/2, -(3*ch_w+2*wall_w)/2 , 0]){
        cube([length+ch_w+wall_w,ch_w,height]);
        translate([0,2*ch_w+2*wall_w])
        cube([length+ch_w+wall_w,ch_w,height]);
        translate([0,ch_w+wall_w])
        cube([ch_w+wall_w/2,ch_w,height]);
        translate([0,ch_w+wall_w,squeezer+mem_h])
        cube([length+ch_w+2.5*wall_w,ch_w,squeeze]);
        color("green")
        translate([length+ch_w+1.5*wall_w,ch_w+wall_w])
        cube([ch_w+wall_w/2,ch_w,height]);
        
        
        cube([ch_w,3*ch_w+2*wall_w,height]);
        translate([ch_w+wall_w,0,0])
        cube([length,3*ch_w+2*wall_w,squeezer]);
        translate([ch_w+wall_w,0,squeezer+squeeze+2*mem_h])
        cube([length,3*ch_w+2*wall_w,squeezer]);

        // Outlet channel
        color("red")
        translate([0, (3*ch_w+2*wall_w)/2, height/2 - channel_height_default/2])
            xchan(-10*px);
    }
}

1way_valve_membrane();

translate([1, 0, 0])
1way_valve_ribbon();

translate([2, 0, 0])
1way_valve_squeeze();