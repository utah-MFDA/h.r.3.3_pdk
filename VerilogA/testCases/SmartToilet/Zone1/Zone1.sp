*serpentine channel test

.hdl ./../../SerpentineChannel.va
.options post=1
X1 pA 0 cA cD1 SerpentineChannel

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcA cA cD1 PWL(0s 1amp 8ms 1amp)

.tran 0.01ms 8ms
.probe tran I(X1.c_in)
.probe tran I(X1.c_out)
.print tran I(X1.c_in)
.print tran I(X1.c_out)

.end
