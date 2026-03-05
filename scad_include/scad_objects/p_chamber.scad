use <../polychannel_v2.scad>

module p_chamber(xpos, ypos, zpos, orientation,
    chm_r, chm_h, chm_len=0,
    conn_ch_w=14, conn_ch_h=10, conn_ch_l=20,
    px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10, $fn=50,
    no_obj=false, floor_area=false) {

        module obj(){

            real_conn_h = (conn_ch_h>chm_h?chm_h:conn_ch_h);

            if(chm_len > 2*chm_r)
            {

                translate([chm_len/2-chm_r, 0, 0])
                    cylinder(chm_h, r=chm_r, center= true) ;
                translate([-chm_len/2+chm_r, 0, 0])
                    cylinder(chm_h, r=chm_r, center= true) ;
                cube([chm_len-chm_r*2, chm_r*2, chm_h], center= true) ;
            }
            else{
                cylinder(chm_h, r=chm_r, center= true) ;
            }
            translate([-chm_len/2-conn_ch_l/2+chm_r/2, 0, 0])
                cube([conn_ch_l+chm_r, conn_ch_w, real_conn_h], center=true);
            translate([chm_len/2+conn_ch_l/2-chm_r/2, 0, 0])
                cube([conn_ch_l+chm_r, conn_ch_w, real_conn_h], center=true);

        }

        x_off = chm_len/2+conn_ch_l ;
        y_off = chm_r ;

        scale([px, px, layer])
        translate([xpos, ypos, zpos])
        translate([(pitch-chan_w/2), (pitch-chan_w/2), offset_layers])
        translate([x_off, y_off, chm_h/2])
        orient(x_off*2, y_off*2, orientation)
            obj();

    }


// p_chamber(1,0,0,"N", 100, 10, chm_len=800)
