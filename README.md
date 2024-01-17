Process design kit (PDK) for the H.R.3.3 3D printer.

All of the components for the library are placed in the Components subdirectory which is further broken out into subdirectories into there respective functional directory (valve, mixer, ...). Inside those directories are the respective specific component containing three different files for the software:
 - LEF (.lef)
 - Verilog-AMS (.va)
 - OpenSCAD (.scad)

## Adding to the component library

You can make a new subdirectory for the component that you would like to add to the library. This component will be to be a subdirectory call in the GENERAL_SRC_DIR variable in the make file with the appropriate extension (such .va for Xyce). Otherwise the software will not see it.

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


### LEF

### VERILOG-AMS

It is suggested that all behavioral definitions for each verilog-ams file follow the guidelines outlined in: \
<a href="https://ieeexplore.ieee.org/document/7154394">C. C. McAndrew et al., "Best Practices for Compact Modeling in Verilog-A," in IEEE Journal of the Electron Devices Society, vol. 3, no. 5, pp. 383-396, Sept. 2015, doi: 10.1109/JEDS.2015.2455342.</a>

### OpenSCAD

