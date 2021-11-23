*A simple rectangular channel

.hdl ./../../StraightChannel.va
.options post=1
X1 1 0 StraightChannel w=0.1 l=1.0 h=0.1
VS 1 0 1
.dc VS 0 10 1
.end
