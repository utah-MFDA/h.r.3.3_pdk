
import os
import docker

"""
This module was being developed to have the flow not depend on make. Currently not being
    worked on
"""


KIT_NAME = "HR3.3"

SOURCE_DIR = [
    "valves",
    "serpentine",
    "mixer"]


# verilog-a material
VA_BUILD = "verilogA_build"

VA_EX_SRC = ['veriloga_objects']

VA_BUILD_LOC = 'usr/local/xyce_dev/bin'
VA_BUILD_COM = VA_BUILD_LOC+'/buildxyceplugin.sh -o '

MF_LIB = 'MFXyce'

VA_DOCKER_IMG = 'bgoenner/mfda_xyce:latest'

#docker_va_build_run = 

# lef material
LEF_EX_SRC = []

# scad material
SCAD_EX_SRC = ['scad_objects']
SCAD_USE    = 'scad_use'


sc_root = os.path.dirname(os.path.abspath(__file__))


def make_va_lib():

    os.makedirs(sc_root+'/'+VA_BUILD+'/lib')

    docker.run( 
        image=VA_DOCKER_IMG,
        command='make build_remote',
        stdout=True,
        volumes={sc_root : {'bind':'/mfda_simulation/local/Components', 'mode':'rw'}},
        working_dir='/mfda_simulation/local/Components',
        entrypoint='',
        remove=True)

MERGE_SCAD = KIT_NAME+'_merged.scad'

def make_scad():

    scad_file = sc_root+'/'+MERGE_SCAD

    if os.isfile(scad_file):
        os.remove(scad_file)

    scad_o = open(scad_file, 'w+')

    src_dir = [sc_root+'/'+x for x in SOURCE_DIR]

    for sr_f in src_dir:
        if os.isfile(sr_f):
            with open(sr_f, 'r'):
                infile = sr_c.read()
                for line in infile:
                    scad_o.write(line)
                scad_o.write('\n\n')

def make_lef():

    pass
