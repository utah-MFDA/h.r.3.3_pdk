ROOT_DIR ?= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

PY_SCRIPTS_DIR = $(realpath $(ROOT_DIR)/../py_scripts)

all: build_va build_lef build_scad

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS 	= -o pipefail -c

BUILD_COMMAND = buildxyceplugin -d

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

KIT_NAME = h.r.3.3
NUM_LAYERS=10
CHANNEL_WIDTH=6
DISTRIB_VERSION=0.0.2

GENERAL_SRC_DIR = $(ROOT_DIR)/serpentine \
									$(ROOT_DIR)/mixers \
									$(ROOT_DIR)/directional_reserviors \
									$(ROOT_DIR)/inline_reserviors \
									$(ROOT_DIR)/valves \
									$(ROOT_DIR)/pumps \
									$(ROOT_DIR)/optical_measure \
									$(ROOT_DIR)/interface

PCELL_SRC = $(ROOT_DIR)/p_serpentine
#valves
## Verilog A targets

VERILOGA_BUILD_DIR = $(ROOT_DIR)/verilogA_build

VA_SRC_DIR = $(GENERAL_SRC_DIR) $(PCELL_SRC) $(ROOT_DIR)/veriloga_objects
VA_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*/*.va))
VAMS_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*.vams))

LEF_SRC_DIR = $(GENERAL_SRC_DIR)
LEF_FILES = $(foreach LEF_DIR, $(LEF_SRC_DIR),$(wildcard $(LEF_DIR)/*/*.lef))

SCAD_SRC_DIR= $(GENERAL_SRC_DIR) $(PCELL_SRC) $(ROOT_DIR)/scad_objects/interfaces
SCAD_BUILD_DIR = $(ROOT_DIR)/scad_build
SCAD_FILES = $(foreach SCAD_DIR,$(SCAD_SRC_DIR),$(wildcard $(SCAD_DIR)/*/*.scad)) $(wildcard $(ROOT_DIR)/scad_objects/*.scad)

SCAD_2_LEF_SRC_DIR = $(ROOT_DIR)/directional_reserviors \
									$(ROOT_DIR)/inline_reserviors \
									$(ROOT_DIR)/valves \
									$(ROOT_DIR)/pumps \
									$(ROOT_DIR)/optical_measure

SCAD_2_LEF_SRC = $(foreach SCAD_DIR,$(SCAD_2_LEF_SRC_DIR),$(wildcard $(SCAD_DIR)/*/*.scad))

export MF_LIB = MFXyce

.PHONY: clean_all clean_va clean_scad clean_lef build_va build_scad build_lef
clean_all: clean_va clean_scad clean_lef
################################################################
# __     __        _ _
# \ \   / /__ _ __(_) | ___   __ _
#  \ \ / / _ \ '__| | |/ _ \ / _` |
#   \ V /  __/ |  | | | (_) | (_| |
#    \_/ \___|_|  |_|_|\___/ \__, |
#                            |___/
################################################################
$(VERILOGA_BUILD_DIR):
	mkdir -p $@

export VA_COPIES = $(addprefix $(VERILOGA_BUILD_DIR)/,$(notdir $(VA_FILES)))
export VAMS_COPIES = $(addprefix $(VERILOGA_BUILD_DIR)/,$(notdir $(VAMS_FILES)))

copy: $(VA_COPIES) $(VAMS_COPIES)

$(VA_COPIES) &: $(VA_FILES) | $(VERILOGA_BUILD_DIR)
	cp $(VA_FILES) $(VERILOGA_BUILD_DIR)

$(VAMS_COPIES) &:  $(VAMS_FILES) | $(VERILOGA_BUILD_DIR)
	cp $(VAMS_FILES) $(VERILOGA_BUILD_DIR)

export XYCE_LIB = $(VERILOGA_BUILD_DIR)/$(MF_LIB).so

# Build using the buildxyceplugin script instead of Makefile
# $(XYCE_LIB): $(VA_COPIES) $(VAMS_COPIES)
# 	cd $(VERILOGA_BUILD_DIR) && $(BUILD_$(BUILD_COMMAND) -o $(MF_LIB) $(notdir $(VA_COPIES)) ./

