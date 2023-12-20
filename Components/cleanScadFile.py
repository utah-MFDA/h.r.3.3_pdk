
import argparse
import os
import regex, mmap

def remove_blacklist_phrase(platform):

    blacklist_file = "./platforms/"+platform+"/blacklist"
    merge_file = "./platforms/"+platform+"/"+platform+"_combined.scad"
    merge_clean= merge_file+".cleaned"

    blacklist = open(blacklist_file, 'r')

    print("In file: "+merge_file)

    for phrase in blacklist:
        phrase = phrase.lstrip().replace('\n','')
        print("Removing: " + phrase)
        
        with open(merge_file) as fin, open(merge_clean, "+w") as fout:
            for line in fin:
                nline = line.replace(phrase, '')
                fout.write(nline)

            # replace old file with cleaned
            os.rename(merge_clean, merge_file)

def find_modules(inFile_str):

    scad_header_f = open('scad_header.scad', 'r')

    newFile = open(inFile_str+"_clean", 'w')

                       #0        1         2         3         4         5         6
                       #123456789012345678901234567890123456789012345678901234567890
    
    module_re = bytes(r"module\s*\w*\s*\(([a-zA-Z0-9_=,]*\s*)*\)|\{(?:[^}{]+|(?R))*+\}", 'utf-8')
    #module_re = bytes(r"module\s*\w*\s*\(([a-zA-Z0-9_=,]*\s*)*\)|\{(?>[^}{]+|\g<0>)*\}", 'utf-8')
    #module_re = bytes(r"module\s*\w*\s*\(([a-zA-Z0-9_=,]*\s*)*\)\{(.*\s)*\}", 'utf-8')

    newFile.write(''.join([line for line in scad_header_f]))

    with open(inFile_str, 'r+') as f:
        data = mmap.mmap(f.fileno(), 0)
        mo = regex.finditer(module_re, data)

        if mo:
            newFile.write('\n'.join([ x.group().decode('utf-8') for x in mo ]))
            print("found module", mo)#.decode('utf-8'))

    # over write merge file; rebuild through make
    os.rename(inFile_str+"_clean", inFile_str)

if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument("--platform", type=str)

    parser.add_argument("--merge_file", type=str)

    args = parser.parse_args()

    #remove_blacklist_phrase(args.platform)
    find_modules(args.merge_file)