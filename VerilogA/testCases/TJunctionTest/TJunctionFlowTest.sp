* pressure test,
.hdl ./../../MFlibrary/TJunction.va
.hdl ./../../MFlibrary/PressurePump.va

.options POST_VERSION=2001 ABSTOL=1e-25
X1 D1 PressurePump pressure=34450
X2 D2 PressurePump pressure=34450

X3 D1 D2 Di 0 TJunction L=0.0001

.tran 0.01ms 8ms

.probe tran I(X1.fl_out)
.probe tran I(X2.fl_out)

.probe tran I(X3.fl_1)
.probe tran I(X3.fl_2)
.probe tran I(X3.fl_internal)
.probe tran I(X3.fl_out)

.print tran I(X1.fl_out)
.print tran I(X2.fl_out)

.print tran I(X3.fl_1)
.print tran I(X3.fl_2)
.print tran I(X3.fl_internal)
.print tran I(X3.fl_out)

.print tran V(X3.fl_internal)

.end
