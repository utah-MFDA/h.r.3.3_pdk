use <routing.scad>

px = 7.6e-3;
layer = 10e-3;

module serpentine_200px_3(xpos, ypos, zpos, orientation){
    
    // Sub-modules
    module obj(){
        translate([18*px+25*px, 18*px, 0]){      
            routing(
                dimm = [
                        [[0, 0], [0, 14*px], [0, 10*layer]],
                        [[0, 14*px], [0, 0], [0, 10*layer]],
                        [[0, 14*px], [0, 14*px], [0, 0]]
                        ],
                p0 = [-25*px, 0, lpv*layer],
                pf = [
                        ["+x",  25*px, 0],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yx", [-200*px, 25*px], [1, 0]],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yx", [-200*px, 25*px], [1, 0]],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yx", [-200*px, 25*px], [1, 0]],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yz", [-200*px, lpv*layer], [1, 2]]
                        ]
            );
            routing(
                dimm = [
                        [[0, 0], [0, 14*px], [0, 10*layer]],
                        [[0, 14*px], [0, 0], [0, 10*layer]],
                        [[0, 14*px], [0, 14*px], [0, 0]]
                        ],
                p0 = [7*25*px, 0, 2*lpv*layer],
                pf = [
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]],
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]],
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]],
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yz", [-200*px, lpv*layer], [1, 2]]
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
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yx", [-200*px, 25*px], [1, 0]],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yx", [-200*px, 25*px], [1, 0]],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yx", [-200*px, 25*px], [1, 0]],
                        ["+yx", [200*px, 25*px], [1, 0]],
                        ["+yz", [-200*px, lpv*layer], [1, 2]]
                        ]
            );
            routing(
                dimm = [
                        [[0, 0], [0, 14*px], [0, 10*layer]],
                        [[0, 14*px], [0, 0], [0, 10*layer]],
                        [[0, 14*px], [0, 14*px], [0, 0]]
                        ],
                p0 = [7*25*px, 0, 4*lpv*layer],
                pf = [
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]],
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]],
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]],
                        ["+yx", [200*px, -25*px], [1, 0]],
                        ["+yx", [-200*px, -25*px], [1, 0]]
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
        translate([-10*25*px - xpos*px, ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "FS"){
        mirror([0, 1, 0])
        translate([xpos*px, -10*25*px - ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "S"){
        mirror([0, 1, 0])
        mirror([1, 0, 0])
        translate([-10*25*px - xpos*px, -10*25*px - ypos*px, zpos*layer])
        obj();
    }
    
}

serpentine_200px_3(0,0,0,"N");