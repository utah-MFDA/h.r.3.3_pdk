# Component library python script tools

## Lef extraction from scad

This script uses an interal lef module in the scad component to write the lef file for the component. For automatically generating the lef file, the directory will need to be included in the LEF_SCAD_EXTRACT variable in the Makefile.

extract_lef.py arguments

--scad
 - input scad file. requires definition of a lef module for functionality of this script

--of
 - outfile, name of output file

--ignore_no_lef_module
 - Prevents raising errors if the lef module does not exist

--silent -q
 - Less verbose

## Clean scad file

This script removes all unnessary extras outside of the component module definition.
