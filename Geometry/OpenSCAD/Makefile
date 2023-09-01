
SHELL 	 	= /bin/bash
.SHELLFLAGS = -o pipefail -c

#default target when invoking without specific target
.DEFAULT_GOAL := all

#PLATFORM = mfda_30px
PLATFORM = mfda_30px_m

LOCAL_SCAD_MFDA_DIR = ./platforms/$(PLATFORM)

COMBINED_FILE  = $(LOCAL_SCAD_MFDA_DIR)/$(PLATFORM)_combined.scad
COMP_JSON_FILE = $(LOCAL_SCAD_MFDA_DIR)/component_def.json

#docker information
#DOCKER_CONTAINER = intelligent_torvalds
DOCKER_CONTAINER = epic_boyd
DOCKER_SCAD_DIR = /place_and_route/pnr/scad_flow/scad


combine_files:
	rm -f $(COMBINED_FILE)
	touch $(COMBINED_FILE)

	#echo "VERSION 5.7 ;" 		>> $(COMBINED_FILE) 
	#echo "BUSBITCHARS \"[]\" ;" >> $(COMBINED_FILE)
	echo "// ^^^ routing and px/layer defines are added at runtime ^^^ //"  >> $(COMBINED_FILE)
	echo " " >> $(COMBINED_FILE)

	find $(LOCAL_SCAD_MFDA_DIR)/scad -type f -name '*.scad' -exec cut -b 1- {} + >>$(COMBINED_FILE)
	
	echo " " >> $(COMBINED_FILE)
	#echo "END LIBRARY" >> $(COMBINED_FILE)

	python3 cleanFile.py --platform $(PLATFORM)

import_scad:
	docker cp $(COMBINED_FILE) $(DOCKER_CONTAINER):$(DOCKER_SCAD_DIR)/$(PLATFORM)/$(PLATFORM)_components_merged.scad
import_json:
	docker cp $(COMP_JSON_FILE) $(DOCKER_CONTAINER):$(DOCKER_SCAD_DIR)/$(PLATFORM)/component_def.json

# cat *.lef >> $(LOCAL_OR_MFDA_DIR)/combined.lef

all: combine_files import_scad