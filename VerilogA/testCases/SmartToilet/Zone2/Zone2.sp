*serpentine channel test

.hdl ./../../../RectangularChannel.va
.options post=1
X1 pB 0 cB cD2 RectangularChannel L=0.00071

*input pressure
VS pB 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcB cB cD2 PWL(0s 0 8ms 0)

.tran 0.01ms 8ms
.probe tran I(X1.c_in)
.probe tran I(X1.c_out)
.print tran I(X1.c_in)
.print tran I(X1.c_out)


.end
