*serpentine channel test

.hdl ./../../RectangularChannel.va
.options post=1
X1 pB 0 cB cD2 RectangularChannel L=0.00071

*input pressure
VS pB 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcB cB cD2 PWL(0s 0amp 8ms 0amp)

.tran 0.01ms 8ms
.probe tran i(X1.cA)
.probe tran i(X1.cD1)
.print tran i(X1.cA)
.print tran i(X1.cD1)

.end
