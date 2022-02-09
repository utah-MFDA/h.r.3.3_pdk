
.hdl ./../../../MembraneValve.va
.hdl ./../../../RectangularChannel.va
.hdl ./../../../PressurePump.va
.option post=1

X1 s1 c1 PressurePump presssure=14 chem_concentration=100m
X2 s1 s2 a1 0 c1 c2 MembraneValve  
X3 s2 0 c2 0 RectangularChannel

* Pneumatic Switch
V1 a1 0 PWL(0 0V 0.59 0V 0.6 20V 1.0 20V)

.tran 0.001ms 1s
.probe tran I(X1.fl_out)
.probe tran I(X2.fl_out)
.probe tran I(X3.fl_out)
.probe tran I(X1.c_out)
.probe tran I(X2.c_out)
.probe tran I(X3.c_out)


