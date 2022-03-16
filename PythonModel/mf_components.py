class Node(object):
    def __init__(self, node_name):
        self.node_name = node_name
        self.pressure = "unknown"
        self.flow = "unknown"
        self.connects_in = []
        self.connects_out = []

        self.unknowns = []
        self.detUnknowns()

    def setPressure(self, pressure):
        self.pressure = pressure

    def setFlow(self, flow):
        self.flow = flow

    def dispValues(self):
        print(self.node_name)
        print("Pressure(Pa) ",self.pressure)
        print("Flow(m^3/s) ",self.flow)

    def detUnknowns(self):
        self.unknowns = []
        if self.pressure == "unknown":
            self.unknowns.append(self.node_name + " " + "pressure")
        if self.flow == "unknown":
            self.unknowns.append(self.node_name + " " + "flow")
        return self.unknowns

class StraightChannel(object):
    """docstring for straight_channel."""

    def __init__(self, len, eta, node_in, node_out):
        self.len = len
        self.eta = eta
        self.node_in = node_in
        self.node_out = node_out

        # node connects added when component defined
        self.node_in.connects_out.append(self.node_out)
        self.node_out.connects_in.append(self.node_in)

        self.calcResistence()

    def calcResistence(self):
        width_pixels = 14
        hieght_layers = 8

        microns_per_pixel = 7.6
        microns_per_layer = 10
        meters_per_micron = 0.000001

        width_meters = width_pixels*microns_per_pixel*meters_per_micron
        hieght_meters = hieght_layers*microns_per_layer*meters_per_micron

        self.r_hyd = (12*self.eta*self.len)/(1 - 0.63*(hieght_meters/width_meters)) * 1/(hieght_meters**3/width_meters)

    def calcPressureOut(self):
        self.node_out.setPressure(self.node_in.pressure - self.node_in.flow*self.r_hyd)

    def calcPressureIn(self):
        self.node_in.setPressure(self.node_out.pressure + self.node_in.flow*self.r_hyd)

    def calcFlow(self):
        self.node_in.setFlow((self.node_in.pressure-self.node_out.pressure)/self.r_hyd)

    def calcValues(self):
        if self.node_in.flow ==  "unknown":
            self.calcFlow()
        elif self.node_in.pressure == "unknown":
            self.calcPressureIn()

        self.node_out.setFlow(self.node_in.flow)

#TODO
class SerpentineChannel(object):
    """docstring for straight_channel."""

    def __init__(self, len, eta, node_in, node_out):
        self.len = len
        self.eta = eta
        self.node_in = node_in
        self.node_out = node_out

        # node connects added when component defined
        self.node_in.connects_out.append(self.node_out)
        self.node_out.connects_in.append(self.node_in)

        self.calcResistence()

    def calcResistence(self):
        width_pixels = 14
        hieght_layers = 8

        microns_per_pixel = 7.6
        microns_per_layer = 10
        meters_per_micron = 0.000001

        width_meters = width_pixels*microns_per_pixel*meters_per_micron
        hieght_meters = hieght_layers*microns_per_layer*meters_per_micron

        self.r_hyd = (12*self.eta*self.len)/(1 - 0.63*(hieght_meters/width_meters)) * 1/(hieght_meters**3/width_meters)

    def calcPressureOut(self):
        self.node_out.pressure = float(self.node_in.pressure - self.node_in.flow*self.r_hyd)

        #self.node_out.flow = self.node_in.flow

    def calcPressureIn(self):
        self.node_in.pressure = float(self.node_out.pressure + self.node_in.flow*self.r_hyd)

        #self.node_out.flow = self.node_in.flow

    def calcFlow(self):
        self.node_in.flow = float((self.node_in.pressure-self.node_out.pressure)/self.r_hyd)

    def calcValues(self):
        if self.node_in.flow ==  "unknown":
            self.calcFlow()
        elif self.node_in.pressure == "unknown":
            self.calcPressureIn()
        self.node_out.flow = float(self.node_in.flow)
