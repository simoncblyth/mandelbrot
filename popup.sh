#!/bin/bash -l 
cd $(dirname $BASH_SOURCE)
name=popup
${IPYTHON:-ipython} --pdb -i $name.py 
