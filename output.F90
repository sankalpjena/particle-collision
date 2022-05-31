subroutine output()

! *****************************************************************************
! 
!     purpose: 		write plot files
! 
!     log:           2015 / 03 - s.tschisgale
!                           04 - s.tschisgale, b.krull
!                           05 - b.krull
!                    2021 / 05 - r.jain
!
! *****************************************************************************
    
  use Module_GlobalVariables
  use Module_ImmersedBoundary
  use Module_Fluid
  
  implicit none

  integer :: irec, b, k, kp, ct, o=0
  character(len=100) :: filename

  ! write(logicalUnitNumber, formatString) 
  ! logicalUnitNumber: *,6 ~ screen
  ! write plot data
  ! trim(filename): removes whitespace
  write(*,*) ' write data ... nt: ', nt
  write (filename, "(A8,I6.6,A4)") 'results/', nt, '.bin'

  ! _fluid field
  inquire( iolength=irec ) u(:,:,1)
  open(unit=11, file = trim(filename), form='unformatted', access='direct', recl=irec )
    write(11,rec=1) sqrt( u(:,:,1)*u(:,:,1) + u(:,:,2)*u(:,:,2) )
  close(11)

  ! write plot data
  write (filename, "(A8,I6.6,A6)") 'results/', nt, '_u.bin'

  ! _fluid field
  open(unit=11, file = trim(filename), form='unformatted', access='direct', recl=irec )
    write(11,rec=1) u(:,:,1)
  close(11)

  ! write plot data
  write (filename, "(A8,I6.6,A6)") 'results/', nt, '_v.bin'

  ! _fluid field
  open(unit=11, file = trim(filename), form='unformatted', access='direct', recl=irec )
    write(11,rec=1) u(:,:,2)
  close(11)

  ! _immersed boundaries
  write (filename, "(A8,I6.6,A7)") 'results/', nt, '_ib.dat'
  open(unit=12, file = trim(filename), access='direct', recl=25, form='formatted')
    ct=0
    do b=1,Nb
      do k=1,IB(b)%Nk
        ct=ct+1
        write(12,'(2E12.4,A)',rec=ct) Ib(b)%X(k,1)/dx, Ib(b)%X(k,2)/dx, char(10)
      end do
    end do
  close(12)
  
!   ! _plot line
!   plotlineU  = interpolation(u, plotlineX, plotlineN)
!   
!   open(unit=14, file = './results/slice.dat', access='direct', recl=25, form='formatted')
!     ct=0
!     do k=1,plotlineN
!       ct=ct+1
!       kp = mod(k+1,plotlineN)
!       ! x/dx and magnitude of velocity
!       write(14,'(2E12.4,A)',rec=ct) plotlineX(k,1)/dx, &
!        0.5*sqrt( ( plotlineU(k,1) + plotlineU(kp,1) )**2 &
!                + ( plotlineU(k,2) + plotlineU(kp,2) )**2 ), char(10)
!     end do
!   close(14)
  
end subroutine output
