
MAKE = make
F90 = ifort
F90_OPTS = -O3 -ip -unroll -no-prec-div -openmp
F77 = ifort
F77_OPTS = -O3 -ip -unroll -no-prec-div -openmp
AR = ar
LIB_SYS = 
# LAPACK and BLAS libraries
LIB_LPK = lapack.a blas.a
LIB_FFT = fftlib.a

#-------------------------------------------------------------------------------
SRC_MPI = mpi_stub.f90
# To enable MPI parallelism the MPI version of the Fortran compiler must be
# used. This is usually mpif90. Uncomment the following lines and run
# 'make clean' followed by 'make'.
#F90 = mpif90
#F77 = mpif90
#SRC_MPI =
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
SRC_libxc = libxcifc_stub.f90
# To enable Libxc first download and compile version 2.2.x of the library. Next
# copy the files libxcf90.a and libxc.a to the elk/src directory. Then uncomment
# the following lines and run 'make clean' followed by 'make'.
#LIB_libxc = libxcf90.a libxc.a
#SRC_libxc = libxc_funcs.f90 libxc.f90 libxcifc.f90
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
SRC_FFT = zfftifc.f90
# To use a different FFT library, copy the relevant library or include files to
# the elk/src directory (if required), uncomment the appropriate lines below and
# run 'make clean' followed by 'make'.
#SRC_FFT = zfftifc_fftw.f90
#LIB_FFT = libfftw3.a
#SRC_FFT = mkl_dfti.f90 zfftifc_mkl.f90
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# As an example, here is the make.inc file we use for our cluster. It uses MKL
# LAPACK and BLAS, MKL FFTW and Libxc. The Fortran compiler is mpif90 which
# enables MPI parallelism. All libraries are statically linked.
#
# MKLROOT = /cluster/intel/mkl
# MAKE = make
# F90 = mpif90
# F90_OPTS = -O3 -ip -openmp -I$(MKLROOT)/include
# F77 = mpif90
# F77_OPTS = -O3 -ip -openmp
# AR = ar
# LIB_SYS =
# LIB_LPK = -Wl,--start-group $(MKLROOT)/lib/intel64/libmkl_intel_lp64.a $(MKLROOT)/lib/intel64/libmkl_core.a $(MKLROOT)/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm -openmp -lfftw3_threads -lfftw3
# SRC_MPI =
# LIB_libxc = libxcf90.a libxc.a
# SRC_libxc = libxc_funcs.f90 libxc.f90 libxcifc.f90
# SRC_FFT = zfftifc_fftw.f90
#
#-------------------------------------------------------------------------------

