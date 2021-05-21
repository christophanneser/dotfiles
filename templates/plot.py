import matplotlib as mpl
from matplotlib import pyplot as plt
from matplotlib import rc
import numpy as np
import os
import pandas as pd
import seaborn as sns

rc('text', usetex=True)

sns.set_theme()  # seaborn
CB_color_cycle = ['#377eb8', '#ff7f00', '#4daf4a', '#f781bf',
                  '#a65628', '#984ea3', '#999999', '#e41a1c', '#dede00']

mpl.rcParams['axes.prop_cycle'] = mpl.cycler(color=CB_color_cycle)

DATA_FOLDER = "data/"
OUTPUT_FOLDER = "plots/"
FILE_NAME = "plot.pdf"

FIG_ROWS = 1
FIG_COLS = 1

fig, axes = plt.subplots(nrows=FIG_ROWS, ncols=FIG_COLS, figsize=(
    6, 3), gridspec_kw={'width_ratios': [1]})

h1, = axes.plot(range(0, 10), range(0, 10), label="linear function")

handles = [h1, ]
legend = fig.legend(handles=handles)

fig.savefig(OUTPUT_FOLDER + FILE_NAME,
            bbox_extra_artists=(legend,), bbox_inches='tight')
# crop blank space at margins
os.system("pdfcrop {0} {0}".format(OUTPUT_FOLDER + FILE_NAME))
