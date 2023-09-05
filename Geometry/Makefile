
SHELL 	 	= /bin/bash
.SHELLFLAGS = -o pipefail -c

#default target when invoking without specific target
.DEFAULT_GOAL := all

OPENROAD_MK_LOC = OpenROAD
OPENSCAD_MK_LOC = OpenSCAD

PLATFORM := mfda_30px_m

ifdef $(PLATFORM):
export PLATFORM
endif


run_openroad_make:
	cd $(OPENROAD_MK_LOC) && make

run_openscad_make:
	cd $(OPENSCAD_MK_LOC) && make

all: