use <openmfda/lef_helper.scad>
use <valve_40px_1.scad>
use <openmfda/orientation.scad>
module valve_40px_1_lef ()
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
orient(7.6e-3*[180,180], "E")
valve_40px_1_lef();

valve_40px_1(0, 0, 0, "E");





