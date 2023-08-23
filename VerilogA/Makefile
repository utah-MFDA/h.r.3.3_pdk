
# Shell setup for make
SHELL		= /bin/bash
.SHELLFLAGS	= -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

ELIBRARY_DIR=./Elibrary
MFLIBRARY_DIR=./MFlibrary


build_elibrary:
	cd $(ELIBRARY_DIR) && make


all: build_elibrary