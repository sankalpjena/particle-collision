subroutine initialize

use moduleGlobalVariables
use moduleParticle

real, dimension (2) :: x1, x2, x3, x4
logical :: lo

namelist /general/   n_steps,    &! number of time steps
                        t_end,     &! final time
                        dt,        &! time step
                        nt_out    ! output-files every nt_bin timesteps

! read parameters from input.dat --------------------------------------------
inquire(file='./input.dat', exist=lo)
if(lo) then  
  open(unit=1, file='input.dat')
    read(1, general)
  close(1)
end if 

! _estimate number of time steps
if(n_steps.gt.0) &
n_steps = min(n_steps,ceiling(t_end/dt))


Np = 4 
allocate(P(Np))

! creating 4 particles
x1 = (/0.0,0.5/)
x2 = (/0.5, 0.5/)
x3 = (/0.25,0.5/)
x4 = (/0.25,0.75/)

P(1)%X = x1
P(2)%X = x2
P(3)%X = x3
P(4)%X = x4

! remove old result files ---------------------------------------------------
  inquire(file='./results/*_P.dat', exist=lo)
  if(lo) then
    open (unit=5, file='./results/*_P.dat', status='old')
    close(unit=5, status='delete')
  end if

end subroutine initialize