

.hdl ./../../../../MembraneValve.va
.hdl ./../../../../PressurePump.va
.hdl ./../../../../RectangularChannel.va

.option post=2
.option POST_VERSION=2001

X1 s1 0        	PressurePump pressure=10k
X2 s1 s2       	RectangularChannel L=0.100
X3 s1 s3       	RectangularChannel L=0.200
X4 s2 s21 a1 0 	MembraneValve
X5 s3 s31 a2 0 	MembraneValve
X6 s21 0	RectangularChannel L=0.200
X7 s31 0 	RectangularChannel L=0.100


V1 a1 0 PWL(0 0V 0.39 0V 0.4s 20V)
V2 a2 0 PWL(0 0V 0.79 0V 0.8s 20V)

.tran 0.01ms 1s
.probe tran i(X1.out1)
.probe tran i(X2.fluid_port_1)
.probe tran i(X3.fluid_port_1)
