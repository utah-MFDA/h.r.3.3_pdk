

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

XYCE_STD_LIB      = $(XYCE_LIBRARY_DIR)/std_lib
XYCE_STD_LIB_B    = $(XYCE_STD_LIB)/build
STD_LIB_NAME      = stdComponents

XYCE_HARDWARE_LIB  =$(XYCE_LIBRARY_DIR)/hardware
XYCE_HARDWARE_LIB_B=$(XYCE_HARDWARE_LIB)/build
HARDWARE_LIB_NAME  = hardware

XYCE_PCELL_LIB    =$(XYCE_LIBRARY_DIR)/pCells
XYCE_PCELL_LIB_B  =$(XYCE_PCELL_LIB)/build
PCELL_LIB_NAME    = pCells

# --------------

#ABS_LIB_FILE = $(shell pwd $(XYCE_STD_LIB)/libstdComponents.so) $(shell pwd $(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so) $(shell pwd $(XYCE_PCELL_LIB)/lib$(PCELL_LIB_NAME).so)
WD = $(shell pwd)

ELIB_XYCE_COMM    = Xyce --plugin $(WD)/$(XYCE_STD_LIB)/lib$(STD_LIB_NAME).so,$(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so,$(WD)/$(XYCE_LIBRARY_DIR)/lib$(PCELL_LIB_NAME).so $1


## build xyce libraries

$(XYCE_STD_LIB)/lib$(STD_LIB_NAME).so: $(STANDARD_VA_DIR)/*.va
	mkdir -p $(XYCE_STD_LIB_B)
	rm -rf $(XYCE_STD_LIB_B)/*.va
	
	cp $(STANDARD_VA_DIR)/*.va $(XYCE_STD_LIB_B)
	cp $(STANDARD_VA_DIR)/$(STD_LIB_NAME) $(XYCE_STD_LIB_B)
	
	cd $(XYCE_STD_LIB_B) && $(BUILD_COMMAND) $(STD_LIB_NAME) *.va ./ && rm *.va && mv *.so ./../

$(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so: $(HARDWARE_VA_DIR)/*.va
	mkdir -p $(XYCE_HARDWARE_LIB_B)
	rm -rf $(XYCE_HARDWARE_LIB_B)/*.va
	
	cp $(HARDWARE_VA_DIR)/*.va $(XYCE_HARDWARE_LIB_B)
	cp $(HARDWARE_VA_DIR)/$(HARDWARE_LIB_NAME) $(XYCE_HARDWARE_LIB_B)

	cd $(XYCE_HARDWARE_LIB_B) && $(BUILD_COMMAND) $(HARDWARE_LIB_NAME) *.va ./ && rm *.va && mv *.so ./../
	
$(XYCE_PCELL_LIB)/lib$(PCELL_LIB_NAME).so: $(PCELL_VA_DIR)/*.va
	mkdir -p $(XYCE_PCELL_LIB_B)
	rm -rf $(XYCE_PCELL_LIB_B)/*.va
	ls $(XYCE_PCELL_LIB_B) | grep *.va

	cp $(PCELL_VA_DIR)/*.va $(XYCE_PCELL_LIB_B)
	cp $(PCELL_VA_DIR)/$(PCELL_LIB_NAME) $(XYCE_PCELL_LIB_B)
	
	cd $(XYCE_PCELL_LIB_B) && $(BUILD_COMMAND) $(PCELL_LIB_NAME) *.va ./ && rm *.va && mv *.so ./../

ElibCommXyce:
	echo $(ELIB_XYCE_COMM)
	rm -f EMFXyce
	touch EMFXyce
	echo "$(ELIB_XYCE_COMM)" >> EMFXyce

mk_xyce: $(XYCE_STD_LIB)/lib$(STD_LIB_NAME).so $(XYCE_HARDWARE_LIB)/lib$(HARDWARE_LIB_NAME).so $(XYCE_PCELL_LIB)/lib$(PCELL_LIB_NAME).so ElibCommXyce

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
