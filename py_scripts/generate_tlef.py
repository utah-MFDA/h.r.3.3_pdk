import sys
maxmet=int(sys.argv[1])
print("""VERSION 5.7 ;

BUSBITCHARS "[]" ;
DIVIDERCHAR "/" ;

UNITS
  DATABASE MICRONS 1000 ;
END UNITS

MANUFACTURINGGRID 1.0 ;

PROPERTYDEFINITIONS
  LAYER LEF58_TYPE STRING ;
END PROPERTYDEFINITIONS

SITE CoreSite
  CLASS CORE ;
  SYMMETRY Y ;
  SIZE 30 BY 240 ;
END CoreSite

SITE IO_TOP
  CLASS PAD ;
  SIZE 10 BY 10 ;
END IO_TOP

SITE IO_SIDE
  CLASS PAD ;
  SIZE 10 BY 140 ;
END IO_SIDE

SITE IO_CORNER
  CLASS PAD ;
  SIZE 330 BY 330 ;
END IO_CORNER

""")

print("""LAYER met1
  TYPE ROUTING ;
  DIRECTION HORIZONTAL ;
  MINWIDTH 0.45 ;
  WIDTH 0.45 ;
END met1
""")

for i in range(2, maxmet+1):
    direction = "VERTICAL" if not i%2 else "HORIZONTAL"
    print(f"""LAYER via{i-1}
  TYPE CUT ;
  WIDTH 0.45 ;
END via{i-1}

LAYER met{i}
  TYPE ROUTING ;
  DIRECTION {direction} ;
  MINWIDTH 0.45 ;
  WIDTH 0.45 ;
END met{i}
""")
for i in range(1, maxmet):
    print(f"""VIA M{i}M{i+1}_PR DEFAULT
  LAYER via{i} ;
    RECT -0.225 -0.225 0.225 0.225 ;
  LAYER met{i} ;
    RECT -0.225 -0.225 0.225 0.225 ;
  LAYER met{i+1} ;
    RECT -0.225 -0.225 0.225 0.225 ;
END M{i}M{i+1}_PR
""")

print("END LIBRARY")
