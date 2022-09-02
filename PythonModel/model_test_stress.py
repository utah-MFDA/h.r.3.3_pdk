import mf_components as mf

model = mf.Model()

numNodes = 100
inPressure = 100
eta = 0.0010016
height_meters = 10*8*1e-6
width_meters  = 10*7.6*1e-6
r_hyd_over_len = (12*eta)/(1 - 0.63*(hieght_meters/width_meters)) * 1/(hieght_meters**3/width_meters)

len_ch = 1/r_hyd_over_len

model.addNodes(numNodes)

print("len: " + str(len_ch))

# input pressure
model.setNodePressure(0,inPressure)
model.setNodePressure(numNodes-1,0)

for i in range(0, numNodes-1):
    model.addStraitChannel([i],[i+1],len_ch, eta)

model.genSysEq()
model.solveModel()
