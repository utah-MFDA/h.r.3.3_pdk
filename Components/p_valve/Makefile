
P_VALVE_LEFS=$(foreach LEF_DIR, $(wildcard p_valve_*), ./$(LEF_DIR)/$(LEF_DIR).lef)

p_cell_valves.lef: $(P_VALVE_LEFS)
	cut -b 1- $^ > $@

all: p_cell_valves.lef
	echo $(P_VALVE_LEFS)

