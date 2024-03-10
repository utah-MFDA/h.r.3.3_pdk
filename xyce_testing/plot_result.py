
import pandas as pd
import matplotlib.pyplot as plt

import re
import os, shutil

def load_prn(results_file, plot_nodes=None, plot_type=None):

    return pd.read_table(results_file, 
                        engine='python', 
                        skipfooter=1, 
                        index_col=0, 
                        #delim_whitespace=True, 
                        sep='\s+')

def sum_cur(time, i, set_time_inter=None):
    
    i_sum = 0
    t_sl = [0,0]
    if set_time_inter is not None:
        if isinstance(set_time_inter, list) and len(set_time_inter) == 2:
            for ind, ti in enumerate(set_time_inter):
                for t_ind, t in enumerate(time):
                    if t >= ti:
                        t_sl[ind] = t_ind
                        print(t_ind)
                        break
            time = time.iloc[t_sl[0]:t_sl[1]].reset_index(drop=True)
    print("start:"+str(t_sl[0])+" end:"+str(t_sl[1]))
    print(i[t_sl[0]:t_sl[1]])
    for ind, t in enumerate(time):
        if ind == 0:
            continue
        else:
            idt = (i[ind] + i[ind-1])
            #if   idt > 0:
            #    print(idt)
            i_sum += (idt)*(time[ind] - time[ind-1])/2
    return i_sum

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
    
def run_xyce(lib, cir):
    if not os.path.isfile(lib):
        raise ValueError(lib + " library file does not exist") 

    if not os.path.isfile(cir):
        raise ValueError(cir + " not able to find ciruit file") 

    cir_root, fname = os.path.split(cir)
    
    subprocess.run(['sh', './../run_test.sh', lib, cir, cir_root])

component_loc = './../Components/'
xyce_build    = '/usr/local/bin/buildxyceplugin -o'.split(' ')

def build_and_run(cir, modules):
    cir_root, fname = os.path.split(cir)
    src_path = cir_root+'/.'+fname+'_src'
    os.mkdir(src_path)

    lib_file = component_loc+'/veriloga_objects/MFXyce'
    shutil.copy(lib_file, src_path+'/ComponentLib')
    
    for m in modules:
        if len(m) == 2:
            mfile = component_loc+'/'+m[0]+'/'+m[1]+'/'+m[1]+'.va'
        elif len(m) == 3:
            mfile = component_loc+'/'+m[0]+'/'+m[1]+'/'+m[2]+'.va'
        shutil.copyfile(mfile, src_path)
    subprosses.run(xyce_build)

    lib = src_path+'/'
                             
    run_and_plot(lib, cir, plot_type=None, plot_nodes=None)

def run_and_plot(lib, cir, plot_type=None, plot_nodes=None, cir_path=None):

    cir_root, fname = os.path.split(cir)
    cir_a = cir_root+'/'+cir
    prn   = cir_root+'/results/'+cir+'.prn'
    
    run_xyce(lib, cir_a)
    
    # only the definition above needs to be changed
    run_xyce(lib, cir_a)
    if plot_type is not None:
        for ind, ty in enumerate(plot_type):
            if plot_node is not None:
                n=plot_nodes[ind]
            else:
                n=None
            plot_r(prn, plot_type=ty, plot_nodes=n)
    else:
        plot_r(prn, plot_type=None, plot_nodes=plot_nodes)
        

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
