

.hdl ./../../../../PressurePump.va
.hdl ./../../../../StraightChannel.va
.option post=1

X1 s1 0  PressurePump    pressure=10
X2 s1 s2 StraightChannel
X3 s2 0  StraightChannel

.tran 0.01ms 1s
*.probe tran v(s1)
.end
