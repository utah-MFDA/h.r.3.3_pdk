*serpentine channel test

.hdl ./../../SerpentineChannel.va
.options post=1
X1 pA 0 cA cD1 SerpentineChannel

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)

*input concentration
VcA cA cD1 PWL(0s 1V 8ms 1V)

.probe tran I(X1.pA)
.tran 0.01ms 8ms
.end
