* Converted from verilog for microfluidic simulation

*Outputs as ASCII
.option post=2
.option POST_VERSION=2001

.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Evalve_20px_1.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_25px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_50px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_75px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_100px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_150px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_200px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Eserpentine_300px_0.va
.hdl ~/Github/component_library/VerilogA/Elibrary/standardCells/Ediffmix_25px_0.va

*hard coded EChannel, used for wires
.hdl ~/Github/component_library/VerilogA/Elibrary/EChannel.va
*hard coded Pressure Pump, used for wires
.hdl ~/Github/component_library/VerilogA/Elibrary/EPrPump.va


X0 soln1_0 soln1_0c PressurePump pressure=100k 
X1 soln2_0 soln2_0c PressurePump pressure=100k 
X2 soln3_0 soln3_0c PressurePump pressure=100k chemConcentration=100 
X3 soln1_0 soln1_1  soln1_0c soln1_1c Channel length=0.01m
X4 soln2_0 soln2_1  soln2_0c soln2_1c Channel length=0.01m
X5 soln3_0 soln3_1  soln3_0c soln3_1c Channel length=0.01m

X6 out_ch 0  out_chC outc0 Channel length=0.01m

X7 connect1_0 connect1_1  connect1_0c connect1_1c  Channel length=0.01m
X8 connect2_0 connect2_1  connect2_0c connect2_1c  Channel length=0.01m
X9 connect3_0 connect3_1  connect3_0c connect3_1c  Channel length=0.01m
X10 connect4_0 connect4_1  connect4_0c connect4_1c  Channel length=0.01m
X11 connect5_0 connect5_1  connect5_0c connect5_1c  Channel length=0.01m
X12 connect6_0 connect6_1  connect6_0c connect6_1c  Channel length=0.01m
X13 connect7_0 connect7_1  connect7_0c connect7_1c  Channel length=0.01m
X14 soln1_1 connect0 soln1_1c connect0c serpentine_25px_0
X15 soln2_1 connect1_0 soln2_1c connect1_0c serpentine_50px_0
X16 connect1_1 connect2_0 connect1_1c connect2_0c serpentine_150px_0
X17 connect0 connect2_1 connect3_0 connect0c connect2_1c connect3_0c diffmix_25px_0
X18 soln3_1 connect4_0 soln3_1c connect4_0c serpentine_300px_0
X19 connect4_1 connect5_0 connect4_1c connect5_0c serpentine_300px_0
X20 connect5_1 connect6_0 connect5_1c connect6_0c serpentine_300px_0
X21 connect3_1 connect6_1 connect7_0 connect3_1c connect6_1c connect7_0c diffmix_25px_0
X22 connect7_1 out_ch connect7_1c out_chC serpentine_300px_0

.tran 0.1ms 1ms