
# Shell Setup for make
SHELL		= /bin/bash
.SHELLFLAGS = -o pipefail -c

# Default target when invoking without a specific target
.DEFAULT_GOAL := all

DATE = $(date '+%Y-%m-%d')


## Verilog A targets

VERILOGA_BUILD_DIR = verilogA_build
VERILOGA_BUILD_SRC = $(VERILOGA_BUILD_DIR)/src

VA_SRC_DIR = valves serpentine pumps mixers veriloga_objects

MF_LIB = lib_MFXyce

$(BUILD_COMMAND)


$(VERILOGA_BUILD_DIR)/lib/$(MF_LIB).so: $(VA_SRC_DIR)/*/*.va veriloga_objects/*.vams
	mkdir -p $(VERILOGA_BUILD_DIR)/lib
	mkdir -p $(VERILOGA_BUILD_SRC)

	cp veriloga_objects/$(MF_LIB) $(VERILOGA_BUILD_SRC)
	cp veriloga_objects/*.vams $(VERILOGA_BUILD_SRC)
	cp $(foreach VA_SRC_DIR, $(VA_SRC_DIR), $(VA_SRC_DIR)/*/*.va) $(VERILOGA_BUILD_SRC)

	cd $(VERILOGA_BUILD_SRC) && $(BUILD_COMMAND) $(MF_LIB) *.va ./ && \
	rm *.va && rm *.vams && rm $(MF_LIB) && \
	mv *.so ./../lib

clean_va_build:
	rm -r $(VERILOGA_BUILD_SRC)
