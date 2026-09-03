PDK_ROOT_DIR ?= $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

BUILD_DIR ?= $(PDK_ROOT_DIR)/build
COMPONENT_DIR = $(realpath $(PDK_ROOT_DIR)/Components)
PY_SCRIPTS_DIR = $(realpath $(PDK_ROOT_DIR)/scripts)

PYTHON3 ?= python3

OPENVAF ?= openvaf

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS 	= -o pipefail -c

BUILD_COMMAND = buildxyceplugin -d

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

all: build_va build_lef build_scad build_kicad
DATE = $(date '+%Y-%m-%d')

KIT_NAME = h.r.3.3

GENERAL_SRC_DIR = $(COMPONENT_DIR)/serpentine \
									$(COMPONENT_DIR)/mixers \
									$(COMPONENT_DIR)/directional_reserviors \
									$(COMPONENT_DIR)/bidirectional_reserviors \
									$(COMPONENT_DIR)/inline_reserviors \
									$(COMPONENT_DIR)/valves \
									$(COMPONENT_DIR)/optical_measure \
									$(COMPONENT_DIR)/pumps \
									$(COMPONENT_DIR)/interface

P_CELL_SRC_DIR = $(COMPONENT_DIR)/p_serpentine
## Verilog A targets

VERILOGA_BUILD_DIR = $(BUILD_DIR)/verilogA_build
NGSPICE_BUILD_DIR = $(BUILD_DIR)/verilogA_build_ng

