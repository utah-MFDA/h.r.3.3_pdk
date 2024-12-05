import sys
import argparse

parser = argparse.ArgumentParser()
# parser.add_argument("--layer", "-l", default=3)
parser.add_argument("--min", default=1, type=int)
parser.add_argument("--max", default=6, type=int)

args = parser.parse_args(sys.argv[1:])

# layer_number = args.layer
min_layer = args.min
max_layer = args.max
for layer_number in range(min_layer, max_layer):
    print(f"""MACRO pinhole_325px_met{layer_number}
  CLASS PAD ;
  ORIGIN 0 0 ;
  FOREIGN pinhole_325px_met{layer_number} ;
  SIZE 140 BY 330 ;
  SYMMETRY X Y R90 ;
  PIN hole
    DIRECTION INOUT ;
    USE SIGNAL ;
    PORT
      LAYER met{layer_number} ;
        RECT 69 325 71 327 ;
    END
  END hole
  PIN pad
    DIRECTION INOUT ;
    USE SIGNAL ;
    PORT
      LAYER met10 ;
        RECT 69 0 71 2 ;
    END
  END pad""")

    print("OBS")
    for obs in range(min_layer, max_layer):
        if obs < (layer_number - 3) or  obs > (layer_number + 3):
            continue
        print(f"""    LAYER met{obs} ;
      RECT 0 0 140 330 ;""")
    print(f"""  END""")
    print(f"""END pinhole_325px_met{layer_number}""")
