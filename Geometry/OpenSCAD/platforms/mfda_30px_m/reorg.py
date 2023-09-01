import json


ifile = json.load(open("./port_def"))

print(ifile)

Offset_2 = {"Offset":{}}

for dir in ifile["Offset"]:
    for mod in ifile["Offset"][dir]:
        print("dir:"+dir+" mod:"+mod)
        val = ifile["Offset"][dir][mod]
        print("value: "+str(val)+"\n")

        try:
            Offset_2['Offset'][mod][dir] = val
        except KeyError:
            Offset_2['Offset'][mod] = {}
            Offset_2['Offset'][mod][dir] = val

ofile = open("new_port_def", "w+")
json.dump(Offset_2, ofile)
