*serpentine channel test

.hdl ./../../SerpentineChannel.va
.options post=1
X1 pA 0 cA cD1 SerpentineChannel

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcA cA cD1 PWL(0s 1 8ms 1)

.probe tran I(X1.pA)
.probe tran I(X1.cA)
.probe tran I(X1.cD1)
.tran 0.01ms 8ms
.end
