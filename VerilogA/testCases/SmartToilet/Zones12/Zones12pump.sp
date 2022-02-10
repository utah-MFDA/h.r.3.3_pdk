*serpentine channel test

.hdl ./../../../SerpentineChannel.va
.hdl ./../../../RectangularChannel.va
.hdl ./../../../TJunction.va
.hdl ./../../../PressurePump.va
.options post=1

X1 A cA PressurePump pressure=34450
X2 B cB PressurePump pressure=34450

X3 A D1 cA cD1 SerpentineChannel
X4 B D2 cB cD2 RectangularChannel L=0.00071

X5 D1 D2 Di 0 cD1 cD2 cDout TJunction L=0.0001

.tran 0.01ms 8ms

.prbe  tran I(cD1)

.probe tran I(X1.m_out)
.probe tran I(X2.m_out)

.probe tran I(X3.m_out)
.probe tran I(X4.m_out)

.probe tran I(X5.m_1)
.probe tran I(X5.m_2)
.probe tran I(X5.m_out)
.end
