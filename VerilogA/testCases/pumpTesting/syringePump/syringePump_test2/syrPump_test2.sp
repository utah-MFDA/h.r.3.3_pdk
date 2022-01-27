

.hdl ./../../../../SyringePump.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 0  SyringePump flowRate=100u
X2 s1 0  RectangularChannel
X3 s1 0  RectangularChannel

.tran 0.01ms 1s
.probe tran i(X2.fluid_port_1)
.probe tran i(X3.fluid_port_2)
