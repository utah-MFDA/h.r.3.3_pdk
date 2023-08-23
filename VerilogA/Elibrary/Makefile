

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS = -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

LIBRARY_DIR = ./standardCells ./pCells ./hardware
MERGED_FILE = stdCells_merged.va

HEADER_FILE = ./mfda_header

## library definitions
STANDARD_VA_DIR = ./standardCells
HARDWARE_VA_DIR = ./hardware

XYCE_LIBRARY_DIR = ./xyce_lib

XYCE_STD_LIB     = $(XYCE_LIBRARY_DIR)/std_lib
XYCE_STD_LIB_B   = $(XYCE_STD_LIB)/build

XYCE_HARDWARE_LIB= $(XYCE_LIBRARY_DIR)/hardware
XYCE_HARDWARE_LIB_B=$(XYCE_HARDWARE_LIB)/build

## preperation for xyce

build_standard_components: $(STANDARD_VA_DIR )
	mkdir -p $(XYCE_STD_LIB_B)
	rm -rf $(XKYCE_STD_LIB_B)/*.va
	cp $(STANDARD_VA_DIR)/*.va $(XYCE_STD_LIB_B)
	cd $(XYCE_STD_LIB_B) && buildxyceplugin.sh *.va ./ && rm *.va && mv *.so ./../
	#cd $(XYCE_LIBRARY_DIR) && buildxyceplugin.sh *.va ./ && rm *.va

build_hardware_components: $(HARDWARE_VA_DIR)
	mkdir -p $(XYCE_HARDWARE_LIB_B)
	rm -rf $(XYCE_HARDWARE_LIB_B)/*.va
	cp $(HARDWARE_VA_DIR)/*.va $(XYCE_HARDWARE_LIB_B)
	cd $(XYCE_HARDWARE_LIB_B) && buildxyceplugin.sh *.va ./ && rm *.va && mv *.so ./../
	

mk_xyce: build_standard_components build_hardware_components

## HSPICE merge commands
gen_merge_file:
	touch $(MERGED_FILE)
	wc -c $(MERGED_FILE)

cat_header_file:
	cat $(HEADER_FILE) > $(MERGED_FILE)


merge_std_cells: $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va)  	
	cat $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va) >> $(MERGED_FILE)


#all: gen_merge_file cat_header_file merge_std_cells

