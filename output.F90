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

integer :: b, ct ! for writing loop
character(len=100) :: filename ! for filename of result files
character (len=10) :: fmt ! format for writing the output

fmt = '(5E12.4,A)' ! 3 f/E float/scientificNotation values, 1 character string of unspecified length

  ! _particle positions
  ! open in direct access: https://docs.oracle.com/cd/E19957-01/805-4939/6j4m0vnc1/index.html
  write (filename, "(A8,I6.6,A6)") 'results/', nt, '_P.dat' ! A8 ~ results/, I6.6 ~ 6 spaces with 6 decimal spaces, A6 ~ _P.dat
  open(unit=12, file = trim(filename), access='direct', recl=61, form='formatted') !recl = 3 * 12 (#type E * #spaces for each type) + 1 (character strings of unspecified length)
    ct=0
    do b=1,Np
        ct=ct+1
        write(12,fmt,rec=ct) P(b)%positions(1), P(b)%positions(2), P(b)%radius, P(b)%velocity(1), P(b)%velocity(2), char(10) ! rec ... record number needed for direct access data transfer
    end do
  close(12)

end subroutine output