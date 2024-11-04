use <../../../scad_include/routing.scad>

px = 7.6e-3;
layer = 10e-3;

module serpentine_300px_0(xpos, ypos, zpos, orientation){
    
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
    
    if (orientation == "N"){
        translate([xpos*px, ypos*px, zpos*layer])
        obj();
    }
        if (orientation == "FN"){
        mirror([1, 0, 0])
        translate([-14*30*px - xpos*px, ypos*px, zpos*layer])
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
        translate([-14*30*px - xpos*px, -14*30*px - ypos*px, zpos*layer])
        obj();
    }
    
}

serpentine_300px_0(0,0,0,"N");

translate([(23-200)*px,23*px,0])cube([200*px,14*px,0.1]);
translate([(23+360+14)*px,23*px,0])cube([100*px,14*px,0.1]);

color("green") cube([423*px, 423*px, 0.0005]);

color("blue") translate([23*px, 23*px, 0]) cube([374*px, 374*px, 0.001]);

//color("red")
//translate([23*px, 23*px, 0]) cube([14*px, 14*px, 0.15]);
//color("red")
//translate([(23+360)*px, 23*px, 0]) cube([14*px, 14*px, 0.15]);

