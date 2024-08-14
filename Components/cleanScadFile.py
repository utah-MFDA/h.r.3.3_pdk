import argparse
import os
import sys
import re
import regex, mmap


def remove_blacklist_phrase(platform):

    blacklist_file = "./platforms/" + platform + "/blacklist"
    merge_file = "./platforms/" + platform + "/" + platform + "_combined.scad"
    merge_clean = merge_file + ".cleaned"

    blacklist = open(blacklist_file, "r")

    print("In file: " + merge_file)

    for phrase in blacklist:
        phrase = phrase.lstrip().replace("\n", "")
        print("Removing: " + phrase)

        with open(merge_file) as fin, open(merge_clean, "+w") as fout:
            for line in fin:
                nline = line.replace(phrase, "")
                fout.write(nline)

            # replace old file with cleaned
            os.rename(merge_clean, merge_file)


def find_modules(inFile_str, overwrite_f=False, stream=False, to_stdout=False):

    scad_header_f = open("scad_header.scad", "r")

    if stream or to_stdout:
        sys.stdout.write("".join([line for line in scad_header_f]))
    else:
        newFile = open(inFile_str + "_clean", "w+")
        newFile.write("".join([line for line in scad_header_f]))
        # 0        1         2         3         4         5         6
        # 123456789012345678901234567890123456789012345678901234567890
        # module_re = bytes(
        # r"^[ ]*module\s*\w*\s*\(([^\(\)]*\s*)*\)|\{(?:[^}{]+|(?R))*+\}",
        # r"^[ ]*module\s*\w*\s*\([^\(\)]*\)|\{(?:[^}{]+|(?R))*+\}",
        # r"(?:^[ ]*module\s*\w*\s*\([^\(\)]*\)\s*\{(?:[^}{]+|(?R))*+\}|\{(?:[^}{]+|(?R))*+\})+",
        # r"(?:^[ ]*module\s*\w*\s*\([^\(\)]*\)\s*|[ ]*\{(?:[^}{]+|(?R))*+\})+",
        # r"(?:(^[ ]*module\s*\w*\s*\([^\(\)]*\)\s*)|(\{(?:[^}{]+|(?R))*+\}))",
        # "utf-8",
    # )
    module_re = r"(?:^[ ]*module\s*\w*\s*\([^\(\)]*\)\s*|[ ]*\{(?:[^}{]+|(?R))*+\})+"
    # module_re = bytes(r"(?:^[ ]*module\s+\w*\s*\((?:[^\(\)])*\)\s*\{(?:[^}{]+|(?R))+\}|\{(?:[^}{]+|(?R))+\})","utf-8")
    # module_re = bytes(r"module\s*\w*\s*\(([a-zA-Z0-9_=,]*\s*)*\)|\{(?:[^}{]+|(?R))*+\}", 'utf-8')
    # module_re = bytes(r"module\s*\w*\s*\(([a-zA-Z0-9_=,]*\s*)*\)|\{(?>[^}{]+|\g<0>)*\}", 'utf-8')
    # module_re = bytes(r"module\s*\w*\s*\(([a-zA-Z0-9_=,]*\s*)*\)\{(.*\s)*\}", 'utf-8')
    sub_com_re = r"[ ]*\/\/.*\n|^[ ]+\n"
    if stream:
        data = sys.stdin.read()
        mo = regex.finditer(
            module_re,
            re.sub(sub_com_re, "", data),
            re.MULTILINE,
        )
    else:
        f = open(inFile_str, "r+")
        data = mmap.mmap(f.fileno(), 0)
        f.close()
        mo = regex.finditer(
            bytes(module_re, "utf-8"),
            re.sub(bytes(sub_com_re, "utf-8"), bytes("", 'utf-8'), data),
            re.MULTILINE,
        )

    if mo:
        # print([x.group().decode("utf-8") for x in mo])
        if stream:
            sys.stdout.write("\n".join([x.group() for x in mo]))
        elif to_stdout:
            sys.stdout.write("\n".join([x.group().decode("utf-8") for x in mo]))
        else:
            newFile.write("\n".join([x.group().decode("utf-8") for x in mo]))
            print("found module", mo)  # .decode('utf-8'))

    # over write merge file; rebuild through make
    if overwrite_f and not stream:
        os.rename(inFile_str + "_clean", inFile_str)


if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument("--platform", type=str)

    parser.add_argument("--merge_file", type=str)
    parser.add_argument(
        "--stdout", action=argparse.BooleanOptionalAction, default=False
    )
    parser.add_argument(
        "--stream", action=argparse.BooleanOptionalAction, default=False
    )

    args = parser.parse_args()

    # remove_blacklist_phrase(args.platform)
    find_modules(args.merge_file, stream=args.stream, to_stdout=args.stdout)
