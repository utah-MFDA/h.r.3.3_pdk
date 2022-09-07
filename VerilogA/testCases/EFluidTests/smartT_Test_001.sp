

.hdl ./../../Elibrary/EPrPump.va
.hdl ./../../Elibrary/standardCells/serpentine_300px_0
.hdl ./../../Elibrary/standardCells/serpentine_50px_0
.hdl ./../../Elibrary/standardCells/serpentine_150px_0
.hdl ./../../Elibrary/standardCells/diffmix_25px_0

.option post=1

X1 sol1 sol1c PressurePump pressure=100k
X2 sol2 sol2c PressurePump pressure=100k
X3 sol3 sol3c PressurePump pressure=100k

X4 sol1 c0 sol1c c0c serpentine_300px_0

X5 sol2 c1 sol2c c1c serpentine_50px_0
X6 c1 c2 c1c c2c serpentine_150px_0

X7 c0 c2 0 c0c c2c c3c diffmix_25px_0


