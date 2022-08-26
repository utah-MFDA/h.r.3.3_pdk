

.hdl ./../../../../MFlibrary/PressurePump.va
.hdl ./../../../../MFlibrary/RectangularChannel.va
.option post=2

X1 s1 c1 PressurePump pressure=10k chem_concentration=100m
X2 s1 0 c1 0 RectangularChannel

.tran 0.001ms 1s
.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)
.probe tran I(X2.fl_in)
.probe tran I(X2.c_in)
.probe tran I(X2.fl_out)
.probe tran I(X2.c_out)
.end
