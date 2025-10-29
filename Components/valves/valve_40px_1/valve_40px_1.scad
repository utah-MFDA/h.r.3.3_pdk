
use <../../../scad_include/scad_objects/p_valve.scad>
use <../../../scad_include/lef_helper.scad>

module valve_40px_1(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30, ren_lef=false)
{
    translate([1*px,0,1*lpv*layer])
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=20, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false,
        // length of channels extending outside of valve radius
        out_len=43, fl_extra_sp = 2, fl_chan_down_layers=10, 
        pn_extra_sp="fill", pn_chan_up_layers=12, rot_pn=false,
        // extra center spacing if needed when inport_center=false
        extra_sp = 0, 
        px=px, layer=layer, lpv=lpv, chan_h=6, chan_w=8, shape="cube", pitch=pitch, 
        offset_layers=5, no_obj=false, floor_area=false) ;
    
    module lef()
    {
        color("blue")
        lef_size(180, 180);
        
        lef_layer("met2")
        lef_port("in_fluid", "INPUT", "RECT",  [23, 83, 37, 97]) ;
        lef_layer("met2")
        lef_port("out_fluid", "OUTPUT", "RECT", [143, 83, 157, 97]) ;
        
        lef_layer("met4")
        lef_port("in_air", "INPUT", "RECT", [83, 23, 97, 37]) ;
        lef_layer("met4")
        lef_port("out_air", "OUTPUT", "RECT", [83, 143, 97, 157]) ;
        
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 150, 150]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 150, 150]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 150, 150]) ;
    }
    if (ren_lef)
        lef() ;
    
}

valve_40px_1(0,0,0,"N", ren_lef=true) ;//, px=1, pitch=0) ;

px = 7.6e-3;

echo("SIZE") ;
echo(180*7.6e-3) ;
echo("PORT1", 30*px,  90*px) ;
echo("PORT2", 150*px, 90*px) ;
echo("PORT3", 90*px,  30*px) ;
echo("PORT4", 90*px, 150*px) ;
