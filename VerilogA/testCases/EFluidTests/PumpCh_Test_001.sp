

.hdl ./../../Elibrary/EPrPump.va
.hdl ./../../Elibrary/EChannel.va

.option post=1

X1 p1 c1 PressurePump pressure=100k

X2 p1 0 c1 c2 Channel

.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)

.probe tran I(X2.fl_in)
.probe tran I(X2.fl_out)

