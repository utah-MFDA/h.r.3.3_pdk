import numpy as np

class Node(object):
    def __init__(self, node_id):
        self.node_id = node_id

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
        print("Node ", self.node_id)
        print("Pressure(Pa) ",self.pressure)
        print("Flow(m^3/s) ",self.flow)

    def detUnknowns(self):
        self.unknowns = []
        if self.pressure == "unknown":
            self.unknowns.append("node " + str(self.node_id) + " " + "pressure")
        if self.flow == "unknown":
            self.unknowns.append("node " + str(self.node_id) + " " + "flow")
        return self.unknowns

class Component(object):
    def __init__(self, comp_id, nodes_in, nodes_out):
        self.comp_id = comp_id
        self.nodes_in = nodes_in
        self.nodes_out = nodes_out

    def getCompUnknowns(self):
        self.unknowns = []

        for node in self.nodes_in:
            self.unknowns.append(node.unknowns)

        for node in self.nodes_out:
            self.unknowns.append(node.unknowns)

        self.num_unknowns = len(self.unknowns)

#class Channel(Component)

class StraightChannel(Component):
    """docstring for straight_channel."""

    def __init__(self, comp_id, nodes_in, nodes_out, len, eta):
        super().__init__(comp_id, nodes_in, nodes_out)

        self.len = len
        self.eta = eta

        # node connects added when component defined
        self.nodes_in[0].connects_out.append(self.nodes_out[0])
        self.nodes_out[0].connects_in.append(self.nodes_in[0])

        self.component_name = "Straight Channel"

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
        self.nodes_out[0].setPressure(self.nodes_in[0].pressure - self.nodes_in[0].flow*self.r_hyd)

    def calcPressureIn(self):
        self.nodes_in[0].setPressure(self.nodes_out[0].pressure + self.nodes_in[0].flow*self.r_hyd)

    def calcFlow(self):
        self.nodes_in[0].setFlow((self.nodes_in[0].pressure-self.nodes_out[0].pressure)/self.r_hyd)
        self.nodes_out[0].setFlow(self.nodes_in[0].flow)

    def calcValues(self):
        if self.node_in.flow ==  "unknown":
            self.calcFlow()
        elif self.node_in.pressure == "unknown":
            self.calcPressureIn()

        self.node_out.setFlow(self.node_in.flow)

    def genEqPressInKnown(self, eq_id):
        #generate equations for when input pressure is known
        # equations are returned as dictionaries

        a_dict = {}
        b_dict = {}

        node_out_id = self.nodes_out[0].node_id

        a_dict[(eq_id, node_out_id)] = np.array([1, self.r_hyd])

        b_dict[eq_id] = np.array([self.nodes_in[0].pressure])

        nodes_calced = [self.nodes_out[0]]
        num_eq = 1

        eq = [a_dict, b_dict, num_eq, nodes_calced]
        return(eq)

    def genEqPressOutKnown(self, eq_id):
        #generate equations for when input pressure is known
        # equations are returned as dictionaries

        a_dict = {}
        b_dict = {}

        node_in_id = self.nodes_in[0].node_id

        a_dict[(eq_id, node_in_id)] = np.array([1, -self.r_hyd])

        b_dict[eq_id] = np.array([self.nodes_out[0].pressure])

        nodes_calced = [self.nodes_in[0]]
        num_eq = 1

        eq = [a_dict, b_dict, num_eq, nodes_calced]
        return(eq)

    def genEq(self, eq_id):
        #print("here")
        if self.nodes_in[0].flow != "unknown":
            if self.nodes_in[0].pressure != "unknown":
                if self.node_out[0].pressure != "unknown":
                    self.nodes_out[0].setFlow(self.nodes_in[0].flow)
        elif self.nodes_out[0].flow != "unknown":
                if self.nodes_in[0].pressure != "unknown":
                    if self.node_out[0].pressure != "unknown":
                        self.nodes_in[0].setFlow(self.nodes_out[0].flow)
        elif self.nodes_in[0].pressure != "unknown":
            if self.nodes_out[0].pressure != "unknown":
                self.calcFlow()
                return("nodes solved")
            else:
                eq = self.genEqPressInKnown(eq_id)
                return(eq)
        elif self.nodes_out[0].pressure != "unknown":
            if self.nodes_in[0].flow != "unknown":
                self.calcPressureIn()
                return("nodes solved")
            else:
                eq = self.genEqPressOutKnown(eq_id)
                return(eq)
        else:
            return("case not defined")

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

class Model(object):
    def __init__(self):
        self.node_list = []
        self.component_list = []
        self.node_count = 0
        self.component_count = 0
        self.equation_count = 0
        # nodes included in system of equations
        self.nodes_calced = []

    def addNodes(self, n):
        for i in range(n):
            self.node_count += 1
            # node id's index at 0
            node_id = self.node_count - 1

            self.node_list.append(Node(node_id))

    def setNodePressure(self, node_id, pressure):
        self.node_list[node_id].setPressure(pressure)

    def setNodeFlow(self, node_id, flow):
        self.node_list[node_id].setFlow(flow)

    def addStraightChannel(self, node_ids_in, node_ids_out, len, eta):
        self.component_count += 1
        comp_id = self.component_count - 1

        nodes_in = [self.node_list[node_ids_in[0]]]
        nodes_out = [self.node_list[node_ids_out[0]]]

        straightChannel = StraightChannel(comp_id, nodes_in, nodes_out, len, eta)

        self.component_list.append(straightChannel)

    def dispComp(self):
        for comp in self.component_list:
            print(comp.component_name, comp.comp_id)

    def findSysUnknowns(self):
        self.unknowns = []
        for node in self.node_list:
            self.unknowns.append(node.detUnknowns())
        for comp in self.component_list:
            comp.getCompUnknowns()

        self.component_list.sort(key=lambda x: x.unknowns)

    def genSysEq(self):
        self.findSysUnknowns()

        a_dict = {}
        b_dict = {}

        for comp in self.component_list:
            comp_eqs = comp.genEq(self.equation_count)
            if comp_eqs != "nodes solved":
                comp_a_dict = comp_eqs[0]
                comp_b_dict = comp_eqs[1]

                self.equation_count += comp_eqs[2]
                self.nodes_calced += comp_eqs[3]

                a_dict |= comp_a_dict
                b_dict |= comp_b_dict

        self.nodes_calced = set(self.nodes_calced)
        print(self.nodes_calced)

        A = np.zeros((self.equation_count,len(self.nodes_calced)*2))
        B = np.zeros(self.equation_count)


        for node in self.nodes_calced:
            nodes_calced_id = 0
            for key in a_dict.keys():
                if key[1] == node.node_id:
                    A[key[0], nodes_calced_id*2:nodes_calced_id*2+2] = a_dict[key]

            nodes_calced_id += 1

        for key in b_dict.keys():
            B[key:key+1] = b_dict[key]

        self.A = A
        self.B = B

    def solveSysEq(self):
        self.C = np.linalg.solve(self.A, self.B)

        for node in self.nodes_calced:
            node_number = 0
            node.setPressure(self.C[node_number*2])
            node.setFlow(self.C[node_number*2+1])
            node_number += 1

    def dispSysValues(self):
        for node in self.node_list:
            node.dispValues()

    def solveModel(self):
        self.findSysUnknowns()

        while len(self.unknowns) > 0:
            self.genSysEq(
            )
            self.solveSysEq()
            self.findSysUnknowns()
            print(len(self.unknowns))
