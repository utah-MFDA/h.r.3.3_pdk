
# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS 	= -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')


KIT_NAME = HR3.3

GENERAL_SRC_DIR = valves serpentine mixers

## Verilog A targets

VERILOGA_BUILD_DIR = verilogA_build
VERILOGA_BUILD_SRC = $(VERILOGA_BUILD_DIR)/src

#VA_SRC_DIR = valves serpentine pumps mixers veriloga_objects
VA_SRC_DIR  = $(GENERAL_SRC_DIR) veriloga_objects

LEF_SRC_DIR = $(GENERAL_SRC_DIR)

SCAD_SRC_DIR= $(GENERAL_SRC_DIR) scad_objects

MF_LIB = MFXyce

BUILD_COMMAND_LOC = /usr/local/xyce_dev/bin
BUILD_COMMAND     = $(BUILD_COMMAND_LOC)/buildxyceplugin.sh -o


$(VERILOGA_BUILD_DIR)/lib/$(MF_LIB).so: $(VA_SRC_DIR)/*/*.va veriloga_objects/*.vams
	mkdir -p $(VERILOGA_BUILD_DIR)/lib
	mkdir -p $(VERILOGA_BUILD_SRC)

	cp veriloga_objects/$(MF_LIB) $(VERILOGA_BUILD_SRC)
	cp veriloga_objects/*.vams $(VERILOGA_BUILD_SRC)
	cp $(foreach VA_SRC_DIR, $(VA_SRC_DIR), $(VA_SRC_DIR)/*/*.va) $(VERILOGA_BUILD_SRC)

	cd $(VERILOGA_BUILD_SRC) && $(BUILD_COMMAND) $(MF_LIB) *.va ./ && \
	rm *.va && rm *.vams && rm $(MF_LIB) && \
	mv *.so ./../lib

DOCKER_IMAGE = bgoenner/mfda_xyce

DOCKER_LOCAL_COMP_DIR = ./

DOCKER_REMOTE_COMP_DIR = /mfda_simulation/local/Components
DOCKER_REMOTE_VA_BUILD =  $(DOCKER_REMOTE_COMP_DIR)_tmp

make_va_remote:
	mkdir -p $(VERILOGA_BUILD_DIR)/lib
	docker run \
	-a stdout \
	-v $(DOCKER_LOCAL_COMP_DIR):$(DOCKER_REMOTE_COMP_DIR) \
	-w $(DOCKER_REMOTE_COMP_DIR) \
	--entrypoint='' \
	--rm \
	$(DOCKER_IMAGE) make build_remote

MERGE_LEF = $(KIT_NAME)_merged.lef
make_lef:
	rm -f $(MERGE_LEF)
	touch $(MERGE_LEF)
	#cat $(foreach LEF_SRC_DIR, $(LEF_SRC_DIR), $(LEF_SRC_DIR)/*/*.lef) > $(KIT_NAME)_merged.lef
	find $(LEF_SRC_DIR) -type f -name '*.lef' -exec cut -b 1- {} + >> $(MERGE_LEF)

MERGE_SCAD = $(KIT_NAME)_merged.scad
make_scad:
	rm -f $(MERGE_SCAD)
	touch $(MERGE_SCAD)
	find $(SCAD_SRC_DIR) -type f -name '*.scad' -exec cut -b 1- {} + >> $(MERGE_SCAD)


check_library:
	python3 validateComponents.py --component_dir $(GENERAL_SRC_DIR)


build_va_remote_tmp:
	cp -r $(DOCKER_REMOTE_COMP_DIR) $(DOCKER_REMOTE_VA_BUILD)
	cd $(DOCKER_REMOTE_VA_BUILD) && make make_default
	cp $(DOCKER_REMOTE_COMP_DIR)_tmp/$(VERILOGA_BUILD_DIR)/lib/lib$(MF_LIB).so $(VERILOGA_BUILD_DIR)/lib/

build_remote:
	cd $(DOCKER_REMOTE_COMP_DIR) && make make_va_default

clean_va_build:
	rm -r $(VERILOGA_BUILD_SRC)

make_va_default: $(VERILOGA_BUILD_DIR)/lib/$(MF_LIB).so