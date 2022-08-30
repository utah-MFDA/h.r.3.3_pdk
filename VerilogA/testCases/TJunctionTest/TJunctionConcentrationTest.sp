* concentration test,
* 0 concentration on one side, 100 on the  other
* output should be 50
.hdl ./../../MFlibrary/TJunction.va
.hdl ./../../MFlibrary/PressurePump.va

.options post=1
X1 p1 p2 0 c1 c2 0 TJunction

* pressure tests
X2 p1 c1 PressurePump pressure=100k chemConcentration=100m
X3 p2 c2 PressurePump pressure=100k chemConcentration=0

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
.end

