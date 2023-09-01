//use <routing_181220.scad>
use <routing.scad>

px = 7.6e-3;
layer = 10e-3;

module pump_40px_1(xpos, ypos, zpos, orientation){
    
    // Parameters
    d_DC = 40*px;       // DC diameter
    t_m_DC = layer;     // DC membrane thickness (2 layers of 5 um in JSON FILE)
    h_f_DC = 3*layer;   // height of the fluid chamber (DC) (2.5 layers in JSON FILE)
    h_c_DC = 6*layer;   // height of control chamber
    d_v = 20*px;        // valves diameter
    t_m_v = layer;      // valves membrane thickness (layer of 5 um in JSON FILE)
    h_f_v = 2*layer;    // height of fluid chamber (valves)
    h_c_v = 4*layer;    // height of control chamber (valves) (3.5 layers in JSON FILE)
    dist_v2v = d_DC + d_v + 40*px; // distance between valves centers
    dist_v2chan = 5*layer; // distance between valves bottom and horizontal connection channel
    
    // Channel Dimensions
    xychan0 = 6*px;  
    hchan = 10*layer;
    wchan = 12*px;
    xychan = 12*px;
    Wchan = 14*px;
    Hchan = 25*layer;
    hchan2 = 10*layer;
    ochan = 70*px;


    dim  = [
            [[0, 0], [-Wchan/2, Wchan/2], [0, hchan]],                  // 0
            [[-Wchan/2, Wchan/2], [0, 0], [0, hchan]],                  // 1
            [[-xychan/2, xychan/2], [-xychan/2, xychan/2], [0, 0]],     // 2
            [[-xychan0/2, xychan0/2], [-xychan0/2, xychan0/2], [0, 0]], // 3
            [[-wchan/2, wchan/2], [0, 0], [0, hchan2]],                 // 4
            [[-Wchan/2, Wchan/2], [-Wchan/2, Wchan/2], [0, 0]],         // 5           
           ];
    
    // Submodules
    module valve(d, h_bot, h_top, t_memb){ 
        /*
        d :         diameter of the valve
        h_bot:      bottom chamber height
        h_top:      top chamber height
        t_memb:     membrane thickness
        */    
        
        // Bottom chamber
        color("SteelBlue")
        cylinder(d = d, h = h_bot, $fn = 100);
        
        // Top chamber
        color("CadetBlue")
        translate([0, 0, h_bot+t_memb])
        cylinder(d = d, h = h_top, $fn = 100);    
    }
    
    module obj(){
        //build DC
        valve(d_DC, h_f_DC, h_c_DC, t_m_DC);
        
        for (j = [0:1]){
            mirror([0, j, 0]){
                translate([0, dist_v2v/2, 0])
                
                // inlet and outlet 20 px valves
                valve(d_v, h_f_v, h_c_v, t_m_v);
                
                // fluid connection between valves and DC
                pi_0 = [0 , d_DC/2 - xychan/2, 0];
                pf_0 = [0, dist_v2v/2, 0];
                connect_0 = [
                             ["+z", -(dist_v2chan+hchan), 2],
                             ["yz", pf_0, [4,3]]
                            ];
                routing(pi_0, connect_0, dim);
            }
        
        }
        pi_1_0 = [0, 50*px, 7*layer];
        connect_1_0 = [["+x", -57*px, 0]];
        color("Red")
        routing(pi_1_0, connect_1_0, dim);
        
        pi_1_1 = [0, 50*px, 7*layer];
        connect_1_1 = [["+x", 57*px, 0]];
        color("Blue")
        routing(pi_1_1, connect_1_1, dim);
        
        pi_2 = [-57*px, -50*px, 7*layer];
        connect_2 = [["+x", 114*px, 0]];
        routing(pi_2, connect_2, dim);
        
        pi_3 = [-57*px, 0, 10*layer];
        connect_3 = [["+x", 114*px, 0]];
        routing(pi_3, connect_3, dim);
        
        pi_4 = [0, 59*px, -9*layer];
        connect_4 = [["+yz", [16*px, -4*layer], [1, 5]]];
        routing(pi_4, connect_4, dim);
        
        pi_5 = [0, -59*px, -9*layer];
        connect_5 = [["+yz", [-16*px, -4*layer], [1, 5]]];
        routing(pi_5, connect_5, dim);
    }
    
    if (orientation == "N"){
        rotate(a = 270)
        translate([-75*px - ypos*px, 100*px + xpos*px, 13*layer + zpos*layer])
        obj();
    }
        if (orientation == "FN"){
        mirror()
        rotate(a = 270)
        translate([-75*px - ypos*px, -100*px - xpos*px, 13*layer + zpos*layer])
        obj();
    }
    if (orientation == "FS"){
        mirror([0, 1, 0])
        rotate(a = 270)
        translate([75*px + ypos*px, 100*px + xpos*px, 13*layer + zpos*layer])
        obj();
    }
    if (orientation == "S"){
        mirror()
        mirror([0, 1, 0])
        rotate(a = 270)
        translate([75*px + ypos*px, -100*px - xpos*px, 13*layer + zpos*layer])
        obj();
    }
    
}

pump_40px_1(0,0,0,"N");