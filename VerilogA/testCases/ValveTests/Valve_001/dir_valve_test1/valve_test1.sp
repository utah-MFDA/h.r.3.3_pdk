*A simple valve test case

*Directory structure
*/VerilogA/testCases/Valvetests/Valve_001/valve_test1.sp

*Fluid testing
.hdl ./../../../../MembraneValve.va
*outputs of the files are binary? (otherwise ASCII)
.options post=1  
*Valves in line with channels
X1 p1 0 a1 0 MembraneValve

*connected to the channels
V1 p1 0 PWL(0 10V 1s 10V)

*connected to the valve
V2 a1 0 PWL(0 10V 1s 20V)

*PWL(0 20V 2s 20V)
*VSA2 a2 0 
*PWL(0 20V 2s 20V)
.trans 0.001ms 1s
*.dc VSP1 0 10 1 VSA 0 20 1
*.dc VSA1 0 20 1
*.dc VSP2
.probe tran I(X1.fl_out)
.probe tran I(X1.fl_in)
.end 

