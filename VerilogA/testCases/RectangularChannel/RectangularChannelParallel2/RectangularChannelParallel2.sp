

.hdl ./../../RectangularChannel.va
.hdl ./../../SyringePump.va
.hdl ./../../PressurePump.va

.options post=2
.option POST_VERSION=2001

*Sources
X1 p1 0 SyringePump flowrate=100

X2 p1 0 0 0 RectangularChannel L=710u
X3 p1 0 0 0 RectangularChannel L=710u

.trans 0.001ms 1s

.probe tran I(X2.fl_in)
.probe tran I(X3.fl_in)
