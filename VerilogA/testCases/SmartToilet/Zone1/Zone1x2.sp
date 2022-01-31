*serpentine channel test

.hdl ./../../../SerpentineChannel.va
.options post=1
X1 pA pB cA cB SerpentineChannel
X2 pB 0 cB cD1 SerpentineChannel

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcA cA cD1 PWL(0s 1 8ms 1)

.tran 0.01ms 8ms
.probe tran I(X1.c_in)
.probe tran I(X1.c_out)
.probe tran I(X2.c_in)
.probe tran I(X2.c_out)

.end
