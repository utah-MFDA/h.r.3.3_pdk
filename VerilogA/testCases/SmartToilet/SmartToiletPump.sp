*serpentine channel test

.hdl ./../../SerpentineChannel.va
.hdl ./../../RectangularChannel.va
.hdl ./../../TJunction.va
.hdl ./../../PressurePump.va
.options post=1

X1 A PressurePump pressure=34450 chem_concentration=0
X2 B PressurePump pressure=34450 chem_concentration=0
X3 C PressurePump pressure=34450 chem_concentration=0

X4 A D1 SerpentineChannel
X5 B D2 RectangularChannel L=0.00071
X6 C E2 SerpentineChannel FOOTPRINT_WIDTH = 0.01362

X7 D1 D2 Di Dout TJunction L=0.0001

X8 Dout E1 SerpentineChannel

X9 E1 E2 Ei Eout TJunction L=0.0001
X10 Eout 0 SerpentineChannel

.tran 0.01ms 8ms

.probe tran I(X1.fl_out)
.probe tran I(X2.fl_out)
.probe tran I(X3.fl_out)

.probe tran I(X4.fl_in)
.probe tran I(X4.fl_out)
.probe tran I(X5.fl_in)
.probe tran I(X5.fl_out)
.probe tran I(X6.fl_in)
.probe tran I(X6.fl_out)

.probe tran I(X7.fl_1)
.probe tran I(X7.fl_2)
.probe tran I(X7.fl_internal)
.probe tran I(X7.fl_out)

.probe tran I(X9.fl_1)
.probe tran I(X9.fl_2)
.probe tran I(X9.fl_internal)
.probe tran I(X9.fl_out)

.probe tran I(X10.fl_in)
.probe tran I(X10.fl_out)

.end
