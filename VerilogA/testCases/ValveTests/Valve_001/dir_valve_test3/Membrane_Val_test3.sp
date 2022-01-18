*Membrane Valve test 2
*A simple valve test case

*Directory structure
*/VerilogA/testCases/Valvetests/Valve_001/valve_test1.sp

*Fluid testing
.hdl ./../../../../MembraneValve.va
.hdl ./../../../../PressurePump.va
.hdl ./../../../../SyringePump.va
.hdl ./../../../../PneumaticSwitch.va
*I do not know exactly what the next line does or if needed
.options post=1  
*Valves in line with channels
X1 p1 0 a1 0 MembraneValve

*connected to the channels
X2 p1 0 SyringePump flowrate=200u


*connected to the valve
X3 a1 0 PneumaticSwitch pressure=16
*V1 a1 0 PWL(0 10V 1s 20V)

*PWL(0 20V 2s 20V)
*VSA2 a2 0 
*PWL(0 20V 2s 20V)
.trans 0.01ms 2s
.probe tran I(X1.fl_port_1)
.probe tran I(X1.fl_port_2)
*.dc VSP1 0 10 1 VSA 0 20 1
*.dc VSA1 0 20 1
*.dc VSP2
.end 

