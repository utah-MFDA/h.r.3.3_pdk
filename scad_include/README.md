
# Guild to scad files

### polychannel_route
```
```
Main polychannel for MFDA routing. Adds a few arguments for tracking component 
connections. These arguments however do not add any functionality, only used for
documenting.

### lef_helper.scad

This file is used to help generate LEF files for the MFDA flow. For the file to be 
generated you need to create a module called lef.
```
module lef() {
    // lef_statements
}
```
Remeber to add the following line to the component file.
```
use <lef_helper.scad>
```

The valid statements for SCAD -> LEF include
```
lef_size(X_size, Y_size)
lef_layer(layer_name)
lef_port(port_name, direction, geometry, pts, layer(optional))
lef_obs(geometry, pts, layer(optional))
```
 - direction - can equal "INPUT", "OUTPUT", "INOUT"
 - geometry - The only valid geometry currently is "RECT"
 - pts - is a list of pts such that [x0, y0, x1, y1, ... ]

lef_port and lef_obs are to be used with the lef_layer like other transformations in 
openscad.
```
lef_layer("met1")
    lef_obs(...) ;
```

### Parameteric scad objects

#### p_serpentine_obj
module p_serpentine_obj(
 - xpos, ypos, zpos, orientation
 - L1
 - L2
 - turns
 - px=7.6e-3,
 - layer=10e-3
 - lpv=20
 - chan_h=10, chan_w=14
 - shape="cube"
 - pitch=30,
 - no_obj=false
 - floor_area=false
 - chan_layers=2
 - clr="RosyBrown"
 - layer_offset=20
 - alt=0
 - rot=0)

#### p_valve
module p_valve(
- xpos, ypos, zpos, orientation,
- valve_r, mem_th, fl_chm_h, pn_chm_h, inport_center=false,
    // length of channels extending outside of valve radius
- out_len=30,
- fl_extra_sp = "fill", fl_chan_down_layers=30, pn_extra_sp="fill", pn_chan_up_layers=30, rot_pn=false,
    // extra center spacing if needed when inport_center=false
- extra_sp = 0,
- px=7.6e-3, layer=10e-3, lpv=20, chan_h=10, chan_w=14, shape="cube", pitch=30, offset_layers=10,
    rot=false, no_obj=false, floor_area=false)

#### p_valve_4way

#### p_chamber

#### p_tall_mixer

#### p_sqeeze_valve

#### 


### lef_helper config

All settings for the lef_helper are defined in the lef_scad_config.scad that need the
following variables.
```
layer = [ ... ] // list of strings of named layers
// layers are list sequentially bottom to top

platform_config = [
["lpv", value], // layer per via, number of manufacturing layers spacing routing layers
["px", value], // base pixel size in mm
["layer", value], // base layer size in mm
["pitch", value], // center to center distance between routing paths, in pixels
["via_w", value], // via size, in pixels
["bottom_layers", value] // number of layer offset before first routing layers
] ;

io_loc_layer = // being developed
```

