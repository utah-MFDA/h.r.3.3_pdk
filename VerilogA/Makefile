
# Shell setup for make
SHELL		= /bin/bash
.SHELLFLAGS	= -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')

ELIBRARY_DIR=./Elibrary
MFLIBRARY_DIR=./MFlibrary

MAKE_ARGS=mk_xyce

DIFF_TEST_DIR=xyce_testing/ElibraryTesting/stdcellTesting/
DIFF_TEST_COMM= ./xyceLocal.sh diffMix_test1.cir

build_elibrary:
	cd $(ELIBRARY_DIR) && make $(MAKE_ARGS)

run_diff_test1: build_elibrary
	cd $(DIFF_TEST_DIR) && $(DIFF_TEST_COMM)

run_diff_test2: build_elibrary
	cd $(DIFF_TEST_DIR) && ./xyceLocal.sh diffMix_test2.cir



all: build_elibrary
