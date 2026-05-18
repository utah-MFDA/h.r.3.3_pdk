import os
import opendbpy as odb
import re
from uuid import uuid4
import math
import solid2

orientation = solid2.import_scad("openmfda/components/orientation.scad", render_relative=True)
helper = solid2.import_scad("openmfda/components/lef_helper.scad", render_relative=True)

class LefToScad:
    def __init__(self, db, master):
        self.db = db
        self.master = self.db.findMaster(master)

    def scale(self, i):
        return i / 1000

    def extract_size(self):
        w, h = map(self.scale, [self.master.getWidth(), self.master.getHeight()])
        return helper.lef_size(w, h), (w, h)

    def extract_ports(self):
        for mterm in self.master.getMTerms(): # PIN in lef
            for pin in mterm.getMPins(): # PORT in lef
                for geom in pin.getGeometry():
                    if type(geom) != odb.odb_py.dbBox:
                        print(f"Non-rectangles not handled {type(geom)}")
                        continue
                    metal = geom.getTechLayer().getName()
                    bounds = map(self.scale, [geom.xMin(), geom.yMin(), geom.xMax(), geom.yMax()])
                    yield helper.lef_layer(metal)(helper.lef_port(mterm.getName(), mterm.getName(), "RECT", bounds))

    def extract_obs(self):
        for obs in self.master.getObstructions():
            bounds = map(self.scale, [obs.xMin(), obs.yMin(), obs.xMax(), obs.yMax()])
            metal = obs.getTechLayer().getName()
            yield helper.lef_layer(metal)(helper.lef_obs("RECT", bounds))

    def dump(self, path, name):
        size, bounds = self.extract_size()
        obs = solid2.union()(list(self.extract_obs()))
        ports = solid2.union()(list(self.extract_ports()))
        child = obs + ports + size
        name = self.master.getName()
        mod = solid2.scad_inline(f"module {name}_lef() {{") + child + solid2.scad_inline("}")
        solid2.scad_render_to_file(mod, path)
        # print(f"module {name}", file=f)
        # print("{", file=f)
        # print("\tlef_size({x}, {y});")
        # print("}", file=f)

def extract_macro_names(files):
    pattern = r"MACRO (\S+)"
    for fn in files:
        with open(fn) as f:
            for line in f.readlines():
                for match in re.finditer(pattern, line):
                    yield match[1]

if __name__ == "__main__":
    import argparse

    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--tlef', '-t', metavar='<path>', action='append', dest='tlef_files', type=str,
                    help="Path to .tlef file.", required=True)
    ap.add_argument('--lef', '-l', metavar='<path>', action='append', dest='lef_files', type=str, required=True,
                    help="Path to .lef file.")
    ap.add_argument('--output', '-o', metavar='<path>', type=str, help="Path to output footprint files.", dest="output", required=True)
    args = ap.parse_args()
    db = odb.dbDatabase.create()
    masters = list(extract_macro_names(args.lef_files))
    assert(len(masters) == 1)
    master = masters[0]
    for tlef_file in args.tlef_files:
        odb.read_lef(db, tlef_file)
    for lef_file in args.lef_files:
        odb.read_lef(db, lef_file)
    t = LefToScad(db, master)
    t.dump(args.output, master)

