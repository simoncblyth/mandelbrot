#!/bin/bash -l 
usage(){ cat << EOU
mandelbrot.sh
===============

FOCUS=-1.45,0,0.05 ~/mandelbrot/mandelbrot.sh
FOCUS=-1.45,0,0.05 MIT=80 ~/mandelbrot/mandelbrot.sh
FOCUS=-1.45,0,0.05 MIT=50 ~/mandelbrot/mandelbrot.sh

Initially used awkward FOLD and running from HOME directory 
as workarounds for /tmp apparently not being visible to rsync on lxslc7

But a better solution is to pin down connection to specific
node eg lxslc708 which then allows to rsync from absolute tmp 
path which can be the same on both the remote and the laptop. 

EOU
}

cd $(dirname $BASH_SOURCE)

name=mandelbrot 
defarg="info_build_run_ana_ls"
arg=${1:-$defarg}

fold=/tmp/$USER/$name
export FOLD=$fold
export IDENTITY="$BASH_SOURCE $(uname -n) $(date)"
mkdir -p $FOLD
bin=$FOLD/$name

remote=L708
REMOTE=${REMOTE:-$remote}

np_base=..
NP_BASE=${NP_BASE:-$np_base}

vars="REMOTE IDENTITY NP_BASE name SDIR FOLD"

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
    rsync -zarv --progress  \
          --include="*.npy" \
          --include="*.txt" \
          --include="*.jpg" \
          --include="*.png" \
          "$REMOTE:$FOLD/" "$FOLD"

    [ $? -ne 0 ] && echo $BASH_SOURCE grab error && exit 3
fi 
if [ "${arg/ana}" != "$arg" ]; then 
    ${IPYTHON:-ipython} --pdb -i $name.py 
    [ $? -ne 0 ] && echo $BASH_SOURCE ana error && exit 4 
fi 
if [ "${arg/ls}" != "$arg" ]; then 
    echo FOLD $FOLD
    find $FOLD -type f 
    [ $? -ne 0 ] && echo $BASH_SOURCE ls error && exit 5
fi 

exit 0 