$(VERILOGA_BUILD_DIR)/Makefile: $(ROOT_DIR)/xyce.mk
	cp $< $@

$(XYCE_LIB): $(VA_COPIES) $(VAMS_COPIES) $(VERILOGA_BUILD_DIR)/Makefile
	cd $(VERILOGA_BUILD_DIR) && make ${MF_LIB}.so

build_va: $(XYCE_LIB)

clean_va:
	rm -rf $(VERILOGA_BUILD_DIR)

################################################################
#  _     _____ _____
# | |   | ____|  ___|
# | |   |  _| | |_
# | |___| |___|  _|
# |_____|_____|_|
#
################################################################
export SC_LEF = $(ROOT_DIR)/$(KIT_NAME)_merged.lef
$(SC_LEF): $(LEF_FILES)
	echo "VERSION 5.7 ;" > $@
	echo 'BUSBITCHARS "[]" ;' >> $@
	echo 'DIVIDERCHAR "/" ;' >> $@
	cut -b 1- $^ >> $@
	echo "END LIBRARY" >> $@

export TECH_LEF = $(ROOT_DIR)/h.r.3.3.tlef
export LIB_FILES = $(ROOT_DIR)/../distrib/0.0.1/h.r.3.3.lib
export GDS_FILES = $(ROOT_DIR)/../distrib/0.0.1/h.r.3.3.gds

SCAD_2_LEF_PY = $(PY_SCRIPTS_DIR)/extract_lef.py
SCAD_2_LEF_TRG = $(patsubst %.scad, %.lef, $(SCAD_2_LEF_SRC))
$(SCAD_2_LEF_TRG): %.lef: %.scad
	python3 $(SCAD_2_LEF_PY) --scad $< --ignore_no_lef_module -q

$(TECH_LEF):
	python3 $(PY_SCRIPTS_DIR)/generate_tlef.py ${NUM_LAYERS} ${CHANNEL_WIDTH} > $@

clean_lef:
	rm -f $(SC_LEF)

build_tlef: $(TECH_LEF)
build_lef: $(SC_LEF)
scad_2_lef: $(SCAD_2_LEF_TRG)

################################################################
#  ____   ____    _    ____
# / ___| / ___|  / \  |  _ \
# \___ \| |     / _ \ | | | |
#  ___) | |___ / ___ \| |_| |
# |____/ \____/_/   \_\____/
#
################################################################
SCAD_COMPONENT_HEADER = $(PY_SCRIPTS_DIR)/scad_header.scad
CLEAN_SCAD_SCRIPT = $(PY_SCRIPTS_DIR)/cleanScadFile.py --scad_header $(SCAD_COMPONENT_HEADER)

$(SCAD_BUILD_DIR):
	mkdir -p $@

export SCAD_COMPONENT_LIBRARY = $(SCAD_BUILD_DIR)/$(KIT_NAME)_merged.scad
$(SCAD_COMPONENT_LIBRARY): $(SCAD_FILES) | $(SCAD_BUILD_DIR)
	cut -b 1- $^ | python3 $(CLEAN_SCAD_SCRIPT) --stream > $@
# cat scad_header.scad > $@
# $(SCAD_COMPONENT_LIBRARY): $(SCAD_FILES) | $(SCAD_BUILD_DIR)
# cut -b 1- $^ | sed '/^(use|px|layer|lpv)/d' >> $@

SCAD_USE_FILES = $(addprefix $(ROOT_DIR)/../scad_include/, routing.scad polychannel_v2.scad lef_helper.scad)
SCAD_USE_BUILD = $(patsubst $(ROOT_DIR)/../scad_include/%, $(ROOT_DIR)/scad_build/%, $(SCAD_USE_FILES))
$(SCAD_USE_BUILD): $(SCAD_USE_FILES)
	cp $^ ./scad_build

cp_scad: $(SCAD_USE_BUILD)

build_scad: $(SCAD_COMPONENT_LIBRARY)

clean_scad:
	rm -f $(SCAD_COMPONENT_LIBRARY)

