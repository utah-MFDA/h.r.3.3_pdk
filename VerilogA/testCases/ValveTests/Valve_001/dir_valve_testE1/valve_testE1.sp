*A simple valve test case

*Directory structure
*/VerilogA/testCases/Valvetests/Valve_001/valve_test1.sp

*Fluid
*.hdl ./../../../MembraneValve.va
*electrical testing only
.hdl ./../../MembraneValveE.va
*.hdl ./../Junction3.va
*.hdl ./../../../StraightChannel.va
*I do not know exactly what the next line does or if needed
.options post=1  

 
*Valves in line with channels
XV1 p1 0 a1 0 MembraneValve

* sources
* connected to the channels
VSP1 p1 0 PWL(0 10V 1s 10V)
*connected to the valve
VSA1 a1 0 PWL(0 10V 1s 20V) 

*transient script
.tran 0.01s 1s
.end 

