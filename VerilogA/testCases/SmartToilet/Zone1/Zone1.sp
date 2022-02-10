*serpentine channel test

.hdl ./../../../SerpentineChannelMass.va
.hdl ./../../../PressurePumpMass.va

.options post=1
X1 A cA PressurePumpMass pressure=34450
X2 A 0 cA 0 SerpentineChannelMass

.tran 0.01ms 8ms
.probe tran I(X1.m_out)
.probe tran I(X2.m_in)
.probe tran I(X2.m_out)

.end
