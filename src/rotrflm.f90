
! Copyright (C) 2008 J. K. Dewhurst, S. Sharma and E. K. U. Gross
! This file is distributed under the terms of the GNU Lesser General Public
! License. See the file COPYING for license details.

!BOP
! !ROUTINE: rotrflm
! !INTERFACE:
subroutine rotrflm(rot,lmax,n,ld,rflm1,rflm2)
! !INPUT/OUTPUT PARAMETERS:
!   rot   : rotation matrix (in,real(3,3))
!   lmax  : maximum angular momentum (in,integer)
!   n     : number of functions to rotate (in,integer)
!   ld    : leading dimension (in,integer)
!   rflm1 : coefficients of the real spherical harmonic expansion for each
!           function (in,real(ld,n))
!   rflm2 : coefficients of rotated functions (out,complex(ld,n))
! !DESCRIPTION:
!   Rotates a set of real functions
!   $$ f_i({\bf r})=\sum_{lm}f_{lm}^iR_{lm}(\hat{\bf r}) $$
!   for all $i$, given the coefficients $f_{lm}^i$ and a rotation matrix $R$.
!   This is done by first the computing the Euler angles $(\alpha,\beta,\gamma)$
!   of $R^{-1}$ (see routine {\tt roteuler}) and then applying the spherical
!   harmonic rotation matrix generated by the routine {\tt rlmrot}.
!
! !REVISION HISTORY:
!   Created December 2008 (JKD)
!EOP
!BOC
implicit none
! arguments
real(8), intent(in) :: rot(3,3)
integer, intent(in) :: lmax
integer, intent(in) :: n
integer, intent(in) :: ld
real(8), intent(out) :: rflm1(ld,*)
real(8), intent(out) :: rflm2(ld,*)
! local variables
integer lmmax,l,lm,nm,p
real(8) det,rotp(3,3)
real(8) ang(3),angi(3)
! allocatable arrays
real(8), allocatable :: d(:,:)
if (lmax.lt.0) then
  write(*,*)
  write(*,'("Error(rotrflm): lmax < 0 : ",I8)') lmax
  write(*,*)
  stop
end if
if (n.eq.0) return
if (n.lt.0) then
  write(*,*)
  write(*,'("Error(rotrflm): n < 0 : ",I8)') n
  write(*,*)
  stop
end if
lmmax=(lmax+1)**2
allocate(d(lmmax,lmmax))
! find the determinant
det=rot(1,2)*rot(2,3)*rot(3,1)-rot(1,3)*rot(2,2)*rot(3,1) &
   +rot(1,3)*rot(2,1)*rot(3,2)-rot(1,1)*rot(2,3)*rot(3,2) &
   +rot(1,1)*rot(2,2)*rot(3,3)-rot(1,2)*rot(2,1)*rot(3,3)
! make the rotation proper
p=1
if (det.lt.0.d0) p=-1
rotp(:,:)=dble(p)*rot(:,:)
! compute the Euler angles of the rotation matrix
call roteuler(rotp,ang)
! inverse rotation: the function is to be rotated, not the spherical harmonics
angi(1)=-ang(3)
angi(2)=-ang(2)
angi(3)=-ang(1)
! determine the rotation matrix for real spherical harmonics
call rlmrot(p,angi,lmax,lmmax,d)
! apply rotation matrix
do l=0,lmax
  nm=2*l+1
  lm=l**2+1
  call dgemm('N','N',nm,n,nm,1.d0,d(lm,lm),lmmax,rflm1(lm,1),ld,0.d0, &
   rflm2(lm,1),ld)
end do
deallocate(d)
return
end subroutine
!EOC
