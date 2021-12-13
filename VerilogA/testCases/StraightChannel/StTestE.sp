*A simple rectangular channel

.hdl ./../../StraightChannelE.va
.options post=1
X1 1 0 StraightChannel W=0.1 L=1.0 H=0.1
VS 1 0 1
.dc VS 0 10 1
.end
