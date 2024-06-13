
use <polychannel_v2_testing.scad>

module mixer_test (xpos, ypos, zpos, orientation, 
    sw_scale=1, stl_dir="./",
    pitch=30, px=7.6e-3, layer=10e-3, layers_offset=20)
{
    module obj()
    {
        cad_file = "mixer_sw_test.STL";
        import(str(stl_dir, cad_file));
        
    }
    
    translate(sw_scale*[pitch*px, pitch*px, layers_offset*layer])
        scale([sw_scale, sw_scale, sw_scale])
            obj();
        
}

mixer_test(0,0,0,"N",sw_scale=1/7.6e-3) ;
