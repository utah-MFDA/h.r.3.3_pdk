# Process design kit (PDK) for the H.R.3.3 3D printer.

All of the components for the library are placed in the Components subdirectory which is further broken out into subdirectories into there respective functional directory (valve, mixer, ...). Inside those directories are the respective specific component containing three different files for the software:
 - LEF (.lef)
 - Verilog-AMS (.va)
 - OpenSCAD (.scad)

Directory:

 - Building the libary
 - Adding components to the library
    - Place and Routing
    - SCAD
        - Installing OpenSCAD libraries on local OpenSCAD
    - Xyce (Spice)

## Building the library

Building the library the following commands can be run. Each command will make a merge file containing all of the libary contents or create a lib binrary for simulations.

```
make build_lef
# h.r.3.3_merged.lef will be placed in Components directory

make build_scad
# h.r.3.3_merged.scad will be placed in scad_lib directory

make build_va
#

```


## Adding to the component library


You can make a new subdirectory for the component that you would like to add to the library. This component will be to be a subdirectory call in the GENERAL_SRC_DIR variable in the make file with the appropriate extension (such .va for Xyce, .lef for place and routing, and .scad for 3D rendering ). Otherwise the software will not see it.

Components can be made in new subdirectories (component directories) of the subdirectories of the current Component directory (like within the serpentine directory, or component class directories)

If additional component class directies are made they need to be added to the Makefile variable (within the Component directory) GENERAL_SRC_DIR for the software to find them.

Otherwise new component directories can be made and build with the following make commands within the Component directory.

### Place and Route (.lef)


Running the following commend 
```
make build_lef
```

Will generate a merged lef file called HR3.3_merged.lef of the avalible components, provided they have the correct extension.

### Xyce (.va)

To initialize the Xyce library run, to get the docker image:
```
make init_va
```

Then to build the Xyce library run: 
```
make make_va_remote
```


For Verilog-AMS development you can make a new subdirectory in xyce_testing/MFlibrary_testing to run specific Xyce tests.

To run all of the tests run
```
make run_tests_remote
```

To run a single test run
```
make run_single_test_mf INFILE=<path-to>/<your_cir-file>
```

### 3D model generator (.scad)

Running the following command will build the library into a merge scad file.
```
make build_scad
```

Will generate a merged scad file called h.r.3.3_merged.scad of the avalible components, provided they have the correct extension.

To include the scad libary components into the main scad directory it can be install by make
```
make install_scad_libary
```
or by running the python script:
```
python3 install_scad_libary.py
```
or with components as there individual files,
```
python3 install_scad_libary.py --unmerged
```

The scad library can than be included by having 
```
use <h.r.3.3/h.r.3.3_merged.scad>
// or 
use <h.r.3.3/replace_with_component_name.scad>
```

For using the LEF for SCAD generating script refer to the README.md in the scad_include directory.

### Component check

This just checks if the components exist within there subdirectory and generates a list of developed standard components.

run from within the Component directory
```
make check_library
```

You can then look at the Component_Check.csv and StandardCellLibrary.csv for what files exist.


## Instructions for additional components

Adding new components will require at a minimum creating the approperate .scad and .lef file. Components without a .va file will not be able to be used with validation tools.

To start a component can be add with an STL file exported from another CAD program, or from generating a .scad script. Geometry can be checked with OpenSCAD to validate the geometry. This library also contains tools for generating basic .lef file from OpenSCAD.

### LEF

### OpenSCAD

OpenSCAD is an opensource textual CAD modeling software. It is primarily used to generate the 3D rendering of the device and components to use in slicing for 

### VERILOG-AMS

It is suggested that all behavioral definitions for each verilog-ams file follow the guidelines outlined in: \
<a href="https://ieeexplore.ieee.org/document/7154394">C. C. McAndrew et al., "Best Practices for Compact Modeling in Verilog-A," in IEEE Journal of the Electron Devices Society, vol. 3, no. 5, pp. 383-396, Sept. 2015, doi: 10.1109/JEDS.2015.2455342.</a>

