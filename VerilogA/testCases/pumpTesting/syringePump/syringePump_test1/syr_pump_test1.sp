
*This test shows that only the pump can flow to ground

.hdl ./../../../../SyringePump.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 0 SyringePump flowrate=200u
*X2 0 0 SyringePump flowrate=500u
X2 s1 0 0 0 RectangularChannel

.tran 0.001ms 1s
.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)
