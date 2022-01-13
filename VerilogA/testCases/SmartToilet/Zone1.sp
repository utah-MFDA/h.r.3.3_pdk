*serpentine channel test

.hdl ./../../SerpentineChannel.va
.options post=1
X1 pA 0 cA cD1 SerpentineChannel

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)

*input concentration
VcA cA cD1 PWL(0s 1V 8ms 1V)

.print I(X1.pA)
.print V(X1.pA)
.print I(X1.0)
.print V(X1.0)
.print V(X1.cA)
.print V(X1.cD1)
.tran 0.01ms 8ms
.end
