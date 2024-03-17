use <../../scad_use/routing.scad>

px = 7.6e-3;
layer = 10e-3;
lpv = 20;

module serpentine_300px_2(xpos, ypos, zpos, orientation){
    
    // Sub-modules
    module obj(){
        translate([23*px+30*px, 23*px, 0]){     
            routing(
                dimm = [
                        [[0, 0], [0, 14*px], [0, 10*layer]],
                        [[0, 14*px], [0, 0], [0, 10*layer]],
                        [[0, 14*px], [0, 14*px], [0, 0]]
                        ],
                p0 = [-30*px, 0, lpv*layer],
                pf = [
                        ["+x", 30*px, 0],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yz", [-360*px, lpv*layer], [1, 2]]
                        ]
            );
            routing(
                dimm = [
                        [[0, 0], [0, 14*px], [0, 10*layer]],
                        [[0, 14*px], [0, 0], [0, 10*layer]],
                        [[0, 14*px], [0, 14*px], [0, 0]]
                        ],
                p0 = [11*30*px, 0, 2*lpv*layer],
                pf = [
                        ["+yx", [360*px, -30*px], [1, 0]],
                        ["+yx", [-360*px, -30*px], [1, 0]],
                        ["+yx", [360*px, -30*px], [1, 0]],
                        ["+yx", [-360*px, -30*px], [1, 0]],
                        ["+yx", [360*px, -30*px], [1, 0]],
                        ["+yx", [-360*px, -30*px], [1, 0]],
                        ["+yx", [360*px, -30*px], [1, 0]],
                        ["+yx", [-360*px, -30*px], [1, 0]],
                        ["+yx", [360*px, -30*px], [1, 0]],
                        ["+yx", [-360*px, -30*px], [1, 0]],
                        ["+yx", [360*px, -30*px], [1, 0]],
                        ["+yz", [-360*px, lpv*layer], [1, 2]]
                        ]
            );
            routing(
                dimm = [
                        [[0, 0], [0, 14*px], [0, 10*layer]],
                        [[0, 14*px], [0, 0], [0, 10*layer]],
                        [[0, 14*px], [0, 14*px], [0, 0]]
                        ],
                p0 = [0, 0, 3*lpv*layer],
                pf = [
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px], [1, 0]],
                        ["+yx", [360*px, 30*px], [1, 0]],
                        ["+yx", [-360*px, 30*px+14*px], [1, 0]]
                        ]
            );
        }
        
    }
    
    if (orientation == "N"){
        translate([xpos*px, ypos*px, zpos*layer])
        obj();
    }
        if (orientation == "FN"){
        mirror([1, 0, 0])
        translate([-15*30*px - xpos*px, ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "FS"){
        mirror([0, 1, 0])
        translate([xpos*px, -14*30*px - ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "S"){
        mirror([0, 1, 0])
        mirror([1, 0, 0])
        translate([-15*30*px - xpos*px, -14*30*px - ypos*px, zpos*layer])
        obj();
    }
    
}

serpentine_300px_2(0,0,0,"N");