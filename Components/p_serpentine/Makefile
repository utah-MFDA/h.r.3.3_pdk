
P_SERP_LEFS=$(foreach LEF_DIR, $(wildcard p_serpentine_*), ./$(LEF_DIR)/$(LEF_DIR).lef)

p_cell_serpentines.lef: $(P_SERP_LEFS)
	cut -b 1- $^ > $@

all: p_cell_serpentines.lef
	echo $(P_SERP_LEFS)

