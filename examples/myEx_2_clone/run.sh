#!/bin/sh
#
# set the needed environment variables
#
export PATH=${MPI_HOME}/bin:$PATH
export MANPATH=${MPI_HOME}/man:$MANPATH
export LD_LIBRARY_PATH=${MPI_HOME}/lib:${MPI_HOME}/lib/shared:${LD_LIBRARY_PATH}\
:/opt/intel/compilerpro-12.0.1.107/compiler/lib/intel64/

#For elk
export OMP_NUM_THREADS=4
export OMP_NESTED=true
export LD_LIBRARY_PATH=/home/compiler/intel/11.1/lib/intel64/:$LD_LIBRARY_PATH

./elk > 1.log


