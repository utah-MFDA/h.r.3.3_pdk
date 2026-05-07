use <../../../scad_include/routing.scad>
use <../../../scad_include/lef_helper.scad>

px = 7.6e-3;
layer = 10e-3;

module diffmix_25px_0(xpos, ypos, zpos, orientation){
      
    // Channel Dimensions
    hchan = 10*layer;
    Wchan = 14*px;

    dim  = [
            [[0,0],[-Wchan/2,Wchan/2],[0,hchan]], // 0
            [[-Wchan/2,Wchan/2],[0,0],[0,hchan]], // 1
                    
           ];
    
    module obj(){
        pi_0 = [-7*px, 30*px, 0];
        pf_0 = [Wchan+16*px, 0, 0];
        connect_0 = [
                     ["+x", pf_0, 0]
                    ];
        routing(pi_0, connect_0, dim);
        
        pi_1 = [-7*px, 0*px, 0];
        pf_1 = [Wchan, 0, 0];
        connect_1 = [
                     ["+x", pf_1, 0]
                    ];
        routing(pi_1, connect_1, dim);

        pi_2 = [23*px, 30*px, 0];
        pf_2 = [Wchan, 0, 0];
        connect_2 = [
                     ["+x", pf_2, 0]
                    ];
        routing(pi_2, connect_2, dim);
  
        pi_3 = [0, 0, 0];
        pf_3 = [42.4*px, 0, 0];
        connect_3 = [
                     ["+x", pf_3, 0]
                    ];
        rotate(45)
        routing(pi_3, connect_3, dim);  
        
    }

    if (orientation == "N"){
        translate([30*px + xpos*px, 30*px + ypos*px, zpos*layer])
        obj();
    }
    if (orientation == "FN"){
        translate([15*px + xpos*px, 30*px + ypos*px, zpos*layer])
        mirror([1, 0, 0])
        translate([-45*px, 0*px, 0])
        obj([1, 0, 0]);
    }
    if (orientation == "S"){
        translate([15*px + xpos*px, 15*px + ypos*px, zpos*layer])
        mirror([1, 0, 0])
        mirror([0, 1, 0])
        translate([-45*px, -45*px, 0])    
        obj();
    }
    if (orientation == "FS"){
        translate([30*px + xpos*px, 15*px + ypos*px, zpos*layer])
        mirror([0, 1, 0])
        translate([0*px, -45*px, 0])
        obj();
    }
    
}

x = 1 ;
y = 0 ;
z = 0 ;

diffmix_25px_0(x,y,0,"FS");
diffmix_25px_0(x,y,0,"FN");
diffmix_25px_0(x,y,0,"S");
diffmix_25px_0(x,y,0,"N");

lef_size(90, 90) ;