VA_SRC_DIR = $(GENERAL_SRC_DIR) $(P_CELL_SRC_DIR) $(COMPONENT_DIR)/veriloga_objects
export VA_FILES = $(foreach VA_DIR, $(VA_SRC_DIR),$(wildcard $(VA_DIR)/*/*.va))
export VAMS_FILES = $(foreach VAMS_DIR, $(VA_SRC_DIR),$(wildcard $(VAMS_DIR)/*.vams))

LEF_FILES = $(foreach LEF_DIR, $(GENERAL_SRC_DIR),$(wildcard $(LEF_DIR)/*/*.lef))
SCAD_BUILD_DIR = $(BUILD_DIR)/scad_libraries/$(KIT_NAME)
SCAD_FILES = $(foreach DIR,${GENERAL_SRC_DIR},$(wildcard ${DIR}/*/*.scad))
SCAD_TARGETS = $(patsubst ${COMPONENT_DIR}/%.scad,$(SCAD_BUILD_DIR)/%.scad,${SCAD_FILES})
SCAD_NAMES = $(patsubst ${COMPONENT_DIR}/%.scad,include <%.scad>,${SCAD_FILES})
KICAD_FOOTPRINT_FILES = $(patsubst ${COMPONENT_DIR}/%.lef,$(BUILD_DIR)/h.r.3.3.pretty/%.kicad_mod,${LEF_FILES})

export MF_LIB = MFXyce

.PHONY: clean_all clean_va clean_scad clean_lef clean_kicad build_va build_scad build_lef build_kicad
clean: clean_all
clean_all: clean_va clean_scad clean_lef clean_kicad
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

$(VA_COPIES) &: $(VA_FILES) | $(VERILOGA_BUILD_DIR)
	cp $(VA_FILES) $(VERILOGA_BUILD_DIR)

$(VAMS_COPIES) &:  $(VAMS_FILES) | $(VERILOGA_BUILD_DIR)
	cp $(VAMS_FILES) $(VERILOGA_BUILD_DIR)

# -- NGSPICE

VPATH = $(dir $(VA_FILES)) $(dir $(VAMS_FILES))


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


copy_ng_va: $(VA_COPIES_NG) $(VAMS_COPIES_NG)

$(OSDI_FILES): %.osdi: %.va | $(VAMS_NG_CONV) $(VA_NG_CONV)
	$(OPENVAF) $^

NG_LIB_GEN_SCRIPT = $(PY_SCRIPTS_DIR)/mk_ng_lib_from_va.py

$(NG_LIB_FILES): %.lib: %.va | $(NGSPICE_BUILD_DIR)
	$(PYTHON3) $(NG_LIB_GEN_SCRIPT) --va_file $^


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
export SC_LEF = $(BUILD_DIR)/$(KIT_NAME)_merged.lef

$(SC_LEF): $(LEF_FILES) | $(BUILD_DIR)
	echo "VERSION 5.7 ;" > $@
	echo 'BUSBITCHARS "[]" ;' >> $@
	echo 'DIVIDERCHAR "/" ;' >> $@
	cut -b 1- $^ >> $@
	echo "END LIBRARY" >> $@

# needs update
export TECH_LEF = $(BUILD_DIR)/h.r.3.3.tlef
export LIB_FILES = $(BUILD_DIR)/h.r.3.3.lib
export GDS_FILES = $(BUILD_DIR)/h.r.3.3.gds


%.lef.scad: %.lef
	${PYTHON3} ./scripts/render_lef_scad.py --tlef ${TECH_LEF} --lef $< --output $@


${TECH_LEF}:
	${PYTHON3} ./scripts/generators/generate_tlef.py 10 6 > $@

clean_lef:
	rm -f $(SC_LEF)

build_lef: $(SC_LEF) $(TECH_LEF)

################################################################
#  ____   ____    _    ____
# / ___| / ___|  / \  |  _ \
# \___ \| |     / _ \ | | | |
#  ___) | |___ / ___ \| |_| |
# |____/ \____/_/   \_\____/
#
################################################################
${SCAD_BUILD_DIR}:
	mkdir -p $@

$(BUILD_DIR)/scad_libraries:
	mkdir -p $@

$(SCAD_BUILD_DIR)/components.scad: ${SCAD_TARGETS} | $(SCAD_BUILD_DIR)
	echo "${SCAD_NAMES}" | sed 's/> />\n/g' > $@

$(SCAD_BUILD_DIR)/%.scad: ${COMPONENT_DIR}/%.scad | $(SCAD_BUILD_DIR)
	mkdir -p ${@D}
	cp -r $< $@

$(BUILD_DIR)/scad_libraries/openmfda: openscad_libraries/openmfda | $(BUILD_DIR)/scad_libraries
	cp -r $< $@

build_scad: $(SCAD_BUILD_DIR)/components.scad $(BUILD_DIR)/scad_libraries/openmfda ${SCAD_TARGETS}

clean_scad:
	rm -rf $(SCAD_BUILD_DIR)

install_scad_lib: build_scad
	python3 ./install_scad_library.py

# install the SCAD library to base system
install_scad_library:
	$(PYTHON3) ./install_scad_library.py
install_scad_library_unmerged:
	$(PYTHON3) ./install_scad_library.py --unmerged

clean_scad:
	rm -f $(SCAD_COMPONENT_LIBRARY)

################################################################
#  _  ___  ____    _    ____
# | |/ (_)/ ___|  / \  |  _ \
# | ' /| | |     / _ \ | | | |
# | . \| | |___ / ___ \| |_| |
# |_|\_\_|\____/_/   \_\____/
################################################################

$(BUILD_DIR)/h.r.3.3.pretty: ${KICAD_FOOTPRINT_FILES}
	mkdir -p $@
	cp $^ $@

$(BUILD_DIR)/h.r.3.3.pretty/%.kicad_mod: Components/%.kicad_mod
	@ mkdir -p ${@D}
	cp $< $@

# Previous rule should hold priority if a kicad_mod file is explicitly defined
$(BUILD_DIR)/h.r.3.3.pretty/%.kicad_mod: Components/%.lef ${TECH_LEF}
	@ mkdir -p ${@D}
	${PYTHON3} ./scripts/lef_to_footprint.py --tlef ${TECH_LEF} --lef $< --output ${@D}

$(BUILD_DIR)/mfda.kicad_sym: Components/kicad_symbols/mfda.kicad_sym
	cp $< $@

$(BUILD_DIR)/mfda_spice.kicad_sym: Components/kicad_symbols/mfda_spice.kicad_sym
	cp $< $@

build_kicad: $(BUILD_DIR)/h.r.3.3.pretty $(BUILD_DIR)/mfda_spice.kicad_sym $(BUILD_DIR)/mfda.kicad_sym
debug:
	@ echo ${KICAD_FOOTPRINT_FILES} | tr ' ' '\n'

clean_kicad:
	rm -rf $(BUILD_DIR)/h.r.3.3.pretty
	rm -rf $(BUILD_DIR)/mfda_spice.kicad_sym
	rm -rf $(BUILD_DIR)/mfda.kicad_sym
################################################################
#  ____                      _
# |  _ \ ___ _ __ ___   ___ | |_ ___
# | |_) / _ \ '_ ` _ \ / _ \| __/ _ \
# |  _ <  __/ | | | | | (_) | ||  __/
# |_| \_\___|_| |_| |_|\___/ \__\___|
#
################################################################

DOCKER_LOCAL_COMP_DIR = ./

DOCKER_REMOTE_COMP_DIR = /mfda_simulation/local/${COMPONENT_DIR}
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
