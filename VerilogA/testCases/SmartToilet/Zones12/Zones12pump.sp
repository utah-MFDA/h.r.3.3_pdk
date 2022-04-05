*serpentine channel test

.hdl ./../../../SerpentineChannel.va
.hdl ./../../../RectangularChannel.va
.hdl ./../../../TJunction.va
.hdl ./../../../PressurePump.va
.options post=1

X1 A PressurePump pressure=34450
X2 B PressurePump pressure=34450

X3 A D1 SerpentineChannel
X4 B D2 RectangularChannel L=0.00071

X5 D1 D2 Di 0 TJunction L=0.0001

.tran 0.01ms 8ms

.probe tran I(X1.fl_out)
.probe tran I(X2.fl_out)

.probe tran I(X3.fl_in)
.probe tran I(X3.fl_out)
.probe tran I(X4.fl_in)
.probe tran I(X4.fl_out)

.probe tran I(X5.fl_1)
.probe tran I(X5.fl_2)
.probe tran I(X5.fl_internal)
.probe tran I(X5.fl_out)
.end
