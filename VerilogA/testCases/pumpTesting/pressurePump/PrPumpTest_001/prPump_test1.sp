

.hdl ./../../../PressurePump.va
.hdl ./../../../StraightChannel.va
.option post=1

X1 s1 0 PressurePump pressure=10
X1 s1 0 StraightChannel

.tran 0.01ms 1s
.end
