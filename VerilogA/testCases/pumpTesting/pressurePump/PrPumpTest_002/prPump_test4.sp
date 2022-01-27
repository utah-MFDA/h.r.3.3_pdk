

.hdl ./../../../../PressurePump.va
* No longer used
*.hdl ./../../../../StraightChannel.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 0  PressurePump       pressure=10
X2 s1 s2 RectangularChannel
X3 s2 0 RectangularChannel  
*X2 s1 s2 StraightChannel
*X3 s2 0  StraightChannel

.tran 0.01ms 1s
.probe tran i(X1.out1)
.probe tran i(X2.fluid_port_1)
.probe tran i(X3.fluid_port_1)
*.probe tran v(s1)
.end
