*serpentine channel test

.hdl ./../../../TJunction.va
.options post=1
X1 pA pB pi 0 cD1 cD2 cDout TJunction L=0.0001

*input pressure
VS pA 0 PWL(0 34450V 8ms 34450V)
VS pB 0 PWL(0 34450V 8ms 34450V)

*input concentration
IcA cD1 cDout PWL(0s 1 8ms 1)
IcA cD2 cDout PWL(0s 0 8ms 0)

.tran 0.01ms 8ms
.probe tran I(X1.c_1)
.probe tran I(X1.c_2)
.probe tran I(X1.c_out)


.end
