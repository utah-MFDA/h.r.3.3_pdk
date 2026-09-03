use <openmfda/components/mixer.scad>

module diffmix_25px_0(xpos, ypos, zpos, orientation,
                px = 7.6e-3,
                layer = 10e-3,
                pitch=30,
                chan_h=10, chan_w=14)
{
    p_mixer(xpos, yppos, zpos, orientation,
            px=px, layer=layer, pitch=pitch, chan_h=chan_h, chan_w=chan_w);
}
