


.hdl ./../../../../SyringePump.va
*.hdl ./../../../../StraightChannel.va
.hdl ./../../../../RectangularChannel.va
* This does not add access functions to probe
*.hdl ./../../../../nature_fluid_dynamics.vams
*.hdl ./../../../../ToAtmosphere.va
* Saves in ACSII format
.option post=2
*.option cds=2

X1 s1 c1 SyringePump flowrate=200u chem_concentration=100m
X2 s1 0 c1 0 RectangularChannel
*X3 sg cg ToAtmosphere

.tran 0.001ms 1s
.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)
.probe tran I(X2.fl_in)
.probe tran I(X2.c_in)
.probe tran I(X2.c_out)
