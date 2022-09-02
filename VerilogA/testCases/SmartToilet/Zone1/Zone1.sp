*serpentine channel test

.hdl ./../../../SerpentineChannel.va
.hdl ./../../../PressurePump.va

.options post=1
X1 A cA PressurePump pressure=34450
X2 A 0 cA 0 SerpentineChannel

.tran 0.01ms 8ms
.probe tran I(X1.m_out)
.probe tran I(X2.m_in)
.probe tran I(X2.m_out)

.end
