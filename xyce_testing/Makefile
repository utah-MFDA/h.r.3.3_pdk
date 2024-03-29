
define \n


endef


DOCKER_IMAGE = bgoenner/mfda_xyce:latest

REMOTE_BUILD_LOC = /mfda_simulation/local/lib
LOCAL_BUILD_LOC  = ./../Components/verilogA_build/lib

REMOTE_TEST_DIR = /mfda_simulations/local/xyce_testing
LOCAL_TEST_DIR  = ./


XYCE = /usr/local/xyce_dev/bin/Xyce

MF_LIB = libMFXyce.so
#

XYCE_RUN = $(XYCE) -plugin $(REMOTE_BUILD_LOC)/$(MF_LIB)

init_va:
	docker pull $(DOCKER_IMAGE)

make_docker:
	docker run \
	-v $(LOCAL_TEST_DIR):$(REMOTE_TEST_DIR):z \
	-v $(LOCAL_BUILD_LOC):$(REMOTE_BUILD_LOC) \
	-w $(REMOTE_TEST_DIR) \
	-a stdout \
	--entrypoint='' \
	$(DOCKER_IMAGE) make docker_run_tests 

run_tests_remote: make_docker

TESTING_TARGET = MFlibrary_testing
STD_CELL_DIR   = stdcellTesting/serpentine stdcellTesting/mixer stdcellTesting/valves stdcellTesting/membrane_cap
TESTING_DIR    = pCellTesting pumpTesting $(STD_CELL_DIR)

test_files  = 

docker_run_tests:
	mkdir -p $(foreach TEST_DIR, $(TESTING_DIR), \
		./$(TESTING_TARGET)/$(TEST_DIR)/results \
		./$(TESTING_TARGET)/$(TEST_DIR)/logs)

	$(foreach TEST_DIR, $(TESTING_DIR), \
	    $(foreach CIR_FILE, $(wildcard ./$(TESTING_TARGET)/$(TEST_DIR)/*.cir), \
		    $(XYCE_RUN) $(CIR_FILE) > $(CIR_FILE).log ${\n}))

	$(foreach TEST_DIR, $(TESTING_DIR), \
		mv ./$(TESTING_TARGET)/$(TEST_DIR)/*.prn ./$(TESTING_TARGET)/$(TEST_DIR)/results && \
		mv ./$(TESTING_TARGET)/$(TEST_DIR)/*.log ./$(TESTING_TARGET)/$(TEST_DIR)/logs${\n})

#$(XYCE_RUN) $(CIR_FILE).cir > $(CIR_FILE).log ${\n}))

# initial value to test is INFILE was defined
INFILE ?= template

LIBRARY_TEST ?= MFlibrary_testing

TEST = stdcellTesting/membrane_cap/mem_cap_test_1_3.cir

run_single_test_mf:
	docker run \
	-v $(LOCAL_TEST_DIR):$(REMOTE_TEST_DIR):z \
	-v $(LOCAL_BUILD_LOC):$(REMOTE_BUILD_LOC) \
	-w $(REMOTE_TEST_DIR) \
	-a stdout \
	--entrypoint='' \
	$(DOCKER_IMAGE) make docker_run_single_test_mf INFILE=$(INFILE)

docker_run_single_test_mf:
	if [ $(INFILE) != template ]; then \
		$(XYCE_RUN) ./$(LIBRARY_TEST)/$(INFILE) > ./$(LIBRARY_TEST)/$(INFILE).log \
	else \
		echo INFILE not defined; \
	fi;

COMPONENT_LIB_MAKE = ./../Components

rebuild_xyce_library:
	cd $(COMPONENT_LIB_MAKE) && make make_va_remote

