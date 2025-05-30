import os
import shutil
import errno
import argparse
from sys import platform

# windows path is assigned again for due to how directories are labeled
pdk = 'h.r.3.3'
base_dir = os.path.dirname(os.path.abspath(__file__))

parser = argparse.ArgumentParser()

parser.add_argument('--prefix', default=None)
parser.add_argument('--scad_lib_path', default=None)
parser.add_argument('--unmerged', default=False, action="store_true")

args = parser.parse_args()

if platform == "win32":
    if args.install_unmerged:
        src_dir = base_dir + "\\scad_include"
    else:
        src_dir = base_dir + "\\scad_lib"
else:
    if args.unmerged:
        src_dir = base_dir + "/scad_include"
    else:
        src_dir = base_dir + "/scad_lib"


def cp_to_lib_location(lib_cp_to, src_lib):
    os.makedirs(lib_cp_to, exist_ok=True)
    print(f"Installing {pdk} library to {lib_cp_to}")
    try:
        shutil.copytree(src_lib, lib_cp_to, dirs_exist_ok=True, )
    except OSError as exc:  # python >2.5
        if exc.errno in (errno.ENOTDIR, errno.EINVAL):
            shutil.copy(src_lib, lib_cp_to)
        else:
            raise


if args.prefix is not None and args.scad_lib_path is not None:
    raise ValueError("Only prefix or scad_lib_path can be used, not both")
elif args.prefix is not None:
    if platform == "win32":
        cp_to_lib_location(args.prefix+f'\\{pdk}', src_dir)
    else:
        cp_to_lib_location(args.prefix+f'/{pdk}', src_dir)
elif args.scad_lib_path is not None:
    if platform == "win32":
        cp_to_lib_location(args.scad_lib_path+f'\\{pdk}', src_dir)
    else:
        cp_to_lib_location(args.scad_lib_path+f'/{pdk}', src_dir)
else:
    if platform == "linux" or platform == "linux2":
        lin_scad_lib_loc = f"{os.environ['HOME']}/.local/share/OpenSCAD/libraries"
        if not os.path.exists(lin_scad_lib_loc):
            raise ValueError(
                f"Cannot find SCAD libary location: {lin_scad_lib_loc}, is OpenSCAD installed?")
        lin_scad_lib_loc += f'/{pdk}'
        cp_to_lib_location(lin_scad_lib_loc, src_dir)

    elif platform == "darwin":
        osx_scad_lib_loc = f"{os.environ['HOME']}/Documents/OpenSCAD/libraries"
        if not os.path.exists(osx_scad_lib_loc):
            raise ValueError(
                f"Cannot find SCAD libary location: {osx_scad_lib_loc}, is OpenSCAD installed?")
        osx_scad_lib_loc += f'/{pdk}'
        cp_to_lib_location(osx_scad_lib_loc, src_dir)

    elif platform == "win32":
        win_scad_lib_loc = "My Documents\\OpenSCAD\\libraries"
        if not os.path.exists(win_scad_lib_loc):
            raise ValueError(
                f"Cannot find SCAD libary location: {win_scad_lib_loc}, is OpenSCAD installed?")

        # reassigned path
        win_scad_lib_loc += f'\\{pdk}'
        cp_to_lib_location(win_scad_lib_loc, src_dir)
