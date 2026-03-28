use <../polychannel_v2.scad>
use <../orientation.scad>

/**
 * xpos, ypos: position in pixels.
 * zpos: position in layers
 * orientation: string enum, see orient module.
 * L1, L2: scalar
 * turns: scalar
 * chan_layers: scalar
 * gap: space between stacks in layers
 * px: millimeters per pixel
 * layer: millimeters per layer
 * chan_h: channel height in layers.
 * chan_w: channel width in pixels.
 * shape: channel shape, see polychannel.
 * pitch: distance between channels, in pixels
*/
module p_serpentine(
    xpos, ypos, zpos, orientation,
    L1, L2, turns, chan_layers=2, gap=20,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, $fn=30)
{
    module obj(){
        i_len = [[[[[0,0,0], [L1,0,0]]]]];
        pts =
                [for(j=[1:chan_layers])
                    concat((j%2?1:(turns%2?1:-1))*i_len[0],
                    [[for (i=[1:(j%2?turns:(turns))]) [
                    [0,(j%2?L2:-L2),0],
                    [(j%2?1:(turns%2?1:-1))*(i%2?-L1:L1),0,0]
                    ]],
                [[
                    [0,0,(j==chan_layers?0:gap)]]]]) ];
        pts = alt ? alt_pts : norm_pts;

        pts_c = [for(i=[0:len(pts)-1])
                    for(j=[0:len(pts[i])-1])
                        for(k=[0:len(pts[i][j])-1])
                            for(l=[0:len(pts[i][j][k])-1]) pts[i][j][k][l]];

        poly_pts = [for(i=[0:len(pts_c)-1])
            [shape, [chan_w, chan_w, chan_h], pts_c[i], [0,[0,0,1]]] ];

        translate([-L1/2, -L2*(turns)/2, 0])
            polychannel(poly_pts) ;
    }

    x_off = L1/2+(chan_w/2);
    y_off = L2*(turns)/2 + chan_h/2;
    pitch_offset = pitch - chan_w;

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    translate([pitch_offset/2, pitch_offset/2, 0])
    orient([2*x_off, 2*y_off], orientation)
    translate([x_off, y_off, chan_h/2])
        obj();
}

/**
 * xpos, ypos: position in pixels.
 * zpos: position in layers
 * orientation: string enum, see orient module.
 * L1, L2: scalar
 * turns: scalar
 * chan_layers: scalar
 * gap: space between stacks in layers
 * alt: alternating orientation, boolean
 * px: millimeters per pixel
 * layer: millimeters per layer
 * chan_h: channel height in layers.
 * chan_w: channel width in pixels.
 * shape: channel shape, see polychannel.
 * pitch: distance between channels, in pixels
*/
module p_serpentine_alternating(
    xpos, ypos, zpos, orientation,
    L1, L2, turns, chan_layers=2, gap=20
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, $fn=30)
{
    module obj(){
        i_len = [[[[[0,0,0], [L1,0,0]]]]];
        pts = concat(i_len,[for(j=[1:chan_layers])
                [[for (i=[1:(j%2?turns:turns-1)]) [
                    [0,(j%2?L2:-L2),0],
                    [(j%2?-1:(turns%2?1:-1))*(i%2?L1:-L1),0,0]
                    ]],
                [[
                    [0,(j%2?0:-L2),0],
                    [(j%2?0:L1),0,0],
                    [0,0,(j==chan_layers?0:gap)]]]] ]);

        pts_c = [for(i=[0:len(pts)-1])
                    for(j=[0:len(pts[i])-1])
                        for(k=[0:len(pts[i][j])-1])
                            for(l=[0:len(pts[i][j][k])-1]) pts[i][j][k][l]];

        poly_pts = [for(i=[0:len(pts_c)-1])
            [shape, [chan_w, chan_w, chan_h], pts_c[i], [0,[0,0,1]]] ];

        translate([-L1/2, -L2*(turns)/2, 0])
            polychannel(poly_pts) ;
    }

    x_off = L1/2+(chan_w/2);
    y_off = L2*(turns)/2 + chan_h/2;
    pitch_offset = pitch - chan_w;

    scale([px, px, layer])
    translate([xpos, ypos, zpos])
    translate([pitch_offset/2, pitch_offset/2, 0])
    orient([2*x_off, 2*y_off], orientation)
    translate([x_off, y_off, chan_h/2])
        obj();
}

p_serpentine(0, 0, 0, "N");
