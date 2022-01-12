


.hdl ./../../../../SyringePump.va
.hdl ./../../../../StraightChannel.va
.option post=1

X1 s1 0 SyringePump flowrate=200u
X2 s1 0 StraightChannel

.tran 0.001ms 1s
.probe tran I(X2.fl_port_1)
.probe tran I(X1.out1)
