

.hdl ./../../../../PressurePump.va
.hdl ./../../../../StraightChannel.va
.option post=1

X1 s1 0 PressurePump pressure=10
X2 s1 0 StraightChannel

*.probe TRAN Ix(X2:s1)
.tran 0.01ms 1s
.probe tran i(X1.out1)
.probe tran i(X2.fl_port_1)
.probe tran i(X2.fl_port_2)
.probe tran P(X2.fl_port_1)
.probe tran Q(X2.fl_port_1)
*.print I(X1.out1)
*.print I(X2.fl_port_1)
.end
