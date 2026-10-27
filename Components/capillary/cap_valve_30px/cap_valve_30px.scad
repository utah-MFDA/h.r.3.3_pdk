
use <../../../scad_include/lef_helper.scad>
use <../../../scad_include/polychannel_v2.scad>


module cap_valve_30px(xpos, ypos, zpos, orientation,
  sm_sz=[14, 14, 10],
  px=7.6e-3, layer=10e-3, pitch=30, render_lef=false)
{
  function px2mm (vec) = [for (i=[0:1:2]) (i<2 ? vec[i]*px : vec[i]*layer)] ;

  lg_sz = [40, 40, sm_sz[2]] ;

  init_pos = px2mm([
    pitch + sm_sz[0]/2,
    pitch*2,
    sm_sz[2]/2
  ]) ;

  ch_shp = "cube" ;

  sm_ch = px2mm(sm_sz) ;
  lg_ch = px2mm(lg_sz) ;

  echo(sm_ch) ;
  echo(lg_ch) ;

  module obj() {
    polychannel([
      [ch_shp, sm_ch, init_pos, no_rot()],
      [ch_shp, sm_ch, [(20+18)*px, 0, 0], no_rot()],
      [ch_shp, lg_ch, [0, 0, 0], no_rot()],
      [ch_shp, lg_ch, [(0)*px, 0, 0], no_rot()],
      [ch_shp, sm_ch, [0, 0, 0], no_rot()],
      [ch_shp, sm_ch, [(20+18)*px, 0, 0], no_rot()],
    ]
    ) ;
  }

  module lef() {
    lef_size(150, 120) ;
    lef_layer("met1")
    lef_obs("RECT", [30, 30, 120, 90]) ;

    lef_layer("met1")
    lef_port(
      port_name = "fluid_in",
      direction = "INPUT",
      geometry = "RECT",
      pts = [23, 53, 37, 67]);

    lef_layer("met1")
    lef_port(
      port_name = "fluid_out",
      direction = "OUTPUT",
      geometry = "RECT",
      pts = [113, 53, 127, 67]);
  }


  if (render_lef) {
    lef();}

  translate([xpos, ypos, zpos])
    obj() ;
}

cap_valve_30px(
  xpos = 0,
  ypos = 0,
  zpos = 0,
  orientation = "N",
  sm_sz = [14, 14, 10],
  px = 7.6e-3,
  layer = 10e-3,
  pitch = 30,
  render_lef = true);

