
use <openmfda/polychannel/polychannel.scad>
use <openmfda/components/orientation.scad>

module mixer_test (xpos, ypos, zpos, orientation, 
    sw_scale=1, stl_dir="./",
    pitch=30, px=7.6e-3, layer=10e-3, layers_offset=20)
{
    module obj()
    {
        cad_file = "mixer_sw_test.STL";
        import(str(stl_dir, cad_file));
        
    }
    translate([xpos*px, ypos*px, zpos*layer])
    translate(sw_scale*[(pitch-7)*px, (pitch-7)*px, layers_offset*layer])
    orient([160,225]*px, orientation)
        scale([sw_scale, sw_scale, sw_scale])
            obj();
        
}

mixer_test(0,0,0,"N",sw_scale=1/7.6e-3) ;
