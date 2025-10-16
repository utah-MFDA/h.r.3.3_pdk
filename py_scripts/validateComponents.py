

import argparse
import os
import pandas as pd
import numpy as np

"""
A script that was itended to validate at the component files for each respective part
    exists and that the headers match. Not being worked on currently.
"""


def check_lef_file(lef_file):
    pass


def check_scad_file(scad_file):
    pass


def check_va_file(va_file):
    pass


def check_dir(dir_list):

    comp_check = pd.DataFrame(columns=['Standard_Cell', 'lef', 'va', 'scad'])
    comp_lib = pd.DataFrame(columns=['Standard_Cell'])

    for dir in dir_list:

        # get subdirectories
        print("searching for components in "+dir +
              ": "+str([x[1] for x in os.walk(dir)][0]))

        for comp in [x[1] for x in os.walk(dir)][0]:

            file_base = dir+'/'+comp+'/'

            comp_check = pd.concat([comp_check,
                                    pd.DataFrame(np.array([(comp, 0, 0, 0)]),
                                                 columns=['Standard_Cell', 'lef', 'va', 'scad'])],
                                   ignore_index=True, axis=0)

            comp_ind = comp_check[comp_check['Standard_Cell'] == comp].index[0]

            print("check for component, "+comp+"; @ "+file_base)

            # check for existing file of sub_directory.ext
            if os.path.isfile(file_base+comp+'.lef'):
                comp_check['lef'].iloc[comp_ind] = 1
                print("  found "+file_base+comp+'.lef')

            if os.path.isfile(file_base+comp+'.va'):
                comp_check['va'].iloc[comp_ind] = 1
                print("  found "+file_base+comp+'.va')

            if os.path.isfile(file_base+comp+'.scad'):
                comp_check['scad'].iloc[comp_ind] = 1
                print("  found "+file_base+comp+'.scad')

            # print(comp_check[comp_check['StandardCell'] == comp][['lef', 'va', 'scad']])

            if comp_check[comp_check['Standard_Cell'] == comp][['lef', 'va', 'scad']].values.tolist() \
                    == [[1, 1, 1]]:
                comp_lib = pd.concat([comp_lib, pd.DataFrame(np.array([(comp)]),
                                                             columns=['Standard_Cell'])])

    comp_check.to_csv('Component_Check.csv')
    comp_lib.to_csv('StandardCellLibrary.csv')


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        prog="",
        description="",
        epilog=""
    )

    parser.add_argument('--component_dir',
                        metavar='<component_dir>', type=str, nargs='*')

    args = parser.parse_args()

    components = check_dir(args.component_dir)
