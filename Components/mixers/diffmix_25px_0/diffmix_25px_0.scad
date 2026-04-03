use <openmfda/polychannel/routing.scad>
use <openmfda/components/orientation.scad>


module diffmix_25px_0(xpos, ypos, zpos, orientation,
px = 7.6e-3,
layer = 10e-3,
chan_h=10, chan_w=14){
      
    // Channel Dimensions
    hchan = chan_h*layer;
    Wchan = chan_w*px;

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
    
    translate([xpos*px, ypos*px, zpos*layer])
    translate([30*px, 30*px, 0])
    orient([30, 30]*px/2, orientation)
    obj();
    
}

diffmix_25px_0(0,0,0,"N");
