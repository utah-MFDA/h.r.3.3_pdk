


DOCKER_IMAGE = bgoenner/mfda_xyce:latest

REMOTE_BUILD_LOC = /mfda_simulation/local/Components
LOCAL_BUILD_LOC  = ./Components

#

remote_build:
	docker run -v ./test_dir:/mfda_simulation/local/test_dir:z -dit $(DOCKER_IMAGE) 