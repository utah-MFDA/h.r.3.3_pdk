*Basic channel and pump test

.hdl ./../../Elibrary/EPrPump.va
.hdl ./../../Elibrary/EChannel.va
.hdl ./../../Elibrary/ETJunction.va


.options POST_VERSION=2001
.option post=1

X1 p1 c1 PressurePump pressure=100k chemConcentration=100m
X2 p2 c2 PressurePump pressure=100k chemConcentration=0

X3 pm1 0 cm1 co Channel

X4 p1 p2 pm1 c1 c2 cm1 TJunction

.tran 0.01ms 8ms

*.probe tran I(X1.fl_out)
*.probe tran I(X1.c_out)

*.probe tran I(X2.fl_in)
*.probe tran I(X2.fl_out)

.probe tran V(X4.c_in1)
.probe tran V(X4.c_in2)
.probe tran I(X4.fl_i1)
.probe tran I(X4.fl_i2)
.probe tran I(X4.fl_out)

.end
