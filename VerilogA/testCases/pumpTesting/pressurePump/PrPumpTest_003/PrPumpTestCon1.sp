

.hdl ./../../../../PressurePump.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 0 c1 0 PressurePump pressure=10 
*chem_concentration=100
X2 s1 0 c1 0  RectangularChannel
*X3 s2 0  RectangularChannel

.tran 0.01ms 1s
.probe tran i(X1.out1)
.probe tran i(X1.c_out)
.end
