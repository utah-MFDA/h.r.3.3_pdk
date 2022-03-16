import mf_components as mf

# define node objects
n1 = mf.Node("node 1")
n2 = mf.Node("node 2")
n3 = mf.Node("node 3")

# set initial conditions
n1.setPressure(34450)
#n1.setFlow(10)
n3.setPressure(0)

system_unknowns = n1.detUnknowns() + n2.detUnknowns() + n3.detUnknowns()
print(system_unknowns)

# define components
sc_1 = mf.StraightChannel(0.0010016, 0.00071, n1, n2)
sc_2 = mf.StraightChannel(0.0010016, 0.00071, n2, n3)

#calc calcValues
#sc_1.calcValues()
#sc_2.calcValues()

n1.dispValues()
n2.dispValues()
