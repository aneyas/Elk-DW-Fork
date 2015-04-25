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
export OMP_NESTED=false
export LD_LIBRARY_PATH=/home/compiler/intel/11.1/lib/intel64/:$LD_LIBRARY_PATH

cat > 'elk.in' <<EOF
! Phonon dispersion of BaSnO3/BaTiO3

! You can submit the same job (with task=205) on as many machines as you like,
! but they must be be able to see the same directory. Each machine with compute
! a row of a particular dynamical matrix. When run with task=220, the code
! assembles all the pieces to construct the dynamical matrices throughout the
! Brillouin zone.

! The final output (PHDISP.OUT and PHDLINES.OUT) is included with this example.

tasks
  0

latvopt
  1
epspot
  1.e-7
epsstress
  1.e-4

! limit the maximum number of self-consistent loops
maxscl
  200

autoswidth
.true.
autolinengy
.false.

lradstp
  2
beta0
 0.01
betamax
 0.2
tau0atp
  0.02
tau0latv
  0.08
maxatpstp
  200
maxlatvstp
  200

! exchange-correlation, 20 is PBE; default is LSDA calculation.
! 3 is LSDA, Perdew-Wang/Ceperley-Alder, Phys. Rev. B 45, 13244 (1992)
! it seems only this one is supported for response calculation.
! or choose 100 to use libxc
xctype
  2 0 0
! set to .true. if the Fourier components of the Kohn-Sham
! potential for |G| > gmaxvr/2 are to be set to zero !This fixes stability
! problems which can occur for large rgkmax. Should be used only in conjunction
! with large gmaxvr
mixtype
  3

trimvg
  .true.
isgkmax
-3
gmaxvr 
 28

ngridk
  2 2 2


sppath
  '../../species/'

scale
 1.0

scale1
 1.0

scale2
 1.0

scale3
 1.0

avec
   7.683000000       0.000000000       0.000000000    
   0.000000000       7.683000000       0.000000000    
   0.000000000       0.000000000       18.53300000    
 
atoms
   4                                    : nspecies
'Ba.in'                                 : spfname
   2                                    : natoms; atpos, bfcmt below
    0.50000000    0.50000000    0.25071434    0.00000000  0.00000000  0.00000000
    0.50000000    0.50000000    0.75   0.00000000  0.00000000  0.00000000
'Ti.in'                                 : spfname
   1                                    : natoms; atpos, bfcmt below
    0.00000000    0.00000000    0.00000000    0.00000000  0.00000000  0.00000000
'Sn.in'                                 : spfname
   1                                    : natoms; atpos, bfcmt below
    0.00000000    0.00000000    0.53464173    0.00000000  0.00000000  0.00000000
'O.in'                                  : spfname
   6                                    : natoms; atpos, bfcmt below
    0.00000000    0.00000000    0.25295021   0.00000000  0.00000000  0.00000000
    0.50000000    0.00000000    0.00         0.00000000  0.00000000  0.00000000
    0.00000000    0.50000000    0.00         0.00000000  0.00000000  0.00000000
    0.00000000    0.00000000    0.75         0.00000000  0.00000000  0.00000000
    0.50000000    0.00000000    0.50         0.00000000  0.00000000  0.00000000
    0.00000000    0.50000000    0.50         0.00000000  0.00000000  0.00000000

! These are the vertices to be joined for the phonon dispersion plot
!only some high symmetry points are calculated.
plot1d
  7 200                                 : nvp1d, npp1d
  0.0 0.0 0.0 :Gamma
  0.5 0.5 0.0 :M
  0.5 0.0 0.0 :X
  0.0 0.0 0.0 :Gamma
  0.0 0.0 0.5 :Z
  0.5 0.5 0.5 :A
  0.5 0.0 0.5 :R

! phonon q-point grid
ngridq
  4  4  2
EOF

nohup ./elk > 1.log &


