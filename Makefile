#ROOT_DIR ?= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
#PDK_ROOT_DIR ?= $(dir $(realpath ./))
PDK_ROOT_DIR ?= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

COMPONENT_DIR = $(realpath $(PDK_ROOT_DIR)/Components)
SCAD_PDK_INCLUDE = $(realpath $(PDK_ROOT_DIR)/scad_include)
PY_SCRIPTS_DIR = $(realpath $(PDK_ROOT_DIR)/py_scripts)

PYTHON3 ?= python3

OPENVAF ?= openvaf

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
GENERAL_SRC_DIR = $(COMPONENT_DIR)/serpentine \
									$(COMPONENT_DIR)/mixers \
									$(COMPONENT_DIR)/directional_reserviors \
									$(COMPONENT_DIR)/bidirectional_reserviors \
									$(COMPONENT_DIR)/inline_reserviors \
									$(COMPONENT_DIR)/valves \
									$(COMPONENT_DIR)/optical_measure \
									$(COMPONENT_DIR)/pumps

P_CELL_SRC_DIR = $(COMPONENT_DIR)/p_serpentine
#valves
#>>>>>>> master
## Verilog A targets

VERILOGA_BUILD_DIR = $(COMPONENT_DIR)/verilogA_build
NGSPICE_BUILD_DIR = $(COMPONENT_DIR)/verilogA_build_ng

VA_SRC_DIR = $(GENERAL_SRC_DIR) $(P_CELL_SRC_DIR) $(COMPONENT_DIR)/veriloga_objects
export VA_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*/*.va))
#export VA_FILES += $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*/*_flow.va))
#<<<<<<< HEAD
#export VAMS_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*.vams))
#=======
export VAMS_FILES = $(foreach VAMS_DIR, $(VA_SRC_DIR),$(wildcard $(VAMS_DIR)/*.vams))
#>>>>>>> origin/lib_0.0.2

LEF_SRC_DIR = $(GENERAL_SRC_DIR) $(COMPONENT_DIR)/capillary
LEF_FILES = $(foreach LEF_DIR, $(LEF_SRC_DIR),$(wildcard $(LEF_DIR)/*/*.lef))

SCAD_SRC_DIR= $(GENERAL_SRC_DIR) $(P_CELL_SRC_DIR) $(SCAD_PDK_INCLUDE)/scad_objects/interfaces
SCAD_BUILD_DIR = $(PDK_ROOT_DIR)/scad_lib
SCAD_FILES = $(foreach SCAD_DIR,$(SCAD_SRC_DIR),$(wildcard $(SCAD_DIR)/*/*.scad)) $(wildcard $(SCAD_PDK_INCLUDE)/scad_objects/*.scad)

# Noncomponent files in scad_include
# 	these will be copied in build_scad
SCAD_LIB_INCLUDES = $(wildcard $(SCAD_PDK_INCLUDE)/*.scad)

LEF_SCAD_EXTRACT = $(PDK_ROOT_DIR)/directional_reserviors \
									$(PDK_ROOT_DIR)/inline_reserviors \
									$(PDK_ROOT_DIR)/valves \
									$(PDK_ROOT_DIR)/pumps \
									$(PDK_ROOT_DIR)/optical_measure \
									$(COMPONENT_DIR)/capillary

SCAD_2_LEF_SRC = $(foreach SCAD_DIR,$(LEF_SCAD_EXTRACT),$(wildcard $(SCAD_DIR)/*/*.scad))

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

$(NGSPICE_BUILD_DIR):
	mkdir -p $@


export VA_COPIES = $(addprefix $(VERILOGA_BUILD_DIR)/,$(notdir $(VA_FILES)))
export VAMS_COPIES = $(addprefix $(VERILOGA_BUILD_DIR)/,$(notdir $(VAMS_FILES)))


export VA_NG_CONV = $(addprefix $(NGSPICE_BUILD_DIR)/,$(notdir $(VA_FILES)))
export VAMS_NG_CONV = $(addprefix $(NGSPICE_BUILD_DIR)/,$(notdir $(VAMS_FILES)))

export VA_COPIES_NG = $(addsuffix .xyce ,$(addprefix $(NGSPICE_BUILD_DIR)/,$(notdir $(VA_FILES))))
export VAMS_COPIES_NG = $(addsuffix .xyce, $(addprefix $(NGSPICE_BUILD_DIR)/,$(notdir $(VAMS_FILES))))

OSDI_FILES = $(patsubst %.va, %.osdi, $(VA_NG_CONV))
NG_LIB_FILES = $(patsubst %.osdi, %.lib, $(OSDI_FILES))

copy: $(VA_COPIES) $(VAMS_COPIES)

echo_va_cp:
	echo $(VA_COPIES)

$(VA_COPIES) &: $(VA_FILES) | $(VERILOGA_BUILD_DIR)
	cp $(VA_FILES) $(VERILOGA_BUILD_DIR)

$(VAMS_COPIES) &:  $(VAMS_FILES) | $(VERILOGA_BUILD_DIR)
	cp $(VAMS_FILES) $(VERILOGA_BUILD_DIR)

# -- NGSPICE

VPATH = $(dir $(VA_FILES)) $(dir $(VAMS_FILES))

echo_vpath:
	echo $(VPATH)

$(VA_COPIES_NG): $(NGSPICE_BUILD_DIR)/%.xyce : % | $(NGSPICE_BUILD_DIR)
	cp $^ $@

$(VAMS_COPIES_NG):  $(NGSPICE_BUILD_DIR)/%.xyce : % | $(NGSPICE_BUILD_DIR)
	cp $^ $@

