use <routing.scad>
use <./../../scad_use/lef_helper.scad>

px = 7.6e-3;
layer = 10e-3;

module serpentine_50px_0(xpos, ypos, zpos, orientation, ren_lef=false){
    
    // Sub-modules
    module obj(){
        translate([23*px, 23*px, 0])       
        routing(
            dimm = [
                    [[0, 0], [0, 14*px], [0, 10*layer]],
                    [[0, 14*px], [0, 0], [0, 10*layer]]
                    ],
            p0 = [0, 0, 0],
            pf = [
                    ["+yx", [60*px, 30*px], [1, 0]],
                    ["+yx", [-60*px, 30*px+14*px], [1, 0]]
                    ]
        );
        
    }
    
    if (orientation == "N"){
        translate([xpos*px, ypos*px, zpos*layer])
        obj();
    }
        if (orientation == "FN"){
        mirror([1, 0, 0])
        translate([-4*30*px - xpos*px, ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "FS"){
        mirror([0, 1, 0])
        translate([xpos*px, -4*30*px - ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "S"){
        mirror([0, 1, 0])
        mirror([1, 0, 0])
        translate([-4*30*px - xpos*px, -4*30*px - ypos*px, zpos*layer])
        obj();
    }
    
    module lef() {
        
        lef_size(120,120) ;
        
        lef_layer("met1")
        lef_obs("RECT", [30, 30, 90, 90]) ;
        lef_layer("met1")
        lef_port("in_fluid", "INPUT", "RECT", [29.5, 29.5, 30.5, 30.5]);
        lef_layer("met1")
        lef_port("out_fluid", "OUTPUT", "RECT", [89.5, 29.5, 90.5, 30.5]);
    }
    
    if(ren_lef)
        lef() ;
    
}

serpentine_50px_0(0,0,0,"N", true);