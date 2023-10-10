
#Shell setup for make
SHELL         = /bin/bash
.SHELLFLAGS   = -o pipefail -c



## ---- General ----

#LOCAL_MACHINE_LIB =./../component_library/
# for defined internally in library
LOCAL_MACHINE_LIB =./../..

PNR_PLATFORM := mfda_30px

## ------- OpenROAD variables ---- 
##
## -- PNR --
##

PNR_DOCKER_CONTAINER    = epic_boyd
PNR_DOCKER_BASE_LOC   = /place_and_route/pnr

# within docker container
PNR_DESIGN_LOC = $(PNR_DOCKER_BASE_LOC)/openroad_flow/platforms/$(PNR_PLATFORM)
PNR_LEF_DIR    = $(PNR_DESIGN_LOC)/lef

OR_LOCAL_LEF_DIR = $(LOCAL_MACHINE_LIB)/OpenROAD/platforms/

## ------- XYCE variables --------
##
##  -- simulation --
##

X_DOCKER_CONTAINER       =vibrant_clarke
X_DOCKER_UPLOAD_LOC      =/mfda_simulation/local
#X_DOCKER_REMOTE_LOC      =/mfda_simulation/component_library


LOCAL_VA_LIB_DIR        =$(LOCAL_MACHINE_LIB)/VerilogA

X_LOCAL_DOCKER_MAKE_LOC     =$(X_DOCKER_UPLOAD_LOC)/VerilogA
X_LOCAL_DOCKER_TEST_DIR     =$(X_DOCKER_UPLOAD_LOC)/VerilogA/xyce_testing

ELIB_TEST_STD_CELL        =$(X_LOCAL_DOCKER_TEST_DIR)/ElibraryTesting/stdcellTesting/

DIFF_TEST_1 = sh ./xyceLocal.sh diffMix_test1.cir

TEST_COMM = $(DIFF_TEST_1)

## XYCE targets -------------------------------------------------

build_xyce_local: copy_to_docker build_local_docker

copy_to_docker: $(LOCAL_VA_LIB_DIR) 
	docker cp $(LOCAL_VA_LIB_DIR) $(X_DOCKER_CONTAINER):$(X_DOCKER_UPLOAD_LOC)

build_local_docker:
	docker exec -w $(X_LOCAL_DOCKER_MAKE_LOC) $(X_DOCKER_CONTAINER) make 

get_xycebuildlog_Elib:
	docker cp $(X_DOCKER_CONTAINER):$(X_LOCAL_DOCKER_MAKE_LOC)/Elibrary/xyce_lib/Elibrary/build/buildxyceplugin.log $(LOCAL_VA_LIB_DIR)

get_xycebuildlog_MFlib:
	docker cp $(X_DOCKER_CONTAINER):$(X_LOCAL_DOCKER_MAKE_LOC)/MFlibrary/xyce_lib/MFlibrary/build/buildxyceplugin.log $(LOCAL_VA_LIB_DIR)

run_test: copy_to_docker
	docker exec -w $(ELIB_TEST_STD_CELL) $(X_DOCKER_CONTAINER) $(TEST_COMM)


#build_from_remote:
# git pull

# run make file

build_OR_local:

upload_OR_lef:
	docker cp $(OR_LOCAL_LEF_DIR)/$(PNR_PLATFORM)_combined.lef $(PNR_DOCKER_CONTAINER):$(PNR_LEF_DIR)

all: