import mmap, re, os, regex

lef_mod_reg = bytes(
    r'^[ ]*module\s+(?P<module_name>\w+)\s*\([^\)\(]*\)\s*\{[\s\S]*(module\s+lef\s*\(\s*\)\s*\{[\s*\w*\(\),=."\-;\[\]]*\})',
    #r'^[ ]*module\s+(?P<module_name>\w+)\s*\([\s*\w*\(\),=."\-;\[\]\/\$]*\)\s*\{[\s*\w*\(\),=."\-;\[\]\/\$]*(module\s+lef\s*\(\s*\)\s*\{[\s*\w*\(\),=."\-;\[\]]*\})',  # fmt: skip
    "utf-8",
)
lef_parts_reg = bytes(
    r'^[ ]*(?:lef_layer\s*\(\s*"(?P<layer>\w+)"\)|)\s*(?P<lef_type>lef_port|lef_obs|lef_size)\s*\(\s*(?:(?:"(?P<port_name>\w+)"\s*,\s*"(?P<direction>INPUT|OUTPUT|INOUT)"\s*,|)\s*"(?P<shape>\w*)"\s*,\s*\[(?P<pts>[\s\-.,\d]*)\]\s*\)\s*;|\s*(?P<x>\d*)\s*,\s*(?P<y>\d*)\s*\)\s*;)',  # fmt: skip
    "utf-8",
)


class LEF_SCAD:

    def __init__(self, module_name):
        self.module_name = module_name
        self.obs = []
        # general obs in []
        #   [{"layer":met, "shape":shape, "pts":[]}]
        self.pins = {}
        # general pins in {}
        #   {"pin_name":{"layer":met, "shape":shape, "pts":[]}
        self.size = []

    def add_obs(self, layer, shape, pts):
        self.obs.append({"layer": layer, "shape": shape, "pts": pts})

    def add_pin(self, name, dir, layer, shape, pts):
        if name in self.pins:
            print(f"Duplicate pin {name}")
        self.pins[name] = {"direction":dir, "layer": layer, "shape": shape, "pts": pts}

    def set_size(self, x, y):
        self.size = [x, y]


def parse_lef(in_scad_f, ignore_no_lef=False, silent_find=False):

    with open(in_scad_f, "r+") as f:
        data = mmap.mmap(f.fileno(), 0)
        mo_lef = regex.findall(lef_mod_reg, data, re.MULTILINE)
        if mo_lef == []:
            if ignore_no_lef:
                print(f"No lef module found in {in_scad_f}, not writing module")
                return None
            raise Exception(f"No lef module in scad file {in_scad_f}")
        #print(mo_lef[0][1])
        mo = re.finditer(
            lef_parts_reg,
            mo_lef[0][1],
            re.MULTILINE,
        )
        #print(mo)

    lef_scad = LEF_SCAD(mo_lef[0][0].decode('utf-8'))

    def get_pts(pts):
        pts_l = []
        # print(part.group("pts"))
        for p in pts.split(","):
            pts_l.append(p.strip())
        return pts_l

    # print(mo)
    for part in mo:
        if not silent_find:
            print(part[0].decode('utf-8'))
        lef_type = part.group("lef_type").decode('utf-8')
        if lef_type == "lef_obs":

            lef_scad.add_obs(
                part.group("layer").decode("utf-8"),
                part.group("shape").decode("utf-8"),
                get_pts(part.group("pts").decode("utf-8")),
            )
        elif lef_type == "lef_port":
            lef_scad.add_pin(
                part.group("port_name").decode("utf-8"),
                part.group("direction").decode("utf-8"),
                part.group("layer").decode("utf-8"),
                part.group("shape").decode("utf-8"),
                get_pts(part.group("pts").decode("utf-8")),
            )
        elif lef_type == "lef_size":
            lef_scad.set_size(
                part.group('x').decode('utf-8'),
                part.group('y').decode('utf-8'))

        else:
            raise Exception(f"Unexpected type '{lef_type}', expecting lef_obs, lef_port, lef_size")

    return lef_scad


def write_lef(out_f, lef_scad):

    with open(out_f, "w+") as of:
        of.write(
            f"""
MACRO {lef_scad.module_name}
  CLASS CORE ;
  ORIGIN  0 0 ;
  FOREIGN {lef_scad.module_name} 0 0 ;
  SIZE {lef_scad.size[0]} BY {lef_scad.size[1]} ;
  SYMMETRY X Y ;
  SITE CoreSite ;"""
        )
        for p in lef_scad.pins:
            of.write(
                f"""
  PIN {p}
    DIRECTION {lef_scad.pins[p]["direction"]} ;
    USE SIGNAL ;
    PORT
      LAYER {lef_scad.pins[p]["layer"]} ;
        RECT {" ".join(lef_scad.pins[p]["pts"])} ;
    END
  END {p}"""
            )
        of.write("\n  OBS")
        for obs in lef_scad.obs:
            of.write(
                f"""
    LAYER {obs["layer"]} ;
      RECT {' '.join(obs["pts"])} ;""")
        of.write("\n  END")
        of.write(
            f"""
  PROPERTY CatenaDesignType "deviceLevel" ;
END {lef_scad.module_name}
"""
        )


def extract_lef_from_scad(in_scad, out_f=None, ignore_no_lef=False, silent=False):
    lef_scad = parse_lef(in_scad, ignore_no_lef, silent)
    if lef_scad is None:
        return
    if out_f is None:
        if "/" in in_scad:
            base_path = os.path.dirname(in_scad) + '/'
        else:
            base_path = "./"
        out_f = base_path + os.path.basename(in_scad)[:-4] + "lef"
    print(f"writing to {out_f}")
    write_lef(out_f, lef_scad)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument("--scad", type=str, required=True)
    parser.add_argument("--of", type=str, default=None)
    parser.add_argument("--ignore_no_lef_module", action='store_true', default=False)
    parser.add_argument('-q', "--silent", action='store_true', default=False)

    args = parser.parse_args()

    extract_lef_from_scad(args.scad, args.of, args.ignore_no_lef_module, args.silent)
