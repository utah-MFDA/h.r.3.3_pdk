

.hdl ./../../../../PressurePump.va
.hdl ./../../../../RectangularChannel.va
.option post=1

X1 s1 c1 PressurePump pressure=10
X1 s1 0 c1 0 RectangularChannel

.tran 0.01ms 1s
.end
