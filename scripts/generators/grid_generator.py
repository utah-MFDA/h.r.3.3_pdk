import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--rows", "-r", default=8)
parser.add_argument("--columns", "-c", default=4)
parser.add_argument("--layer", "-l", default="met10")
parser.add_argument("--pad_layer", "-p", default="met10")
parser.add_argument("--wspace", default=90)
parser.add_argument("--hspace", default=90)
parser.add_argument("--port_width", default=40)
parser.add_argument("--port_height", default=40)

args = parser.parse_args(sys.argv[1:])

module = f"interconnect_{args.rows}x{args.columns}"
x = args.wspace*args.rows
y = args.hspace*args.columns
print(f"""VERSION 5.7 ;
BUSBITCHARS "[]" ;
DIVIDERCHAR "/" ;

MACRO {module}
  CLASS PAD ;
  FOREIGN {module} 0 0 ;
  SIZE {x} BY {y} ;
  ORIGIN 0 0 ;
""")

for i in range(0, args.rows):
    for j in range(0, args.columns):
        pin_name = f"pin_{i}_{j}"
        w = i * args.wspace
        x = j * args.hspace
        y = w + args.port_width
        z = x + args.port_width
        print(f"""  PIN {pin_name}
    DIRECTION INOUT ;
    USE SIGNAL ;
    PORT
      LAYER {args.layer} ;
        RECT {w} {x} {y} {z} ;
    END
  END {pin_name}""")
        print(f"""  PIN {pin_name}_pad
    DIRECTION INOUT ;
    USE SIGNAL ;
    PORT
      LAYER {args.pad_layer} ;
        RECT {w} {x} {y} {z} ;
    END
  END {pin_name}_pad""")

print(f"END {module}")
