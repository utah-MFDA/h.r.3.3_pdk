
.hdl ./../../../MFlibrary/RectangularChannel.va
.hdl ./../../../MFlibrary/PressurePump.va
.hdl ./../../../MFlibrary/OutletPort.va
.option post=2

*netlist
*Inlets
X1 s11 c11 PressurePump pressure=100k chem_concentration=100m
X2 s21 c21 PressurePump pressure=100k chem_concentration=0m

*resistive channels
X3 s11 s3 c11 c3 RectangularChannel
X4 s21 s3 c21 c3 RectangularChannel
X5 s3 s4 c3 c4 RectangularChannel

*outlet
X6 s4 c4 OutletPort

*probes
.tran 0.001ms 1s
*Pumps
.probe tran I(X1.fl_out)
.probe tran I(X1.c_out)
.probe tran I(X2.fl_out)
.probe tran I(X2.c_out)
*Channels
.probe tran I(X3.fl_out)
.probe tran I(X3.c_out)
.probe tran I(X4.fl_out)
.probe tran I(X4.c_out)
.probe tran I(X5.fl_in)
.probe tran I(X5.c_in)
.probe tran I(X5.fl_out)
.probe tran I(X5.c_out)
*outlets
.probe tran I(X6.fl_in)
.probe tran I(X6.c_out)

.end
