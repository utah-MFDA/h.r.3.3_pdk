

.hdl ./../../../../SyringePump.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 c1  SyringePump flowRate=100u
X2 s1 0 c1 0  RectangularChannel
*X3 s1 0  RectangularChannel

.tran 0.01ms 1s
*Needs to be renamed
.probe tran i(X1.fl_out)
.probe tran i(X1.c_out)
