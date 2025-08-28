// TODO there are two copies of this file.
include <lef_scad_config.scad>

ren_th = 0.1 ;

port_clr1 = "red" ;
port_clr2 = "blue" ;

/**
 * Apply LEF/DEF style orientation changes specified by a text flag.
 * See LEF/DEF 5.8 Language Reference manual page 244
 * There is currently no way in OpenSCAD to determine bounding box
 * to do automatic translation, you will need to provide it.
 */
module orientation(width, height, orient) {
    if (orient == "N" || orient == "R0"){
        children();
    } else if (orient == "S" || orient == "R180"){
        translate([width, height, 0])
        rotate([0, 0, 180])
        children();
    } else if (orient == "E" || orient == "R270") {
        translate([0, width, 0])
        rotate([0, 0, 270])
        children();
    } else if (orient == "W" || orient == "R90") {
        translate([height, 0, 0])
        rotate([0, 0, 90])
        children();
    } else if (orient == "FN" || orient == "MY"){
        translate([width, 0, 0])
        mirror([1, 0, 0])
        children();
    } else if (orient == "FS" || orient == "MX"){
        translate([0, height, 0])
        mirror([0, 1, 0])
        children();
    } else if (orient == "FE" || orient == "MY90" || orient == "MYR90") {
        translate([height, width, 0])
        rotate([0, 0, 270])
        mirror([0, 1, 0])
        children();
    } else if (orient == "FW" || orient == "MX90" || orient == "MXR90") {
        translate([0, 0, 0])
        rotate([0, 0, 270])
        mirror([1, 0, 0])
        children();
    } else {
        assert(false, concat("Unknown rotation applied", orient));
    }
}

module lef_obs(geometry, pts, px=0, layer=0)
{
    if(geometry=="RECT" || geometry=="rect")
    {
        %lef_rect(pts*get_config("px"), get_config("layer")*get_config("lpv")) ;
    }
}

module lef_port(port_name="", direction="", geometry="", pts=false, px=0, layer_h=0, layer=false)
{
    if(port_name=="" || direction=="" || geometry=="" || pts==false)
        echo("module def: lef_port(port_name, direction, geom, pts)") ;

    if(geometry=="RECT" || geometry=="rect")
    {
        color(port_clr1)
        lef_rect(
            pts*(px!=0?px:get_config("px")),
            (layer_h!=0?layer_h:get_config("layer"))*get_config("lpv")) ;
        color(port_clr2)
        if(len(pts)==4){
            lef_rect(
            [
              (pts[0]+pts[2])/2-get_config("via_w")/2,
              (pts[1]+pts[3])/2-get_config("via_w")/2,
              (pts[0]+pts[2])/2+get_config("via_w")/2,
              (pts[1]+pts[3])/2+get_config("via_w")/2
            ] * (px!=0?px:get_config("px")),
            (layer_h!=0?layer_h:get_config("layer"))*(get_config("lpv")-1)) ;
        }
        if(len(pts)==2)
        {
        lef_rect(
            [pts[0],pts[1],
            pts[0]+get_config("via_w"),
            pts[1]+get_config("via_w")]*(px!=0?px:get_config("px")),
            (layer_h!=0?layer_h:get_config("layer"))*(get_config("lpv")-1)) ;
        }
    }
}

module lef_rect(pts, th=ren_th)
{
    w  = (len(pts)==2?abs(pts[0][0] - pts[1][0]):
        (len(pts)==4?abs(pts[0] - pts[2]):0));
    h  = (len(pts)==2?abs(pts[0][1] - pts[1][1]):
        (len(pts)==4?abs(pts[1] - pts[3]):0));
    ox = (len(pts)==2?abs(pts[0][0]):
        (len(pts)==4?abs(pts[0]):0));
    oy = (len(pts)==2?abs(pts[0][1]):
        (len(pts)==4?abs(pts[1]):0));
    translate([ox, oy, 0])
        cube([w, h, th]) ;
}

module lef_layer(layer_name)
{
    l_off = get_config("layer") * get_config("lpv") * get_layer_index(layer_name) ;

    translate([0,0,l_off])
        children() ;
}

module lef_size(X, Y)
{
    cube([X*get_config("px"), Y*get_config("px"), get_config("layer")*0.1]);
}

function get_layer_index(x) = search([x], layers)[0] ;

function get_config(prop) = platform_config[search([prop], platform_config)[0]][1] ;

function get_io_layer(x1, x2) = io_loc_layer[x1][x2] ;


lef_layer("met1")
    lef_obs("RECT", [0,0,100,120]) ;

lef_layer("met2")
    lef_port("", "", "RECT", [14,14,16,16]) ;
