# Sophia Nielsen, sophi.nielsen@utah.edu

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

class Channel(Component):
    """docstring for straight_channel."""

    def __init__(self, comp_id, nodes_in, nodes_out, len, eta):
        super().__init__(comp_id, nodes_in, nodes_out)

        self.eta = eta

        # node connects added when component defined
        self.nodes_in[0].connects_out.append(self.nodes_out[0])
        self.nodes_out[0].connects_in.append(self.nodes_in[0])

    def calcPressureOut(self):
        self.nodes_out[0].setPressure(self.nodes_in[0].pressure - self.nodes_in[0].flow*self.r_hyd)

    def calcPressureIn(self):
        self.nodes_in[0].setPressure(self.nodes_out[0].pressure + self.nodes_in[0].flow*self.r_hyd)

    def calcFlow(self):
        self.nodes_in[0].setFlow((self.nodes_in[0].pressure-self.nodes_out[0].pressure)/self.r_hyd)


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

    def genEqFlowKnown(self, eq_id, flow):
        # generate equations for when flow is unknown

        a_dict = {}
        b_dict = {}

        node_in_id = self.nodes_in[0].node_id
        node_out_id = self.nodes_out[0].node_id

        a_dict[(eq_id, node_in_id)] = np.array([1, 0])
        b_dict[eq_id] = np.array([self.r_hyd*flow])


    def genEq(self, eq_id):
        val = "case not set"
        case_id = [0,0,0,0]
        p_in = self.nodes_in[0].pressure
        p_out = self.nodes_out[0].pressure
        f_in = self.nodes_in[0].flow
        f_out = self.nodes_out[0].flow

        # set case id (p_in, f_in, p_out, f_out)
        # 1 = known, 0 = unknown
        if p_in != "unknown":
            case_id[0] = 1
        if f_in != "unknown":
            case_id[1] = 1
        if p_out != "unknown":
            case_id[2] = 1
        if f_out != "unknown":
            case_id[2]= 1

        if case_id == [1,1,1,1]:
            val = "nodes solved"
        # pressure in unknown
        elif case_id == [0,1,1,1]:
            self.calcPressureIn()
            val = "nodes solves"
        # flow in unknown
        elif case_id == [1,0,1,1]:
            self.nodes_in[0].setFlow(self.nodes_out[0].flow)
            val = "nodes solved"
        # pressure out unknown
        elif case_id == [1,1,0,1]:
            self.calcPressureOut()
            val = "nodes solved"
        # flow out unknown
        elif case_id == [1,1,1,0]:
            self.nodes_out[0].setFlow(self.nodes_in[0].flow)
            val = "nodes solved"
        elif case_id == [0,0,1,1]:
            self.nodes_in[0].setFlow(self.nodes_out[0].flow)
            self.calcPressureIn()
            val = "nodes solved"
        elif case_id == [0,1,0,1]:
            val = "case not defined " + str(case_id)
        elif case_id == [0,1,1,0]:
            self.nodes_out[0].setFlow(self.nodes_in[0].flow)
            self.calcPressureIn()
            val = "nodes solved"
        elif case_id == [1,0,0,1]:
            self.nodes_in[0].setFlow(self.nodes_out[0].flow)
            self.calcPressureOut()
            val = "nodes solved"
        elif case_id == [1,0,1,0]:
            self.calcFlow()
            self.nodes_out[0].setFlow(self.nodes_in[0].flow)
            val = "nodes solved"
        elif case_id == [1,1,0,0]:
            self.nodes_out[0].setFlow(self.nodes_in[0].flow)
            self.calcPressureOut()
            val = "nodes solved"
        elif case_id == [1,0,0,0]:
            val = self.genEqPressInKnown(eq_id)
        elif case_id == [0,1,0,0]:
            #val = "case not defined " + str(case_id)
            self.nodes_out[0].setFlow(self.nodes_in[0].flow)
            val = "nodes solved"
        elif case_id == [0,0,1,0]:
            val = self.genEqPressOutKnown(eq_id)
        elif case_id == [0,0,0,1]:
            vval = "case not defined " + str(case_id)
        elif case_id == [0,0,0,0]:
            val = "case not defined " + str(case_id)
        else:
            val = "case does not exist"

        # if self.nodes_in[0].flow != "unknown":
        #     if self.nodes_in[0].pressure != "unknown":
        #         if self.nodes_out[0].pressure != "unknown":
        #             if self.nodes_in[0].pressure != "unknown":
        #                 self.nodes_out[0].setFlow(self.nodes_in[0].flow)
        #                 val = "nodes solved"
        #             else:
        #                 self.calcFlow()
        #                 val = "nodes solved"
        # elif self.nodes_out[0].flow != "unknown":
        #         if self.nodes_in[0].pressure != "unknown":
        #             if self.nodes_out[0].pressure != "unknown":
        #                 self.nodes_in[0].setFlow(self.nodes_out[0].flow)
        #                 val = "nodes solved"
        # elif self.nodes_in[0].pressure != "unknown":
        #     if self.nodes_out[0].pressure != "unknown":
        #         self.calcFlow()
        #         val = "nodes solved"
        #     else:
        #         val = self.genEqPressInKnown(eq_id)
        # elif self.nodes_out[0].pressure != "unknown":
        #     if self.nodes_in[0].flow != "unknown":
        #         self.calcPressureIn()
        #         val  = "nodes solved"
        #     else:
        #         val = self.genEqPressOutKnown(eq_id)
        # else:
        #     val = "case not defined"
        return(val)

