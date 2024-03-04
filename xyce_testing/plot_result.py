
import pandas as pd
import matplotlib.pyplot as plt

import re

def load_prn(results_file, plot_nodes=None, plot_type=None):

    return pd.read_table(results_file, 
                        engine='python', 
                        skipfooter=1, 
                        index_col=0, 
                        #delim_whitespace=True, 
                        sep='\s+')


# plot_nodes is a list of strings
def plot_prn(results_file, plot_nodes=None, plot_type=None):
    
    temp_df = pd.read_table(results_file, 
                        engine='python', 
                        skipfooter=1, 
                        index_col=0, 
                        #delim_whitespace=True, 
                        sep='\s+')
    
    x = temp_df["TIME"]
    y = {}

    if plot_type == "pressure" or plot_type == "voltage":
        for col in temp_df.keys():
            if col == "TIME":
                continue
            elif col[:2] == "P(" or col[:2] == "V(":
                if plot_nodes == None:
                    y[col] = temp_df[col]
                else:
                    if re.findall(r'[a-zA-Z][0-9]r+', col) in plot_nodes:
                        y[col] = temp_df[col]

    elif plot_type == "flow" or plot_type == "current":
        for col in temp_df.keys():
            #print(col[:1])
            if col == "TIME":
                continue
            elif col[:2] == "Q(" or col[:2] == "I(":
                if plot_nodes==None:
                    y[col] = temp_df[col]
                else:
                    if re.findall(r'[a-zA-Z][0-9]r+', col) in plot_nodes:
                        y[col] = temp_df[col]

    elif plot_type == None:
        for col in temp_df.keys():
            if col == "TIME":
                continue
            else:
                y[col] = temp_df[col]
    else:
        raise ValueError("Invalid plot_type")

    fig, ax = plt.subplots()

    for p in y:
        ax.plot(x, y[p], label=p)

    ax.legend()
    print("plot: "+results_file.split('/')[-1])
    plt.show()


if __name__ == "__main__":

    prn_dir = "MFlibrary_testing/stdcellTesting/membrane_cap/results"
    #prn_dir = "MFlibrary_testing/stdcellTesting/membrane_cap/"

    #prn_file = "mem_cap_test_v_0_1.cir.prn"
    #plot_prn(prn_dir+'/'+prn_file)

    # membrane test
    #prn_file = "mem_cap_test_1_1.cir.prn"
    
    # electrical test
    prn_file = "mem_cap_test_v_0_2.cir.prn"
    
    plot_prn(prn_dir+'/'+prn_file)


    argparse.ArgumentParser()

    parser.add_argument('-f', '--file')
    parser.add_argument('-p', '--plots')
