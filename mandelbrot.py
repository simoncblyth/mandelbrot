#!/usr/bin/env python
"""
mandelbrot.py 
==============

"""
import os, numpy as np
SIZE = np.array([1280, 720])
import matplotlib.pyplot as plt

def IsRemoteSession():
    """ 
    Heuristic to detect remote SSH session 
    """
    has_SSH_CLIENT = not os.environ.get("SSH_CLIENT", None) is None 
    has_SSH_TTY = not os.environ.get("SSH_TTY", None) is None 
    return has_SSH_CLIENT or has_SSH_TTY


def read_npy(path, d):
    path = os.path.expandvars(path)
    a = np.load(path)
    if not d is None:
        txtpath = path.replace(".npy","_meta.txt")
        lines = open(txtpath).read().splitlines()
        for line in lines:
            key, val = line.split(":")
            d[key] = val
        pass 
    pass
    return a

if __name__ == '__main__':

    d = dict()
    a = read_npy("$FOLD/a.npy", d)

    d["CMAP"] = os.environ.get("CMAP", "prism")
    cmap = getattr(plt.cm, d["CMAP"], None)
    d["extent"] = list(map(float,(d["xmin"], d["xmax"], d["ymin"], d["ymax"] )))
    d["ami"] = a.min()
    d["amx"] = a.max()

    label = "mandelbrot.sh : CMAP %(CMAP)s FOCUS %(FOCUS)s MZZ %(MZZ)s" 
    label += " MIT %(MIT)s extent %(extent)s ami %(ami)d amx %(amx)d "
    print(label % d)

    fig, ax = plt.subplots(figsize=SIZE/100.)  
    fig.suptitle(label % d)
    ax.imshow(a, extent=d["extent"], cmap=cmap) 

    if IsRemoteSession():
        outpath = os.environ.get("OUTPATH", "mandelbrot.png")
        print("IsRemoteSession detected saving to OUTPATH outpath %s " % outpath)
        plt.savefig(outpath)
    else:
        print("NOT:IsRemoteSession try to pop up a window")
        fig.show()
    pass