class StraightChannel(Channel):
    def __init__(self, comp_id, nodes_in, nodes_out, len, eta):
        super().__init__(comp_id, nodes_in, nodes_out, len, eta)

        self.len = len

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
#TODO
class SerpentineChannel(Channel):
    """docstring for straight_channel."""

    def __init__(self, comp_id, nodes_in, nodes_out, footprint_width, eta):

        super().__init__(comp_id, nodes_in, nodes_out, len, eta)

        self.footprint_width = footprint_width
        self.component_name = "Serpentine Channel"
        self.calcResistence()

    def calcResistence(self):

        microns_per_pixel = 7.6
        microns_per_layer = 10
        meters_per_micron = 0.000001

        channel_spacing_pixels = 14

        # for cross section 1
        width_pixels = 14;
        hieght_layers = 8;

        channel_spacing = channel_spacing_pixels*microns_per_pixel*meters_per_micron

        width_meters = width_pixels*microns_per_pixel*meters_per_micron
        hieght_meters = hieght_layers*microns_per_layer*meters_per_micron

        bends = self.footprint_width/(width_meters+channel_spacing)

        self.effective_footprint_width = bends*(width_meters+channel_spacing)

        self.len = bends*self.effective_footprint_width + self.effective_footprint_width

        self.r_hyd = (12*self.eta*self.len)/(1 - 0.63*(hieght_meters/width_meters)) * 1/(hieght_meters**3/width_meters)

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

    def addSerpentineChannel(self, node_ids_in, node_ids_out, footprint_width, eta):
        self.component_count += 1
        comp_id = self.component_count - 1

        nodes_in = [self.node_list[node_ids_in[0]]]
        nodes_out = [self.node_list[node_ids_out[0]]]

        serpentineChannel = SerpentineChannel(comp_id, nodes_in, nodes_out, footprint_width, eta)

        self.component_list.append(serpentineChannel)

    def dispComp(self):
        for comp in self.component_list:
            print(comp.component_name, comp.comp_id)

    def findSysUnknowns(self):
        self.unknowns = []
        for node in self.node_list:
            self.unknowns += node.detUnknowns()
        for comp in self.component_list:
            comp.getCompUnknowns()

        self.component_list.sort(key=lambda x: x.unknowns)

    def genSysEq(self):
        self.equation_count = 0
        self.findSysUnknowns()

        a_dict = {}
        b_dict = {}

        for comp in self.component_list:
            print("solving component: ", comp.comp_id, comp.component_name)
            comp_eqs = comp.genEq(self.equation_count)
            if isinstance(comp_eqs, str):
                if comp_eqs != "nodes solved":
                    print("exception:", comp_eqs)
                    self.exception = True
            else:
                if comp_eqs != "nodes solved":
                    comp_a_dict = comp_eqs[0]
                    comp_b_dict = comp_eqs[1]

                    self.equation_count += comp_eqs[2]
                    self.nodes_calced += comp_eqs[3]

                    a_dict |= comp_a_dict
                    b_dict |= comp_b_dict

        self.nodes_calced = list(set(self.nodes_calced))

        A = np.zeros((self.equation_count,len(self.nodes_calced)*2))
        B = np.zeros(self.equation_count)

        for node in self.nodes_calced:
            nodes_calced_id = 0
            for key in a_dict.keys():
                if key[1] == node.node_id:
                    A[key[0], nodes_calced_id*2:nodes_calced_id*2+2] = a_dict[key]

            nodes_calced_id += 1

        for key in b_dict.keys():
            B[key] = b_dict[key]

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

        self.exception = False
        while len(self.unknowns) > 0 & self.exception == False:
            self.genSysEq()
            if self.equation_count > 0:
                self.solveSysEq()
            self.findSysUnknowns()

        self.dispSysValues()