check_library:
	python3 validateComponents.py --component_dir $(GENERAL_SRC_DIR)


################################################################
#  _  ___  ____          _
# | |/ (_)/ ___|__ _  __| |
# | ' /| | |   / _` |/ _` |
# | . \| | |__| (_| | (_| |
# |_|\_\_|\____\__,_|\__,_|
#
################################################################
kicad: $(ROOT_DIR)/h.r.3.3.pretty osdi

$(ROOT_DIR)/h.r.3.3.pretty: $(SC_LEF) $(TECH_LEF)
	python3 $(PY_SCRIPTS_DIR)/lef_to_footprint.py --tlef $(TECH_LEF) --lef $< --output $(ROOT_DIR) --name h.r.3.3

%.osdi: %.va
	openvaf $<

KICAD_SPICE_OSDI = $(patsubst %.va,%.osdi,$(wildcard kicad_simulation/*.va))
KICAD_SPICE_LIB = $(patsubst %.va,%.lib,$(wildcard kicad_simulation/*.va))
osdi: ${KICAD_SPICE_OSDI}
################################################################
#  ____                      _
# |  _ \ ___ _ __ ___   ___ | |_ ___
# | |_) / _ \ '_ ` _ \ / _ \| __/ _ \
# |  _ <  __/ | | | | | (_) | ||  __/
# |_| \_\___|_| |_| |_|\___/ \__\___|
#
################################################################
#>>>>>>> master
#DOCKER_IMAGE = bgoenner/mfda_xyce:latest
DOCKER_IMAGE = bgoenner/mfda_xyce:2.0.1

DOCKER_LOCAL_COMP_DIR = ./

DOCKER_REMOTE_COMP_DIR = /mfda_simulation/local/Components
DOCKER_REMOTE_VA_BUILD =  $(DOCKER_REMOTE_COMP_DIR)_tmp

# change to lib
make_va_remote:
	mkdir -p $(VERILOGA_BUILD_DIR)/lib
	docker run \
	-a stdout \
	-v $(DOCKER_LOCAL_COMP_DIR):$(DOCKER_REMOTE_COMP_DIR) \
	-w $(DOCKER_REMOTE_COMP_DIR) \
	--entrypoint='' \
	--rm \
	$(DOCKER_IMAGE) make build_on_remote

make_va_docker: make_va_remote

build_scad_remote: make_scad

build_va_remote_tmp:
	cp -r $(DOCKER_REMOTE_COMP_DIR) $(DOCKER_REMOTE_VA_BUILD)
	cd $(DOCKER_REMOTE_VA_BUILD) && make make_default
	cp $(DOCKER_REMOTE_COMP_DIR)_tmp/$(VERILOGA_BUILD_DIR)/lib/lib$(MF_LIB).so $(VERILOGA_BUILD_DIR)/lib/

build_on_remote:
	cd $(DOCKER_REMOTE_COMP_DIR) && make make_va_default

clean_va_build:
	rm -r $(VERILOGA_BUILD_DIR)

clean_xyce_build: clean_va_build

make_va_default: $(VERILOGA_BUILD_DIR)/lib/$(MF_LIB).so

################################################################
#  ____  _     _        _ _
# |  _ \(_)___| |_ _ __(_) |__
# | | | | / __| __| '__| | '_ \
# | |_| | \__ \ |_| |  | | |_) |
# |____/|_|___/\__|_|  |_|_.__/
#
################################################################
DISTRIB_TARGETS = $(TECH_LEF) $(SC_LEF)\
	$(SCAD_COMPONENT_LIBRARY) $(SCAD_USE_BUILD) \
	$(ROOT_DIR)/h.r.3.3.pretty \
	$(ROOT_DIR)/kicad_symbols/mfda.kicad_sym $(ROOT_DIR)/kicad_symbols/mfda_spice.kicad_sym \
	kicad_simulation

$(ROOT_DIR)/../distrib/$(DISTRIB_VERSION): $(DISTRIB_TARGETS)
	mkdir -p $@
	cp -r $^ $@

distrib: $(ROOT_DIR)/../distrib/$(DISTRIB_VERSION)
