use <openmfda/objects/p_valve.scad>


module valve_40px_1(xpos, ypos, zpos, orientation,
    px=7.6e-3, layer=10e-3, lpv=20, pitch=30)
{
    translate([6*px,6*px,1*lpv*layer])
    p_valve(xpos, ypos, zpos, orientation,
        valve_r=18, mem_th=1, fl_chm_h=3, pn_chm_h=6, inport_center=false,
        // length of channels extending outside of valve radius
        out_len=10, 
        fl_extra_sp = 2,
        fl_chan_down_layers=10, 
        pn_extra_sp="fill", 
        pn_chan_up_layers=12,
        rot_pn=false,
        // extra center spacing if needed when inport_center=false
        inport_center=true,
        pn_out_len=12,
        extra_sp = 0, 
        fl_chan_init=[6, 6, 6],
        px=px, layer=layer, lpv=lpv, chan_h=6, chan_w=8, shape="cube", pitch=pitch, 
        offset_layers=5, no_obj=false, floor_area=false) ;
    
    module lef()
    {
        color("blue")
        lef_size(120, 120);
        
        lef_layer("met2")
        lef_port("in_fluid", "INPUT", "RECT",  [23, 53, 37, 67]) ;
        lef_layer("met2")
        lef_port("out_fluid", "OUTPUT", "RECT", [83, 53, 97, 67]) ;
        
        lef_layer("met4")
        lef_port("in_air", "INPUT", "RECT", [53, 23, 67, 37]) ;
        lef_layer("met4")
        lef_port("out_air", "OUTPUT", "RECT", [53, 83, 67, 97]) ;
        
        lef_layer("met2")
        lef_obs("RECT", [30, 30, 90, 90]) ;
        lef_layer("met3")
        lef_obs("RECT", [30, 30, 90, 90]) ;
        lef_layer("met4")
        lef_obs("RECT", [30, 30, 90, 90]) ;
    }
    if (ren_lef)
        lef() ;
    
}

valve_40px_1(0,0,0,"N");

px = 7.6e-3;

echo("SIZE") ;
echo(180*7.6e-3) ;
echo("PORT1", 30*px,  90*px) ;
echo("PORT2", 150*px, 90*px) ;
echo("PORT3", 90*px,  30*px) ;
echo("PORT4", 90*px, 150*px) ;
