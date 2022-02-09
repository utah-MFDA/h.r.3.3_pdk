*serpentine channel test

.hdl ./../../SerpentineChannel.va
.hdl ./../../RectangularChannel.va
.hdl ./../../TJunction.va
.hdl ./../../PressurePump.va
.options post=1

X1 A 0 cA cD1 PressurePump pressure=34450 chem_concentration=0
X2 B 0 cB cD2 PressurePump pressure=34450 chem_concentration=0
X3 C 0 cC cE2 PressurePump pressure=34450 chem_concentration=0

X4 A D1 cA cD1 SerpentineChannel
X5 B D2 cB cD2 RectangularChannel L=0.00071
X6 C E2 cC cE2 SerpentineChannel FOOTPRINT_WIDTH = 0.01362

X7 D1 D2 Di Dout cD1 cD2 cDout TJunction L=0.0001

X8 Dout E1 cDout cE1 SerpentineChannel

X9 E1 E2 Ei Eout cE1 cE2 cEout TJunction L=0.0001
X10 Eout 0 cEout cF SerpentineChannel

.tran 0.01ms 8ms

.probe tran I(X4.fl_in)
.probe tran I(X5.fl_in)
.probe tran I(X6.fl_in)

.probe tran I(X10.fl_out)

.end
