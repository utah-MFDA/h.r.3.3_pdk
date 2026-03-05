use <../../../scad_include/routing.scad>

module valve_20px4way_0(xpos, ypos, zpos, orient, px=7.6e-3, layer=10e-3){

    // Parameteres
    h_fluid = 2*layer;
    t_memb = layer;
    h_air = 4*layer;
    h_total = h_fluid + t_memb + h_air; // 7*layer
    d_valve = 20*px;

    // Valve connection channels
    xychan0 = 6*px;
    xychan = 8*px;
    hchan = 5*layer;
    hchan_px = 8*px;
    wchan = 8*px;

    dimm        =   [
                        [[0, 0], [-wchan/2, wchan/2], [0, hchan]], // 0
                        [[-wchan/2, wchan/2], [0, 0], [0, hchan]], // 1
                        [[-xychan/2, xychan/2], [-xychan/2, xychan/2], [0, 0]], // 2
                        [[-xychan0/2, xychan0/2], [-xychan0/2, xychan0/2], [0, 0]], // 3
                        [[-xychan/2, xychan/2], [0, hchan_px], [0, 0]], // 4
                    ];

    overlap_v_xy  = 2*px;

    module obj(){
        // Fluid compartment
        color("CadetBlue")
        cylinder(d = d_valve, h = h_fluid);

        // Air compartment
        color("SteelBlue")
        translate([0,0,h_fluid + t_memb])
        cylinder(d = d_valve, h = h_air);

        // Fluid in channel connection
        pt_fluid_in         = [0, -d_valve/2 + overlap_v_xy, 1*layer - hchan];
        pt_fluid_in_next    = [
                                ["+y", -21*px, 1],
                              ];
        color("Blue")
        routing(pt_fluid_in,pt_fluid_in_next, dimm);

        // Fluid out channel connection
        pt_fluid_out        = [0, d_valve/2 - overlap_v_xy, 1*layer - hchan];
        pt_fluid_out_next   = [
                                ["+y", 21*px, 1],
                              ];
        color("Red")
        routing(pt_fluid_out,pt_fluid_out_next, dimm);

        rotate(90){
            // Fluid in channel connection
            pt_fluid_in         =   [0, -d_valve/2 + overlap_v_xy, 1*layer - hchan];
            pt_fluid_in_next    =   [
                                        ["+y", -21*px, 1],
                                    ];

            routing(pt_fluid_in,pt_fluid_in_next, dimm);

            // Fluid out channel connection
            pt_fluid_out        =   [0, d_valve/2 - overlap_v_xy, 1*layer - hchan];
            pt_fluid_out_next   =   [
                                        ["+y", 21*px, 1],
                                    ];

            routing(pt_fluid_out,pt_fluid_out_next, dimm);
        }

        // Air control channel connection
        pt_air_control      = [-d_valve/2 - xychan/2 + 6*px, 0, h_total];
        pt_air_control_next = [
                                ["+zx", [9*layer, -21*px]],
                              ];

        color("Red")
        routing(pt_air_control,pt_air_control_next, dimm);

        // Air flushing channel connection
        pt_air_flush        = [d_valve/2 + xychan/2 - 6*px, 0, h_total];
        pt_air_flush_next   = [
                                ["+zx", [9*layer, 21*px]],
                              ];
        color("Blue")
        routing(pt_air_flush,pt_air_flush_next, dimm);
    }
    translate([xpos*px, ypos*px, 4*layer+zpos*layer])
    orientation([25*px*2, 25*px*2, orient])
    obj();
}

 valve_20px4way_0(0,0,0,"N");
