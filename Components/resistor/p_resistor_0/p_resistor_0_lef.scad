use <p_resistor_0.scad>
use <openmfda/components/resistor.scad>
use <openmfda/components/orientation.scad>
use <openmfda/components/lef_helper.scad>

module p_resistor_0_lef(xpos, ypos, zpos, orientation= "N", numblocks = 1, wchan = 14, hchan = 10, w3chan = 6, h3chan = 5, lenchan = 5, edge_offset = 5, eps=1e-5, px=7.6e-3, layer=10e-3, lpv=20, pitch=30, chan_def=[10, 14])
{
    pitch_offset = pitch - chan_def.x;
    dimensions = resistor_dimensions(numblocks = numblocks,
                                     wchan = wchan,
                                     hchan = hchan,
                                     w3chan = w3chan,
                                     h3chan = h3chan,
                                     lenchan = lenchan,
                                     eps = eps);

    lef_w = dimensions.x;
    lef_h = dimensions.y;

    // margin between macro edge and device
    xoff = edge_offset + pitch_offset/2;
    yoff = xoff;

    global_offset = [xoff, yoff, xoff, yoff];
    module inner() {
        offset = [chan_def.x/2, abs(lenchan-chan_def.x)];

        // macro size
        lef_size(lef_w + 2*xoff,
                 lef_h + 2*yoff,
                 px=px, layer=layer, lpv=lpv);
        inlet_rect = [ 0.0, 0.0, chan_def.x, chan_def.x ] + global_offset;
        echo(inlet_rect);
        // inlet
        lef_layer("met1")
        lef_port("in_fluid",
                 "INPUT",
                 "RECT",
                 inlet_rect - [offset.x, offset.y, offset.x, offset.y],
                 px=px, layer=layer, lpv=lpv, chan_def=chan_def);

        chan_offset = lef_h - lenchan;
        outlet_offset = [wchan, chan_offset, wchan, chan_offset];
        // outlet
        lef_layer("met1")
        lef_port("out_fluid",
                 "OUTPUT",
                 "RECT",
                 inlet_rect + outlet_offset - [offset.x, 0, offset.x, 0],
                 px=px, layer=layer, lpv=lpv, chan_def=chan_def);

        // obstruction
        lef_layer("met1")
        lef_obs("RECT",
                [0, 0, lef_w, lef_h] + global_offset,
                px=px, layer=layer, lpv=lpv);
    }

    translate([xpos*px, ypos*px, zpos*layer])
    orient([lef_w+xoff, lef_h+yoff]*px, orientation)
    inner();
}

module p_resistor_0_demo(xpos, ypos, zpos, orientation="N",
    numblocks = 1, wchan = 14, hchan = 10, w3chan = 6, h3chan = 5, lenchan = 5,
        eps = 1e-2, edge_offset=5,
        px=7.6e-3, layer=10e-3, lpv=20, pitch=30, chan_def=[14, 14])
{
    p_resistor_0(xpos, ypos, zpos, orientation,
                 numblocks = numblocks,
                 wchan = wchan,
                 hchan = hchan,
                 w3chan = w3chan,
                 h3chan = h3chan,
                 lenchan = lenchan,
                 eps = eps, px=px, layer=layer, lpv=lpv, chan_def=chan_def);
    p_resistor_0_lef(xpos, ypos, zpos, orientation,
                 numblocks = numblocks,
                 wchan = wchan,
                 hchan = hchan,
                 w3chan = w3chan,
                 h3chan = h3chan,
                 lenchan = lenchan,
                 eps = eps, px=px, layer=layer, lpv=lpv, chan_def=chan_def);
}

if ($preview) {
    p_resistor_0_demo(0, 0, 0, "N");
}
