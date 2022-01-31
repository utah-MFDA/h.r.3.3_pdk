


.hdl ./../../../../SyringePump.va
*.hdl ./../../../../StraightChannel.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 0 c1 0 SyringePump flowrate=200u
X2 s1 0 c1 0 RectangularChannel

.tran 0.001ms 1s
.probe tran I(X2.fl_in)
.probe tran I(X2.c_in)
.probe tran I(X1.out1)
.probe tran I(X1.c_out)
