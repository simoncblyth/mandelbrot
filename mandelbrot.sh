#!/bin/bash -l 
usage(){ cat << EOU
mandelbrot.sh
===============

FOCUS=-1.45,0,0.05 ~/mandelbrot/mandelbrot.sh
FOCUS=-1.45,0,0.05 MIT=80 ~/mandelbrot/mandelbrot.sh
FOCUS=-1.45,0,0.05 MIT=50 ~/mandelbrot/mandelbrot.sh

EOU
}
cd $(dirname $BASH_SOURCE)
name=mandelbrot 
defarg="build_run_ana"
arg=${1:-$defarg}

export FOLD=/tmp/$name
mkdir -p $FOLD
bin=$FOLD/$name

np_base=..
NP_BASE=${NP_BASE:-$np_base}

vars="NP_BASE name FOLD"

if [ "${arg/info}" != "$arg" ]; then
   for var in $vars ; do printf "%20s : %s \n" "$var" "${!var}" ; done 
fi 
if [ "${arg/build}" != "$arg" ]; then 
    gcc $name.cc -I$NP_BASE/np -std=c++11 -lstdc++ -lm -o $bin 
    [ $? -ne 0 ] && echo $BASH_SOURCE build error && exit 1 
fi 
if [ "${arg/run}" != "$arg" ]; then 
    $bin
    [ $? -ne 0 ] && echo $BASH_SOURCE run error && exit 2 
fi 
if [ "${arg/ana}" != "$arg" ]; then 
    ${IPYTHON:-ipython} --pdb -i $name.py 
    [ $? -ne 0 ] && echo $BASH_SOURCE ana error && exit 1 
fi 
exit 0 
