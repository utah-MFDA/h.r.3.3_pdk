use <openmfda/components/reservoir.scad>

module bidirectional_res_1000ul(xpos, ypos, zpos, orientation)
{

    res_h = 176 ;

    p_reservoir(xpos, ypos, zpos, orientation,
        ports = [["z-", 0, [0,(100-14)/2]],
                 ["z-", 0, [0,-(100-14)/2]]],
        size=[100, 100, res_h ], edge_rounding=0.2,
        center=true, clr="gray",
        px=0.0076, layer=0.010, pitch=30, $fs=0.04, $fa=1) ;
}

bidirectional_res_1000ul(0,0,0,"N") ;
