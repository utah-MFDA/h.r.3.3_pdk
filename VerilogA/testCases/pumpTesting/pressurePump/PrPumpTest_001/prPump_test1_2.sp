

.hdl ./../../../../MFlibrary/PressurePump.va
.hdl ./../../../../MFlibrary/RectangularChannel.va
.hdl ./../../../../MFlibrary/OutletPort.va
.option post=2

X1 s1 c1 PressurePump pressure=10k chem_concentration=100m
X2 s1 s2 c1 c2 RectangularChannel
X3 s2 c2 OutletPort

.tran 0.001ms 1s
.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)
.probe tran I(X2.fl_in)
.probe tran I(X2.c_in)
.probe tran I(X2.fl_out)
.probe tran I(X2.c_out)
.probe tran I(X3.fl_in)
.probe tran I(X3.c_in)
.end
