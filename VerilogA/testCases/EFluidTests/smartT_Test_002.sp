*Smart Toilet test 001

*./../../Elibrary/standardCells/

.hdl ./../../Elibrary/EPrPump.va
.hdl ./../../Elibrary/standardCells/Eserpentine_300px_0
.hdl ./../../Elibrary/standardCells/Eserpentine_50px_0
.hdl ./../../Elibrary/standardCells/Eserpentine_150px_0
.hdl ./../../Elibrary/standardCells/Ediffmix_25px_0

.option post=1

X1 sol1 sol1c PressurePump pressure=100k
X2 sol2 sol2c PressurePump pressure=100k
X3 sol3 sol3c PressurePump pressure=100k

X4 sol1 c0 sol1c c0c serpentine_300px_0

X5 sol2 c1 sol2c c1c serpentine_50px_0
X6 c1 c2 c1c c2c serpentine_150px_0

X7 c0 c2 0 c0c c2c c3c diffmix_25px_0

X8 sol3 sol3c c4 c4c serpentine_300px_0
X9 c4 c4c c5 c5c serpentine_300px_0
X10 c5 c5c c6 c6c serpentine_300px_0

X11 c3 c6 c7 c3c c6c c7c diffmix_25px_0

X12 c7 0 c7c coc serpentine_300px_0


.tran 0.01ms 1ms
.end
