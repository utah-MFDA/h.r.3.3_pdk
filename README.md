Process design kit (PDK) for the H.R.3.3 3D printer.


## Adding to the component library

Each component will be broken out into subdirectories into there respective functional directory (valve, mixer, ...).

Each component must have three files to be used for the MFDA software they are:
- LEF (.lef)
- Verilog-AMS (.va)
- OpenSCAD (.scad)

### LEF

### VERILOG-AMS

It is suggested that all behavioral definitions for each verilog-ams file follow the guidelines outlined in: \
<a href="https://ieeexplore.ieee.org/document/7154394">C. C. McAndrew et al., "Best Practices for Compact Modeling in Verilog-A," in IEEE Journal of the Electron Devices Society, vol. 3, no. 5, pp. 383-396, Sept. 2015, doi: 10.1109/JEDS.2015.2455342.</a>

### OpenSCAD

