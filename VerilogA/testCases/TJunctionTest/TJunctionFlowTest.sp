* pressure test,
.hdl ./../../MFlibrary/TJunction.va
.hdl ./../../MFlibrary/PressurePump.va

.options post=1
X1 p1 p2 0 c1 c2 0 TJunction

* pressure tests
X2 p1 c1 PressurePump pressure=100k chemConcentration=0
X3 p2 c2 PressurePump pressure=100k chemConcentration=0

*VS1 p1 0 PWL(0 200V 8ms 200V)
*VS2 p2 0 PWL(0 300V 8ms 300V)

* concentration implementation
*Vc1 c1 0 PWL(0s 100V 8ms 100V)
*Vc2 c2 0 PWL(0s 100V 8ms 100V)


.tran 0.01ms 8ms
.end
