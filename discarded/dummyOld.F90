program dummy

use :: moduleParticle

implicit none

! *** time integration scheme *****************************
  real              :: t, dt, t_end
  integer           :: n_steps, nt, nt_out, ct, Np, b
  logical :: lo

  character (len=10) :: fmt 
  real :: x, y, z
  character(len=100) :: filename

namelist /general/   n_steps,    &! number of time steps
                        t_end,     &! final time
                        dt,        &! time step
                        nt_out    ! output-files every nt_bin timesteps

! to debug reading of input files
! read parameters from input.dat --------------------------------------------
inquire(file='./input.dat', exist=lo)
if(lo) then  
  open(unit=1, file='input.dat')
    read(1,general)
  close(1)
end if 

! to debug writing output in specified columns
x = 1
y = 2
z = 3
Np = 2
fmt = '(3f12.4,A)' ! 3 f/E float/scientific notation, 1 character string of unspecified length
!101 format(2E12.4,A) ! another way of writing format
! https://docs.oracle.com/cd/E19957-01/805-4939/6j4m0vnbs/index.html


write(*,fmt) x, y, z, char(10) ! rec ~ record number
write(*,*) 'print to screen successful'

!_writing without direct access
write (filename, "(A8,I6.6,A11)") 'results/', nt, '_Punfmt.dat' ! A8 ~ results/, I6.6 ~ 6 spaces with 6 decimal spaces, A11 ~ _Punfmt.dat
open(unit=16, file=trim(filename))
do b=1,Np
        write(16,fmt) x, y, z ! rec ... record number needed for direct access data transfer
    end do
close(16)
write(*,*) 'write to file w/o direct access successful'

! _writing with direct access
  write (filename, "(A8,I6.6,A9)") 'results/', nt, '_Pfmt.dat'
  open(unit=12, file = trim(filename), access='direct', recl=25, form='formatted')
    ct=0
    do b=1,Np
        ct=ct+1
        write(12,fmt,rec=ct) x, y, z! rec ... record number needed for direct access data transfer
    end do
  close(12)
  write(*,*) 'write to file w/ direct access successful'

    !_writing particle positions without direct access
  !write (filename, "(A8,I6.6,A6)") 'results/', nt, '_P.dat' ! A8 ~ results/, I6.6 ~ 6 spaces with 6 decimal spaces, A6 ~ _P.dat
  !open(unit=16, file=trim(filename))
  !  do b=1,Np
  !      write(16,fmt) P(b)%X(1), P(b)%X(2), P(b)%R
  !  end do
  !close(16)

! testing module with constructors
  type(particle) :: p1
  p1%R = 1
  call p1%init
end program dummy