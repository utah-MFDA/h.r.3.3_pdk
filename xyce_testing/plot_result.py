
import pandas as pd
import matplotlib.pyplot as plt


def plot_prn(results_file):
    
    temp_df = pd.read_table(results_file, skipfooter=1, index_col=0, delim_whitespace=True)
    
    x = temp_df["TIME"]
    y = {}

    for col in temp_df.keys():
        if col == "TIME":
            continue
        else:
            y[col] = temp_df[col]

    fig, ax = plt.subplots()

    for p in y:
        ax.plot(x, y[p], label=p)

    ax.legend()
    plt.show()


if __name__ == "__main__":

    prn_dir = "MFlibrary_testing/stdcellTesting/membrane_cap/results"
    #prn_dir = "MFlibrary_testing/stdcellTesting/membrane_cap/"

    prn_file = "mem_cap_test_v_1_1.cir.prn"

    plot_prn(prn_dir+'/'+prn_file)

    prn_file = "mem_cap_test_v_1_2.cir.prn"

    plot_prn(prn_dir+'/'+prn_file)