copy_ng: $(VA_COPIES_NG) $(VAMS_COPIES_NG)

$(VA_NG_CONV): %: %.xyce
	sed 's/@(initial_instance)/\/\/@(initial_instance)/g' $^ > $@

$(VAMS_NG_CONV): %: %.xyce
	sed 's/continuous/continous/g' $^ > $@

conv_ng: $(VA_NG_CONV) $(VAMS_NG_CONV)

export XYCE_LIB = $(VERILOGA_BUILD_DIR)/$(MF_LIB).so

# Build using the buildxyceplugin script instead of Makefile
# $(XYCE_LIB): $(VA_COPIES) $(VAMS_COPIES)
# 	cd $(VERILOGA_BUILD_DIR) && $(BUILD_$(BUILD_COMMAND) -o $(MF_LIB) $(notdir $(VA_COPIES)) ./

$(VERILOGA_BUILD_DIR)/Makefile: $(COMPONENT_DIR)/xyce.mk
	cp $< $@

echo_va_copies_ng:
	echo $(VA_COPIES_NG)
	echo $(VAMS_COPIES_NG)

copy_ng_va: $(VA_COPIES_NG) $(VAMS_COPIES_NG)

echo_osdi:
	echo $(OSDI_FILES)

$(OSDI_FILES): %.osdi: %.va | $(VAMS_NG_CONV) $(VA_NG_CONV)
	$(OPENVAF) $^

NG_LIB_GEN_SCRIPT = $(PY_SCRIPTS_DIR)/mk_ng_lib_from_va.py

$(NG_LIB_FILES): %.lib: %.va | $(NGSPICE_BUILD_DIR)
	$(PYTHON3) $(NG_LIB_GEN_SCRIPT) --va_file $^

echo_ng_lib:
	echo $(NG_LIB_FILES)

#$(OPENVAF) $^

$(XYCE_LIB): $(VA_COPIES) $(VAMS_COPIES) $(VERILOGA_BUILD_DIR)/Makefile
	cd $(VERILOGA_BUILD_DIR) && make

build_va: $(XYCE_LIB)

build_osdi: $(OSDI_FILES)

build_ng_lib: $(NG_LIB_FILES)

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
export SC_LEF = $(COMPONENT_DIR)/$(KIT_NAME)_merged.lef
$(SC_LEF): $(LEF_FILES)
	echo "VERSION 5.7 ;" > $@
	echo 'BUSBITCHARS "[]" ;' >> $@
	echo 'DIVIDERCHAR "/" ;' >> $@
	cut -b 1- $^ >> $@
	echo "END LIBRARY" >> $@

# needs update
export TECH_LEF = $(PDK_ROOT_DIR)/distrib/1.0.0/h.r.3.3.tlef
export LIB_FILES = $(PDK_ROOT_DIR)/distrib/1.0.0/h.r.3.3.lib
export GDS_FILES = $(PDK_ROOT_DIR)/distrib/1.0.0/h.r.3.3.gds

SCAD_2_LEF_PY = $(PY_SCRIPTS_DIR)/extract_lef.py
SCAD_2_LEF_TRG = $(patsubst %.scad, %.lef, $(SCAD_2_LEF_SRC))

$(SCAD_2_LEF_TRG): %.lef: %.scad
	python3 $(SCAD_2_LEF_PY) --scad $< --ignore_no_lef_module -q

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
SCAD_COMPONENT_HEADER = $(PY_SCRIPTS_DIR)/scad_header.scad
CLEAN_SCAD_SCRIPT = $(PY_SCRIPTS_DIR)/cleanScadFile.py --scad_header $(SCAD_COMPONENT_HEADER)

$(SCAD_BUILD_DIR):
	mkdir -p $@

export SCAD_COMPONENT_LIBRARY = $(SCAD_BUILD_DIR)/$(KIT_NAME)_merged.scad
export SCAD_ROUTING_LIBRARY = $(PDK_ROOT_DIR)/distrib/1.0.0/routing_181220.scad
$(SCAD_COMPONENT_LIBRARY): $(SCAD_FILES) | $(SCAD_BUILD_DIR)
	cut -b 1- $^ | python3 $(CLEAN_SCAD_SCRIPT) --stream > $@
# sed 's/\r//g' > $@
# cut -b 1- $^ | sed '/^(use|px|layer|lpv)/d' >> $@

SCAD_USE_FILES = $(wildcard ./scad_use/*.scad)
SCAD_USE_BUILD = $(patsubst ./scad_use/%, ./scad_lib/%, $(SCAD_USE_FILES))
$(SCAD_USE_BUILD): $(SCAD_USE_FILES)
	cp $^ ./scad_lib

SCAD_LIB_INCLUDES_CP = $(patsubst $(SCAD_PDK_INCLUDE)/%, ./scad_lib/%, $(SCAD_LIB_INCLUDES))
$(SCAD_LIB_INCLUDES_CP): $(SCAD_LIB_INCLUDES)
	cp $^ ./scad_lib

cp_scad: $(SCAD_USE_BUILD) 

build_scad: $(SCAD_COMPONENT_LIBRARY) $(SCAD_USE_BUILD) $(SCAD_LIB_INCLUDES_CP)

install_scad_lib: build_scad
	python3 ./install_scad_library.py

# install the SCAD library to base system
install_scad_library:
	$(PYTHON3) ./install_scad_library.py
install_scad_library_unmerged:
	$(PYTHON3) ./install_scad_library.py --unmerged

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
#DOCKER_IMAGE = bgoenner/mfda_xyce:2.0.1

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

# if util exists
ifneq (,$(wildcard ./util.mk))
include util.mk
endif
