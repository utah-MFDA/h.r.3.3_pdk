use <openmfda/components/lef_helper.scad>
use <valve_80px_1.scad>
use <openmfda/components/orientation.scad>
module valve_80px_1_lef()
{
    color("yellow")
    lef_size(190, 190);

    lef_layer("met1")
    lef_port("in_fluid", "INPUT", "RECT",  [29.5, 89.5, 30.5, 90.5]) ;
    lef_layer("met1")
    lef_port("out_fluid", "OUTPUT", "RECT", [149.5, 89.5, 150.5, 90.5]) ;

    lef_layer("met3")
    lef_port("in_air", "INPUT", "RECT", [89.5, 29.5, 90.5, 30.5]) ;
    lef_layer("met3")
    lef_port("out_air", "OUTPUT", "RECT", [89.5, 149.5, 90.5, 150.5]) ;

    lef_layer("met1")
    lef_obs("RECT", [30, 30, 150, 150]) ;
    lef_layer("met2")
    lef_obs("RECT", [30, 30, 150, 150]) ;
    lef_layer("met3")
    lef_obs("RECT", [30, 30, 150, 150]) ;
}

valve_80px_1_lef();
valve_80px_1(0,0,0,"N");
