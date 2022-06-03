subroutine output()

! *****************************************************************************
! 
!     purpose: 		write plot files
! 
!     log:           2022/06 s. jena
!     
!     Adapted from IBM2D
! *****************************************************************************

use moduleGlobalVariables
use moduleParticle

implicit none

integer :: irec, b, k, kp, ct, o=0
character(len=100) :: filename

  
  ! _particle positions
  write (filename, "(A8,I6.6,A6)") 'results/', nt, '_P.dat'
  open(unit=12, file = trim(filename), access='direct', recl=25, form='formatted')
    ct=0
    do b=1,Np
        ct=ct+1
        write(12,'(2E12.4,A)',rec=ct) P(b)%X(1), P(b)%X(2), char(10)
    end do
  close(12)
end subroutine output