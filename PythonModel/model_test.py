import mf_components as mf

# instantiate Model
model = mf.Model()

# add nodes to model
model.addNodes(3)

# set initial conditions
model.setNodeFlow(0, 10)
model.setNodeFlow(1, 10)
model.setNodePressure(2, 0)

# define components
#model.addSerpentineChannel([0],[1], 0.001064, 0.0010016)
#model.addSerpentineChannel([1],[2], 0.001064, 0.0010016)
model.addJunction([0,1], [2], 0.0010016)

# generate system of equations
model.genSysEq()

# solve system of equations
model.solveModel()
