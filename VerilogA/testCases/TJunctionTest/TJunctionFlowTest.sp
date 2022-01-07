*In this test circuit the concentration and resistance are constant but
*	the pressure is different.
.hdl TJunction.va

.options post=1
X1 p1 p2 0 c1 c2 co TJunction

* pressure tests
VS1 p1 0 PWL(0 200V 8ms 200V)
VS2 p2 0 PWL(0 300V 8ms 300V)

* concentration implementation
Vc1 c1 0 PWL(0s 100V 8ms 100V)
Vc2 c2 0 PWL(0s 100V 8ms 100V)


.tran 0.01ms 8ms
.end
