

.hdl ./StChan_inout.va
.options post=1
X1 in1 0 StraightChannel
VS1 in1 0 
*VS2 0 in1
.dc VS1 0  10 1
*.dc VS1 0 -10 1
*.dc VS2 0  10 1
*.dc VS2 0 -10 1
.end
