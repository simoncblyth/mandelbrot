Mandelbrot : Demo Standalone C++ with python visualization using matplotlib
==============================================================================

Requirements:

* https://github.com/simoncblyth/np
* matplotlib, ipython, python : install these with eg conda




Assuming you already have : bash, git, python, ipython, matplotlib  

* python related packages can conveniently be installed using **conda**

  * https://docs.conda.io/en/latest/


1. clone **mandelbrot** and **np** repos

::

   cd   
   git clone https://github.com/simoncblyth/mandelbrot
   git clone https://github.com/simoncblyth/np

2. read the code downloaded 

3. build and run

::

   cd ~/mandelbrot
   ./mandelbrot.sh 

4. try changing parameters via envvar controls 

   +------------------------+--------------------------------------------------------------------+
   | FOCUS=-0.7,0,0.84375   | specify region of complex plane with center coordinates and extent |
   +------------------------+--------------------------------------------------------------------+
   | MIT=100                | maximum iterations : can vary in range 1:255                       |
   +------------------------+--------------------------------------------------------------------+







