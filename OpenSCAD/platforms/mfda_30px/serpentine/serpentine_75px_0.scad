use <routing.scad>

px = 7.6e-3;
layer = 10e-3;

module serpentine_75px_0(xpos, ypos, zpos, orientation){
    
    // Sub-modules
    module obj(){
        translate([18*px, 18*px, 0])       
        routing(
            dimm = [
                    [[0, 0], [0, 14*px], [0, 10*layer]],
                    [[0, 14*px], [0, 0], [0, 10*layer]]
                    ],
            p0 = [0, 0, 0],
            pf = [
                    ["+yx", [75*px, 25*px], [1, 0]],
                    ["+yx", [-75*px, 25*px], [1, 0]],
                    ["+yx", [75*px, 25*px+14*px], [1, 0]]
                    ]
        );
        
    }
    
    if (orientation == "N"){
        translate([xpos*px, ypos*px, zpos*layer])
        obj();
    }
        if (orientation == "FN"){
        mirror([1, 0, 0])
        translate([-5*25*px - xpos*px, ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "FS"){
        mirror([0, 1, 0])
        translate([xpos*px, -5*25*px - ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "S"){
        mirror([0, 1, 0])
        mirror([1, 0, 0])
        translate([-5*25*px - xpos*px, -5*25*px - ypos*px, zpos*layer])
        obj();
    }
    
}

serpentine_75px_0(0,0,0,"N");