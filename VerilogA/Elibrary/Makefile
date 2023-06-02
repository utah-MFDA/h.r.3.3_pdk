

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS = -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

LIBRARY_DIR = ./standardCells ./pCells ./hardware
MERGED_FILE = stdCells_merged.va

HEADER_FILE = ./mfda_header.va

gen_merge_file:
	touch $(MERGED_FILE)
	wc -c $(MERGED_FILE)

cat_header_file:
	cat $(HEADER_FILE) > $(MERGED_FILE)


merge_std_cells: $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va)  	
	cat $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va) >> $(MERGED_FILE)


all: gen_merge_file cat_header_file merge_std_cells