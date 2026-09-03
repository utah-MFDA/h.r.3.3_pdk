use <openmfda/components/resistor.scad>

module p_resistor_0(xpos, ypos, zpos, orientation="N",
    numblocks = 1, wchan = 14, hchan = 10, w3chan = 6, h3chan = 5, lenchan = 5,
        eps = 1e-2, edge_offset=5,
        px=7.6e-3, layer=10e-3, lpv=20, pitch=30, chan_def=[10, 14])
{
    p_resistor(xpos, ypos, zpos, orientation,
                 numblocks = numblocks,
                 wchan = wchan,
                 hchan = hchan,
                 w3chan = w3chan,
                 h3chan = h3chan,
                 lenchan = lenchan,
                 eps = eps, px=px, layer=layer, lpv=lpv, chan_def=chan_def);
}
