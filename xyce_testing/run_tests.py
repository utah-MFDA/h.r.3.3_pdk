
import os
import argparse

def run_xyce(xy_file, lib, output_f=None):
    if output_f == None:
        output_f == file.log
    run_cmd = ["Xyce", "-plugin", lib, xy_file, ">", output_f]
    os.subprocess(run_cmd)


#def get_list_required_componenets(xy_file):

if __name__ == "__main__":

    pass
