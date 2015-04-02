
! Copyright (C) 2013 J. K. Dewhurst, S. Sharma and E. K. U. Gross.
! This file is distributed under the terms of the GNU General Public License.
! See the file COPYING for license details.

subroutine genstress
use modmain
use modmpi
use modstore
implicit none
! local variables
integer i,j, kstrain
real(8) et0,t1
! store original parameters
avec0(:,:)=avec(:,:)
tforce0=tforce
tforce=.false.
! restore original symmetries
call symmetry
! generate the strain tensors
call genstrain
! zero the stress matrix
stress(:)=0.d0
! run the ground-state calculation
call gndstate
! check for stop signal
if (tstop) goto 10
! store the total energy
et0=engytot
! subsequent calculations will read STATE.OUT
trdstate=.true.
! loop over strain tensors

!Thu Apr  2 02:51:09 EDT 2015
!DW: keep the xy-plane unchanged because of exptaxial strain.
kstrain=0
stress(:)=0.0d0
do i=1,3
do j=1,3
kstrain=kstrain+1
if(i>2 .and. j>2) then
  if (mp_mpi) then
    write(*,'("Info(genstress): strain tensor ",I1," of ",I1)') i,nstrain
  end if
  ! displace lattice vectors
  avec(:,:)=avec0(:,:)+deltast*strain(:,:,kstrain)
  ! run the ground-state calculation
  call gndstate
  ! check for stop signal
  if (tstop) goto 10
  ! compute the stress tensor component
  stress(kstrain)=(engytot-et0)/deltast
endif
enddo
enddo

10 continue
! compute the maximum stress magnitude over all lattice vectors
stressmax=0.d0
do i=1,nstrain
  t1=abs(stress(i))
  if (t1.gt.stressmax) stressmax=t1
end do
! restore original parameters
avec(:,:)=avec0(:,:)
tforce=tforce0
return
end subroutine

