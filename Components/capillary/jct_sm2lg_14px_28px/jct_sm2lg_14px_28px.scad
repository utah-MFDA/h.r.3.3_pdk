
use <../../../scad_include/lef_helper.scad>
//use <../../../scad_include/mfda_polychannels.scad>
use <../../../scad_include/polychannel_v2.scad>


module jct_sm2lg_14px_28px(xpos, ypos, zpos, orientation,
  sm_sz = [14, 14, 10], lg_sz = [28, 28, 15],
  px=7.6e-3, layer=10e-3, pitch=30, render_lef=false)
{

  function px2mm (vec) = [for (i=[0:1:2]) (i<2 ? vec[i]*px : vec[i]*layer)] ;
  
  module obj() {

    init_pos = [pitch*px+lg_sz[0]*px/2, pitch*px+lg_sz[1]*px/2, lg_sz[2]*layer/2] ;

    sm_ch = px2mm(sm_sz) ;
    lg_ch = px2mm(lg_sz) ;

    lg_ch_len = 62 ;

    // lg channel
    polychannel(
    [
      ["cube", lg_ch, init_pos, no_rot() ],
      ["cube", lg_ch, px2mm([lg_ch_len, 0, 0]), no_rot() ]
    ]) ;

    // sm channel
    init_pos_sm = [
      pitch*2*px,
      pitch*px + sm_ch[1]/2 + lg_ch[1]/2,
      sm_ch[2]/2
      ] + px2mm([0, 0, 0]) ;
    sm_ch_len = 60 ;
    polychannel(
    [
      ["cube", sm_ch, init_pos_sm, no_rot() ],
      ["cube", sm_ch, px2mm([0, sm_ch_len, 0]), no_rot() ],
    ],
      clr="yellow"
    ) ;
  }

  module lef()
  {
    lef_size(150, 150) ;

    lef_layer("met1")
    lef_obs("RECT", [30, 30, 120, 120]) ;

    lef_layer("met1");
    lef_port(port_name = "fluid_in_a",  direction = "INPUT",  geometry = "RECT", pts = [16, 30, 44, 58]);
    lef_layer("met1");
    lef_port(port_name = "fluid_out_a", direction = "OUTPUT", geometry = "RECT", pts = [106, 30, 134, 58]);
    lef_layer("met1");
    lef_port(port_name = "fluid_in_b",  direction = "INPUT",  geometry = "RECT", pts = [53, 113, 67, 127]);

  }

  if (render_lef) {
    lef(); }

  translate([xpos, ypos, zpos])
  obj() ;

}

jct_sm2lg_14px_28px(
  xpos = 0, 
  ypos = 0,
  zpos = 0,
  orientation = 7.6e-3,
  layer = 10e-3,
  pitch = 30,
  render_lef = true);
