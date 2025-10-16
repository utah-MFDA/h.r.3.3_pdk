use <../polychannel_v2.scad>

$fa = 1;
$fs = 0.04;
layer = 0.010;
px = 0.0076;
edge_rounding = 0.5;
cube_x = 500*px;
cube_y = 500*px;
cube_z = 380*layer;

module p_reservoir(xpos, ypos, zpos, orientation,
    p1_dir="z+", p2_dir="z+", port_len1=50, port_len2=-1, p1_offset=[0,0], p2_offset=[0,0], 
    size=[300, 300, 250], edge_rounding=0.5, 
    center=true, clr="gray",
    px=0.0076, layer=0.010, chan_w=14, chan_h=10, rot=false, pitch=30, layer_offset=10, $fs=0.04, $fa=1)
{
    n_size = [size[0]*px, size[1]*px, size[2]*layer];
    
    translate([xpos*px, ypos*px, zpos*layer])
    translate([(pitch-chan_w/2)*px, (pitch-chan_w/2)*px, layer_offset*layer])
    translate(n_size/2)
    rotate([0,0,(rot?90:0)])
    mirror([(orientation=="FN"||orientation=="FS"?1:0),0,0])
    mirror([0,(orientation=="S"||orientation=="FS"?1:0), 0])
        reservoir(size=size, edge_rounding=edge_rounding,
    p1_dir=p1_dir, p2_dir=p2_dir, port_len1=port_len1, port_len2=port_len2, p1_offset=p1_offset, p2_offset=p2_offset,
    chan_w=chan_w, chan_h=chan_h,
    center=center, clr=clr, px=px, layer=layer, $fs=$fs, $fa=$fa) ; 
}

module reservoir(size=[300, 300, 250], edge_rounding=0.5, center=true, clr="gray",
    p1_dir="z+", p2_dir="z+", port_len1=50, port_len2=-1,
    p1_offset=[0,0], p2_offset=[0,0],
    chan_w=14, chan_h=10, 
    px=0.0076, layer=0.010, $fs=0.04, $fa=1) {
	module obj() {
        n_size = [size[0]*px, size[1]*px, size[2]*layer];
        translate = (center == false) ?
		[edge_rounding, edge_rounding, edge_rounding] :
		[
			edge_rounding - (n_size[0] / 2),
			edge_rounding - (n_size[1] / 2),
			edge_rounding - (n_size[2] / 2)
	];

    color(clr){
        translate(v = translate)
        minkowski() {
            cube(size = [
                n_size[0] - (edge_rounding * 2),
                n_size[1] - (edge_rounding * 2),
                n_size[2] - (edge_rounding * 2)
            ]);
            sphere(r = edge_rounding);
        }
    }
    }
    module port (side, port_len=50, from_center=true, x_off=0, y_off=0)
    {
        i_orient = 
            (side[0]=="x"?
                (side[1]=="+"?
                    [[1,0,0]*px,[0,-1,0]*px,[0,0,1]*layer]
                    :[[-1,0,0]*px,[0,-1,0]*px,[0,0,1]*layer]
                ):
            (side[0]=="y"?
                (side[1]=="+"?
                    [[0,1,0]*px, [1,0,0]*px, [0,0,1]*layer]
                    :[[0,-1,0]*px, [1,0,0]*px, [0,0,1]*layer]
                ):
            (side[0]=="z"?
                (side[1]=="+"?
                    [[0,0,1]*layer, [1,0,0]*px, [0,1,0]*px]
                    :[[0,0,-1]*layer, [1,0,0]*px, [0,1,0]*px]
                )
                :"error")));
        
        
        i_pt_s = 
            (side[0]=="x"?
                size[0]/4
                :
            (side[0]=="y"?
                size[1]/4
                :
            (side[0]=="z"?
                size[2]/4
                :"error")));
                
        pt0 = i_orient[0]*i_pt_s+i_orient[1]*x_off+i_orient[2]*y_off;
        pt1 = i_orient[0]*(port_len)+i_orient[0]*i_pt_s;
        polychannel([
            ["cube",[chan_w*px, chan_w*px, chan_h*layer], pt0, [0,[1,0,0]]],
            ["cube",[chan_w*px, chan_w*px, chan_h*layer], pt1, [0,[1,0,0]]]
            ], clr="crimson");

    }
        %obj() ;
        port(p1_dir, port_len=port_len1, x_off=p1_offset[0], y_off=p1_offset[1]) ;
        if(port_len2 >= 0)
            port(p2_dir, port_len=port_len2, x_off=p2_offset[0],  y_off=p2_offset[1]) ;
        else
            port(p2_dir, port_len=port_len1, x_off=p2_offset[0],  y_off=p2_offset[1]) ;
            
        //port(p1_dir, x_off=-size[0]/4/px, y_off=0) ;
        //port(p2_dir, x_off=size[0]/4/px, y_off=0) ;
}

p_reservoir(0,0,0,"N",size=[300, 300, 280], edge_rounding=edge_rounding, p1_dir="z+", p2_dir="x+", port_len1=50, p1_offset=[-140,0], p2_offset=[0,-270/2], clr="lightblue");
