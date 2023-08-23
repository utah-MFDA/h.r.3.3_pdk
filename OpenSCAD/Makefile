
SHELL 	 	= /bin/bash
.SHELLFLAGS = -o pipefail -c

#default target when invoking without specific target
.DEFAULT_GOAL := all

PLATFORM = mfda_30px

LOCAL_OR_MFDA_DIR = ./platforms/$(PLATFORM)

COMBINED_FILE = $(LOCAL_OR_MFDA_DIR)_combined.lef

#docker information
DOCKER_CONTAINER = intelligent_torvalds
DOCKER_SCAD_DIR = /place_and_route/pnr/scad_flow/scad


combine_files:
	rm -f $(COMBINED_FILE)
	touch $(COMBINED_FILE)

	echo "VERSION 5.7 ;" 		>> $(COMBINED_FILE) 
	echo "BUSBITCHARS \"[]\" ;" >> $(COMBINED_FILE)
	echo "DIVIDERCHAR \"/\" ;"  >> $(COMBINED_FILE)
	echo " " >> $(COMBINED_FILE)

	find $(LOCAL_OR_MFDA_DIR) -type f -name '*.lef' -exec cat {} + >>$(COMBINED_FILE)
	
	echo " " >> $(COMBINED_FILE)
	echo "END LIBRARY" >> $(COMBINED_FILE)

import_lef:
	docker cp $(COMBINED_FILE) $(DOCKER_CONTAINER):$(DOCKER_LEF_DIR)/$(PLATFORM)_merged.lef

# cat *.lef >> $(LOCAL_OR_MFDA_DIR)/combined.lef

all: combine_files