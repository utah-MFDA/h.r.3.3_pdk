use <openmfda/components/reservoir.scad>
use <openmfda/polychannel/polychannel.scad>
use <openmfda/components/lef_helper.scad>


module directional_res_1000nl(xpos, ypos, zpos, orientation,
  px=0.0076, layer=0.01, lpv=20, pitch=30, ren_lef=false
)
{
    
    module obj() {
      res_h = 140 ;
      port_len = 25 ;
      y_offs = 17 ;
      chan_h = 10 ;
      chan_w = 14 ;
      pch_sz = [chan_w*px, chan_w*px, chan_h*layer] ;
      pch_shp = "cube" ;

      translate([37*px,y_offs*px,1*lpv*layer])
      p_reservoir(xpos, ypos, zpos, orientation,
          ports = [["x-", 30, [0,(res_h-10)/2]],
                   ["z-", lpv-chan_h/2, [0, 0]]],
          size=[124, 100, res_h ], edge_rounding=0.2, 
          center=true, clr="gray",
          px=0.0076, layer=0.010, pitch=30, $fs=0.04, $fa=1
          ) ;
      // top port
      polychannel([
        [ pch_shp, pch_sz, 
          [(pitch)*px,(3+pitch+chan_w/2+100/2)*px,(lpv*8-chan_h/2)*layer],
          no_rot() ],
        [ pch_shp, pch_sz, [0,0,(chan_h-lpv)*layer], no_rot() ]
        ]) ;

      // bottom port
      res_ct_z = [
        (124/2+pitch+port_len+5)*px,
        (100/2+pitch+chan_w/2+3)*px,
        chan_h/2*layer] ;
      polychannel([
        [pch_shp, pch_sz, res_ct_z, no_rot()],
        [pch_shp, pch_sz, [(124/2+port_len)*px,0,0], no_rot()]
        ]) ;
  }

  module lef()
  {
      lef_size(245, 180) ;
      lef_layer("met1")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met2")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met3")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met4")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met5")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met6")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met7")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met8")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      lef_layer("met9")
      lef_obs("RECT", [30, 30, 215, 150]) ;
      
      lef_layer("met8")
      lef_port("in_fluid", "INPUT", "RECT", [23, 83, 37, 97]) ;
      lef_layer("met1")
      lef_port("out_fluid", "OUTPUT", "RECT", [208, 83, 222, 97]) ;
  }
  obj() ;
  if (ren_lef)
      lef() ;
}

directional_res_1000nl(0,0,0,"N", ren_lef=true) ;
