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
defarg="info_build_run_ana_ls"
arg=${1:-$defarg}

#fold=/tmp/$USER/$name
fold=$HOME/g/tmp/$USER/$name
export FOLD=${FOLD:-$fold}
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
if [ "${arg/grab}" != "$arg" ]; then 
    rsync -zarv --progress --include="*/"  \
          --include="*.npy" \
          --include="*.txt" \
          --include="*.jpg" \
          --include="*.png" \
          "L7:$FOLD/" "$FOLD"

    [ $? -ne 0 ] && echo $BASH_SOURCE grab error && exit 3
fi 
if [ "${arg/ana}" != "$arg" ]; then 
    ${IPYTHON:-ipython} --pdb -i $name.py 
    [ $? -ne 0 ] && echo $BASH_SOURCE ana error && exit 4 
fi 
if [ "${arg/ls}" != "$arg" ]; then 
    echo FOLD $FOLD
    ls -l $FOLD
    [ $? -ne 0 ] && echo $BASH_SOURCE ls error && exit 5
fi 

exit 0 
