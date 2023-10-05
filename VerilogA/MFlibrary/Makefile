

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS = -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

LIBRARY_DIR = ./standardCells ./pCells ./hardware
MERGED_FILE = stdCells_merged.va

HEADER_FILE = ./mfda_header

BUILD_COMMAND_LOC = /usr/local/xyce_dev/bin
BUILD_COMMAND= $(BUILD_COMMAND_LOC)/buildxyceplugin.sh -o 

## library definitions
STANDARD_VA_DIR = standardCells
HARDWARE_VA_DIR = hardware
PCELL_VA_DIR    = pCells

XYCE_LIBRARY_DIR = xyce_lib

XYCE_MFLIBRARY_LIB   = $(XYCE_LIBRARY_DIR)/MFlibrary
XYCE_MFLIBRARY_LIB_B = $(XYCE_MFLIBRARY_LIB)/build
MFLIBRARY_NAME       = MFlibrary

# --------------

#ABS_LIB_FILE = $(shell pwd $(XYCE_STD_LIB)/libstdComponents.so) $(shell pwd $(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so) $(shell pwd $(XYCE_PCELL_LIB)/lib$(PCELL_LIB_NAME).so)
WD = $(shell pwd)

ELIB_XYCE_COMM    = Xyce --plugin $(WD)/$(XYCE_STD_LIB)/lib$(STD_LIB_NAME).so,$(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so,$(WD)/$(XYCE_LIBRARY_DIR)/lib$(PCELL_LIB_NAME).so $1


## build xyce libraries

# copies all VA files
$(XYCE_MFLIBRARY_LIB)/lib$(MFLIBRARY_NAME).so: $(PCELL_VA_DIR)/*.va $(HARDWARE_VA_DIR)/*.va $(STANDARD_VA_DIR)/*.va nature_fluid_dynamics.vams
	mkdir -p $(XYCE_MFLIBRARY_LIB_B)
	rm -f $(XYCE_MFLIBRARY_LIB_B)/*.va

	cp $(PCELL_VA_DIR)/*.va $(XYCE_MFLIBRARY_LIB_B)
	cp $(HARDWARE_VA_DIR)/*.va $(XYCE_MFLIBRARY_LIB_B)
	cp $(STANDARD_VA_DIR)/*.va $(XYCE_MFLIBRARY_LIB_B)
	cp nature_fluid_dynamics.vams $(XYCE_MFLIBRARY_LIB_B)

	cp ./$(MFLIBRARY_NAME) $(XYCE_MFLIBRARY_LIB_B)

	cd $(XYCE_MFLIBRARY_LIB_B) && $(BUILD_COMMAND) $(MFLIBRARY_NAME) *.va ./ && rm *.va && mv *.so ./../


ElibCommXyce:
	echo $(ELIB_XYCE_COMM)
	rm -f EMFXyce
	touch EMFXyce
	echo "$(ELIB_XYCE_COMM)" >> EMFXyce

#mk_xyce: $(XYCE_STD_LIB)/lib$(STD_LIB_NAME).so $(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so $(XYCE_PCELL_LIB)/lib$(PCELL_LIB_NAME).so ElibCommXyce

mk_xyce: $(XYCE_MFLIBRARY_LIB)/lib$(MFLIBRARY_NAME).so

## HSPICE merge commands
gen_merge_file:
	touch $(MERGED_FILE)
	wc -c $(MERGED_FILE)

cat_header_file:
	cat $(HEADER_FILE) > $(MERGED_FILE)


merge_std_cells: $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va)  	
	cat $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va) >> $(MERGED_FILE)


clean_xyce_libs:
	rm -rf $(XYCE_LIBRARY_DIR)


#all: gen_merge_file cat_header_file merge_std_cells
all: mk_xyce
