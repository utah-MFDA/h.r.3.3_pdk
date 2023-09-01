
import argparse
import os

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


if __name__ == "__main__":

    parser = argparse.ArgumentParser()

    parser.add_argument("--platform", type=str)

    args = parser.parse_args()

    remove_blacklist_phrase(args.platform)