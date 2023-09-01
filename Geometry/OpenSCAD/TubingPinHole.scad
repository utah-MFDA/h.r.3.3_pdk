include<routing_181112.scad>


layer       = 0.01;
px          = 0.0076;


max_y_dimm  = 1600*px;
max_x_dimm  = 2560*px;
chip_y_dimm = max_y_dimm;
chip_x_dimm = max_x_dimm;
glass2feat  = 70*layer;
pin2surf    = 50*layer;


//chip_z_dimm = 230*layer;


d_valve     = 20*px;
h_fluid     = 2*layer;
t_memb      = layer;
h_air       = 4*layer;
pin2valv_y  = 50*px;
pin2valv_z  = 8*layer;
pin2pin     = 250*px;
l_pin       = 300*px;
d_pin       = 104*layer;
overlap_v_xy  = 2*px;

valv2valv   = 750*px;

valv2glass  = pin2valv_z + floor(d_pin/2/layer)*layer + glass2feat;

chip_z_dimm = valv2glass + floor(d_pin/2/layer)*layer + pin2surf;

// Valve connection channels
xychan0     = 6*px;
xychan      = 8*px;
hchan       = 5*layer;
wchan       = 8*px;

// Pin connection channels
XYchan      = 14*px;
Hchan       = 8*layer;
Wchan       = 14*px;

dimm        =   [  
                    [[0,0],[-wchan/2,wchan/2],[0, hchan]], // 0
                    [[-wchan/2,wchan/2],[0,0],[0, hchan]], // 1
                    [[-xychan/2,xychan/2],[-xychan/2,xychan/2],[0,0]], // 2
                    [[-xychan0/2,xychan0/2],[-xychan0/2,xychan0/2],[0,0]], // 3  
                    [[0,0],[-Wchan/2,Wchan/2],[0, Hchan]], // 4
                    [[-Wchan/2,Wchan/2],[0,0],[0, Hchan]], // 5
                    [[-XYchan/2,XYchan/2],[-XYchan/2,XYchan/2],[0,0]], // 6
                ];

//translate([pin2pin, -(l_pin + pin2valv_y), -pin2valv_z])
        rotate([-90,0,0])
        cylinder(d = d_pin, h = l_pin, $fn = 100);
        
    pin_hole_chan_start = [0, l_pin, 0];
    pin_hole_chan_end = [["+y", 50*px]
    ];
    
    routing(pin_hole_chan_start, pin_hole_chan_end, dimm);