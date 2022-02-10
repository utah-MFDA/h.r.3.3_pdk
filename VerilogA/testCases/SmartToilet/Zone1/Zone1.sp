*serpentine channel test

.hdl ./../../../SerpentineChannel.va
.hdl ./../../../PressurePump.va

.options post=1
X1 A cA PressurePump pressure=34450 chem_concentration=1.0
X2 A 0 cA 0 SerpentineChannel

.tran 0.01ms 8ms
.probe tran I(X1.c_out)
.probe tran I(X2.c_in)
.probe tran I(X2.c_out)

.end
