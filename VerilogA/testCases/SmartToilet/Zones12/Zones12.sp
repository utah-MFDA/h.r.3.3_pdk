*serpentine channel test

.hdl ./../../../SerpentineChannel.va
.hdl ./../../../RectangularChannel.va
.hdl ./../../../TJunction.va
.options post=1
X1 pA pD1 cA cD1 SerpentineChannel
X2 pB pD2 cB cD2 RectangularChannel L=0.00071
X3 pA pB pi 0 cD1 cD2 cDout TJunction L=0.0001

*input pressures
VA pA 0 PWL(0 34450V 8ms 34450V)
VB pB 0 PWL(0 34450V 8ms 34450V)

*input concentrations
IcA cA cD1 PWL(0s 1 8ms 1)
IcB cB cD2 PWL(0s 0 8ms 0)

.tran 0.01ms 8ms
.probe tran I(X1.c_in)
.probe tran I(X1.c_out)
.probe tran I(X2.c_in)
.probe tran I(X2.c_out)
.probe tran I(X1.c_1)
.probe tran I(X1.c_2)
.probe tran I(X1.c_out)

.end
