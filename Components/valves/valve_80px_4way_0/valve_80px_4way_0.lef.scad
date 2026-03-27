use <openmfda/lef_helper.scad>
use <valve_80px_4way_0.scad>
use <openmfda/orientation.scad>
module valve_80px_4way_0_lef()
{
    color("yellow")
    lef_size(190, 190);

    lef_layer("met1")
    lef_port("a_fluid", "INOUT", "RECT",  [29.5, 89.5, 30.5, 90.5]) ;
    lef_layer("met1")
    lef_port("b_fluid", "INOUT", "RECT", [149.5, 89.5, 150.5, 90.5]) ;
    lef_layer("met1")
    lef_port("c_fluid", "INOUT", "RECT",  [89.5, 29.5, 90.5, 30.5]) ;
    lef_layer("met1")
    lef_port("d_fluid", "INOUT", "RECT", [89.5, 149.5, 90.5, 150.5]) ;

    lef_layer("met3")
    lef_port("in_air", "INPUT", "RECT", [89.5, 59.5, 90.5, 60.5]) ;
    lef_layer("met3")
    lef_port("out_air", "OUTPUT", "RECT", [89.5, 119.5, 90.5, 120.5]) ;

    lef_layer("met1")
    lef_obs("RECT", [30, 30, 150, 150]) ;
    lef_layer("met2")
    lef_obs("RECT", [30, 30, 150, 150]) ;
    lef_layer("met3")
    lef_obs("RECT", [60, 60, 120, 120]) ;
}
valve_80px_4way_0_lef();
valve_80px_4way_0(0, 0, 0, "N");
