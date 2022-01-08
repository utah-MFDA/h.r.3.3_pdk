* concentration test,
* 0 concentration on one side, 100 on the  other
* output should be 50
.hdl ./../../TJunction.va

.options post=1
X1 p1 p2 po c1 c2 co TJunction

* pressure tests
VS1 p1 po PWL(0 100V 8ms 100V)
VS2 p2 po PWL(0 100V 8ms 100V)

* concentration implementation
Vc1 c1 co PWL(0s 0V 8ms 0V)
Vc2 c2 co PWL(0s 100V 8ms 100V)


.tran 0.01ms 8ms
.end
