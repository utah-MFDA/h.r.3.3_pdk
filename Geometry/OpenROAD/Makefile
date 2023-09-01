
SHELL 	 	= /bin/bash
.SHELLFLAGS = -o pipefail -c

#default target when invoking without specific target
.DEFAULT_GOAL := all

PLATFORM = mfda_30px_m

LOCAL_OR_MFDA_DIR = ./platforms/$(PLATFORM)

COMBINED_FILE = $(LOCAL_OR_MFDA_DIR)/$(PLATFORM)_combined.lef

#docker information
DOCKER_CONTAINER = epic_boyd
DOCKER_LEF_DIR = /place_and_route/pnr/openroad_flow/platforms/$(PLATFORM)/lef


combine_files:
	rm -f $(COMBINED_FILE)
	touch $(COMBINED_FILE)

	echo "VERSION 5.7 ;" 		>> $(COMBINED_FILE) 
	echo "BUSBITCHARS \"[]\" ;" >> $(COMBINED_FILE)
	echo "DIVIDERCHAR \"/\" ;"  >> $(COMBINED_FILE)
	echo " " >> $(COMBINED_FILE)
	echo "##### Library $(PLATFORM)" >> $(COMBINED_FILE)

	find $(LOCAL_OR_MFDA_DIR)/lef -type f -name '*.lef' -exec cut -b 1- {} + >>$(COMBINED_FILE)
	
	echo " " >> $(COMBINED_FILE)
	echo "END LIBRARY" >> $(COMBINED_FILE)

import_lef:
	docker cp $(COMBINED_FILE) $(DOCKER_CONTAINER):$(DOCKER_LEF_DIR)/$(PLATFORM)_merged.lef

# cat *.lef >> $(LOCAL_OR_MFDA_DIR)/combined.lef

all: combine_files import_lef