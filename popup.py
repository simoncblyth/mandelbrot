#!/usr/bin/env python

import matplotlib
# matplotlib.use('GTK3Agg')   
# might be possible to get remote X11 to work with this
# but dont bet on it, and dont expect much from performance
# or appearance 
import matplotlib.pyplot as plt 

import numpy as np
SIZE = np.array([1280, 720])

if __name__ == '__main__':
    fig, ax = plt.subplots(figsize=SIZE/100.)  
    fig.suptitle("popup.py")
    fig.show()

