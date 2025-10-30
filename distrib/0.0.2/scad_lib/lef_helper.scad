
include <lef_scad_config.scad>

ren_th = 0.1 ;

port_clr1 = "red" ;
port_clr2 = "blue" ;

module lef_obs(geometry, pts, px=0, layer=0)
{
    if(geometry=="RECT" || geometry=="rect")
    {
        %lef_rect(pts*get_config("px"), get_config("layer")*get_config("lpv")) ;
    }
}

module lef_port(port_name="", direction="", geometry="", pts=false, px=0, layer_h=0, layer=false, center=true)
{
    if(port_name=="" || direction=="" || geometry=="" || pts==false)
        echo("module def: lef_port(port_name, direction, geom, pts)") ;

    port_center = (
      len(pts)==4 ? [
        (pts[0]+pts[2])/2, ///2-get_config("via_w")/2,
        (pts[1]+pts[3])/2, ///2-get_config("via_w")/2,
        (pts[0]+pts[2])/2, ///2+get_config("via_w")/2,
        (pts[1]+pts[3])/2 ///2+get_config("via_w")/2
      ] : (len(pts)==2 ? 
        (!is_num(pts[0]) ? 
          [
            (pts[0][0]+pts[1][0])/2,
            (pts[0][1]+pts[1][1])/2,
            (pts[0][0]+pts[1][0])/2,
            (pts[0][1]+pts[1][1])/2,
          ] :
          (center ?
           pts : pts - get_config("chan_def")/2))
      : [])
      ) ;


    chan_centered = (
      len(pts) == 4 ? [
      -get_config("chan_def")[0]/2,
      -get_config("chan_def")[0]/2,
      get_config("chan_def")[0]/2,
      get_config("chan_def")[0]/2,
      ] :
        (!is_num(pts) == 2 ? [
            -get_config("chan_def")[0]/2,
            -get_config("chan_def")[0]/2,
            get_config("chan_def")[0]/2,
            get_config("chan_def")[0]/2,
          ] : 
          [
            get_config("chan_def")[0],
            get_config("chan_def")[0]
          ]
          )
    );

    echo(len(pts)) ;
    echo(port_center) ;
    echo(chan_centered) ;
    
    if(geometry=="RECT" || geometry=="rect")
    {
        if(len(pts)==4){
        color(port_clr1)
        lef_rect(
            (port_center + chan_centered
            )*(px!=0?px:get_config("px")), 
            (layer_h!=0?layer_h:get_config("chan_def")[1])*get_config("layer") // get channel height
            ) ;
        color(port_clr2, 0.6)
            lef_rect(
            pts * (px!=0?px:get_config("px")), 
            //(layer_h!=0?layer_h:get_config("layer")) * (get_config("lpv")-1)) ;
            (layer_h!=0?layer_h:get_config("layer")) * (get_config("lpv")-1)
            ) ;
            //[
              //(pts[0]+pts[2])/2-get_config("via_w")/2,
              //(pts[1]+pts[3])/2-get_config("via_w")/2,
              //(pts[0]+pts[2])/2+get_config("via_w")/2,
              //(pts[1]+pts[3])/2+get_config("via_w")/2
            //] 
        }
        if(len(pts)==2)
        {
          if(is_num(pts[0])){
            color(port_clr1)
            lef_rect(
                (pts
                )*(px!=0?px:get_config("px")), 
                (layer_h!=0?layer_h:get_config("chan_def")[1])*get_config("layer"), // get channel height
                center=center
                ) ;
            color(port_clr2, 0.6)
            lef_rect(
                (pts
                ) * (px!=0?px:get_config("px")), 
                (layer_h!=0?layer_h:get_config("layer"))*(get_config("lpv")-1),
                center=center
                ) ;
          } else {
            color(port_clr1)
            lef_rect(
                (port_center + chan_centered
                )*(px!=0?px:get_config("px")), 
                (layer_h!=0?layer_h:get_config("chan_def")[1])*get_config("layer"), // get channel height
                center=center
                ) ;
            color(port_clr2, 0.6)
            lef_rect(
                [pts[0],pts[1],
                pts[0]+get_config("via_w"),
                pts[1]+get_config("via_w")] * (px!=0?px:get_config("px")), 
                (layer_h!=0?layer_h:get_config("layer"))*(get_config("lpv")-1),
                center=center
                ) ;
          }
        }
    } 
}

module lef_rect(pts, th=ren_th, center=true)
{
    w  = (len(pts)==2 ?
          (!is_num(pts[0]) ? abs(pts[0][0] - pts[1][0]):
            get_config("chan_def")[0]*get_config("px")):
        (len(pts)==4 ? abs(pts[0] - pts[2]):0));
    h  = (len(pts)==2 ?
          (!is_num(pts[0]) ? abs(pts[0][1] - pts[1][1]):
            get_config("chan_def")[1]*get_config("layer")):
        (len(pts)==4 ? abs(pts[1] - pts[3]):0));
    ox = (len(pts)==2 ?
          (!is_num(pts[0]) ? abs(pts[0][0]):
            (center ? pts[0]-get_config("chan_def")[0]/2*get_config("px"):pts[0])):
        (len(pts)==4 ? abs(pts[0]):0));
    oy = (len(pts)==2 ?
          (!is_num(pts[0]) ? abs(pts[0][1]):
            (center ? pts[1]-get_config("chan_def")[0]/2*get_config("px"):pts[0])):
        (len(pts)==4 ? abs(pts[1]):0));

    echo(ox, oy) ;
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


lef_size(200, 200) ;

lef_layer("met1")
    lef_obs("RECT", [0,0,100,120]) ;
lef_layer("met2")
    lef_obs("RECT", [0,0,100,120]) ;

lef_layer("met2")
    lef_port("", "", "RECT", [14,14,28,38]) ;

lef_layer("met2")
    lef_port("", "", "RECT", [14,44,30,62]) ;

lef_layer("met2")
    lef_port("", "", "RECT", [44,24]) ;

