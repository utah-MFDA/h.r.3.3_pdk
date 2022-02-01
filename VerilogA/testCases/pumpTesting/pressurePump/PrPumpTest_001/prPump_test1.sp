

.hdl ./../../../../PressurePump.va
.hdl ./../../../../RectangularChannel.va
.option post=2

X1 s1 c1 PressurePump pressure=10 chem_concentration=100m
X2 s1 0 c1 0 RectangularChannel

.tran 0.001ms 1s
.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)
.end
