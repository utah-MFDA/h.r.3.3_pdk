*Basic channel and pump test

.hdl ./../../Elibrary/EPrPump_flow.va
.hdl ./../../Elibrary/EChannel_flow.va

.options POST_VERSION=2001
.option post=1

X1 p1 PressurePump pressure=100k 
*chemConcentration=100m

X2 p1 0 Channel

.tran 0.01ms 8ms

*.probe tran I(X1.fl_out)
*.probe tran I(X1.c_out)

*.probe tran I(X2.fl_in)
*.probe tran I(X2.fl_out)

.end
