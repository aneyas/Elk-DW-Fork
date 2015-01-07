#!/bin/bash - 
#===============================================================================
#
#          FILE: run-omp.sh
# 
#         USAGE: ./run-omp.sh 
# 
#   DESCRIPTION: Run elk using a script.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#       CREATED: 01/07/2015 16:16
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

export OMP_NUM_THREADS=4
export OMP_NESTED=true
export OMP_DYNAMIC=false
export MKL_NUM_THREADS=8
export MKL_DYNAMIC=true

~/bin/elk


