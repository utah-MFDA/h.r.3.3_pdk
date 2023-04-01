

# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS = -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

LIBRARY_DIR = ./standardCells ./pCells ./hardware
MERGED_FILE = stdCells_merged.va



merge_std_cells: $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va)  

	touch $(MERGED_FILE)
	wc -c $(MERGED_FILE)

	#echo "//Day merged $(DATE)\n" > $(MERGED_FILE)  
	
	cat $(foreach LIBRARY_DIR, $(LIBRARY_DIR), $(LIBRARY_DIR)/*.va) > $(MERGED_FILE)


all: merge_std_cells