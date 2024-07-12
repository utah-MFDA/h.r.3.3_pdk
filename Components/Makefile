ROOT_DIR ?= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS 	= -o pipefail -c

BUILD_COMMAND = buildxyceplugin -d

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

KIT_NAME = h.r.3.3

#<<<<<<< HEAD
#KIT_NAME = h.r.3.3
#
#GENERAL_SRC_DIR = valves serpentine mixers
#
#=======
GENERAL_SRC_DIR = $(ROOT_DIR)/serpentine $(ROOT_DIR)/mixers $(ROOT_DIR)/directional_reserviors $(ROOT_DIR)/bidirectional_reserviors $(ROOT_DIR)/inline_reserviors
#valves
#>>>>>>> master
## Verilog A targets

VERILOGA_BUILD_DIR = $(ROOT_DIR)/verilogA_build

VA_SRC_DIR = $(GENERAL_SRC_DIR) $(ROOT_DIR)/veriloga_objects
VA_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*/*.va))
VAMS_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*.vams))

LEF_SRC_DIR = $(GENERAL_SRC_DIR)
LEF_FILES = $(foreach LEF_DIR, $(LEF_SRC_DIR),$(wildcard $(LEF_DIR)/*/*.lef))

SCAD_SRC_DIR= $(GENERAL_SRC_DIR) $(ROOT_DIR)/scad_objects/interfaces
SCAD_BUILD_DIR = $(ROOT_DIR)/scad_build
SCAD_FILES = $(foreach SCAD_DIR,$(SCAD_SRC_DIR),$(wildcard $(SCAD_DIR)/*/*.scad)) $(wildcard $(ROOT_DIR)/scad_objects/*.scad)

export MF_LIB = MFXyce

.PHONY: clean clean_va clean_scad clean_lef build_va build_scad build_lef
clean: clean_va clean_scad clean_lef
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
	cd $(VERILOGA_BUILD_DIR) && make

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

export TECH_LEF = $(ROOT_DIR)/../distrib/1.0.0/h.r.3.3.tlef
export LIB_FILES = $(ROOT_DIR)/../distrib/1.0.0/h.r.3.3.lib
export GDS_FILES = $(ROOT_DIR)/../distrib/1.0.0/h.r.3.3.gds

clean_lef:
	rm -f $(SC_LEF)

build_lef: $(SC_LEF)

################################################################
#  ____   ____    _    ____
# / ___| / ___|  / \  |  _ \
# \___ \| |     / _ \ | | | |
#  ___) | |___ / ___ \| |_| |
# |____/ \____/_/   \_\____/
#
################################################################

$(SCAD_BUILD_DIR):
	mkdir -p $@

export SCAD_COMPONENT_LIBRARY = $(SCAD_BUILD_DIR)/$(KIT_NAME)_merged.scad
export SCAD_ROUTING_LIBRARY = $(ROOT_DIR)/../distrib/1.0.0/routing_181220.scad
$(SCAD_COMPONENT_LIBRARY): $(SCAD_FILES) | $(SCAD_BUILD_DIR)
	cut -b 1- $^ | python3 cleanScadFile.py --stream >> $@
# cat scad_header.scad > $@	
# $(SCAD_COMPONENT_LIBRARY): $(SCAD_FILES) | $(SCAD_BUILD_DIR)
# cut -b 1- $^ | sed '/^(use|px|layer|lpv)/d' >> $@

SCAD_USE_FILES = $(wildcard ./scad_use/*.scad)
SCAD_USE_BUILD = $(patsubst ./scad_use/%, ./scad_build/%, $(SCAD_USE_FILES))
$(SCAD_USE_BUILD): $(SCAD_USE_FILES)
	cp $^ ./scad_build

cp_scad: $(SCAD_USE_BUILD) 

build_scad: $(SCAD_COMPONENT_LIBRARY)

clean_scad:
	rm -f $(SCAD_COMPONENT_LIBRARY)

check_library:
	python3 validateComponents.py --component_dir $(GENERAL_SRC_DIR)

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
