* concentration test,
* 0 concentration on one side, 100 on the  other
* output should be 50
.hdl ./../../MFlibrary/RectangularChannel.va
.hdl ./../../MFlibrary/TJunction_K.va
.hdl ./../../MFlibrary/PressurePump_K.va

.options post=1
X1 p1 p2 0 c1 c2 co TJunction

* pressure tests
X2 p11 c11 PressurePump pressure=100k chemConcentration=100m
X3 p22 c22 PressurePump pressure=100k chemConcentration=0m

* channels
X4 p1 p11 c1 c11 RectangularChannel
X5 p2 p22 c2 c22 RectangularChannel

*VS1 p1 0 PWL(0 100V 8ms 100V)
*VS2 p2 0 PWL(0 100V 8ms 100V)

* concentration implementation
*Ic1 c1 co PWL(0s 0 8ms 0)
*Ic2 c2 co PWL(0s 1 8ms 1)


.tran 0.01ms 8ms
.probe tran I(X1.fl_1)
.probe tran I(X1.fl_2)
.probe tran I(X1.fl_out)
.probe tran I(X1.c_1)
.probe tran I(X1.c_2)
.probe tran I(X1.c_out)

.probe tran I(X2.fl_out)
.probe tran I(X2.c_out)

.probe tran I(X3.fl_out)
.probe tran I(X3.c_out)
.end

