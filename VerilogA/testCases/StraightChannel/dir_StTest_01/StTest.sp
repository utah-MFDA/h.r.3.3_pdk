*A simple rectangular channel

.hdl ./../../StraightChannel.va
.options post=1
X1 0 1 StraightChannel w=0.1 l=1.0 h=0.1
VS 1 0 PWL(0 10Pa 1s 20Pa) 
.tran 0.01ms 1s
.dc VS 0 10 1
.end
