*serpentine channel test

.hdl ./../../SerpentineChannel.va
.options post=1
X1 pA pB cA cB SerpentineChannel
X2 pB 0 cB cD1 SerpentineChannel

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcA cA cD1 PWL(0s 1amp 8ms 1amp)

.tran 0.01ms 8ms
.probe tran i(X1.cA)
.probe tran i(X1.cD1)
.print tran i(X1.cA)
.print tran i(X1.cD1)

.end
