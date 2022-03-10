import mf_components as mf

# define node objects
n1 = mf.Node()
n2 = mf.Node()

# set initial conditions
n1.setPot(34450)
n2.setPot(0)

# define components
sc_1 = StraightChannel(0.0010016, 0.00071, n1, n2)

#calc calcValues
sc_1.calcValues()

n1.dispValues()
n2.dispValues()
