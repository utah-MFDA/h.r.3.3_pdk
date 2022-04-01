import mf_components as mf

# instantiate Model
model = mf.Model()

# add nodes to model
model.addNodes(3)

# set initial conditions
#model.setNodePressure(0, 34450)
model.setNodeFlow(0, 10)
model.setNodePressure(2, 0)

# define components
model.addStraightChannel([0],[1], 0.00071, 0.0010016)
model.addStraightChannel([1],[2], 0.00071, 0.0010016)

# generate system of equations
model.genSysEq()

# solve system of equations
model.solveModel()
