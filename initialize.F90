subroutine initialize

use moduleGlobalVariables
use moduleParticle

real, allocatable :: x(:,:) ! dimension (Number of particles, 2D)
real, allocatable :: prop(:,:) ! dimension (Number of particles, Number of properties)
logical :: lo
integer :: i 


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

! Particle initialisation
Np = 4 

! creating 'Np' particles

allocate(x(Np,2))
allocate(prop(Np,1))
! positions
x(1,:) = (/0.0,0.0/)
x(2,:) = (/0.5, 0.5/)
x(3,:) = (/0.25,0.5/)
x(4,:) = (/0.25,0.75/)

! Property: radius
prop(:,1) = (/0.1,0.2,0.3,0.4/)

! Creating an array of Particles i.e set of Particles
allocate(P(Np))

do i=1,4
  P(i) = particle(x(i,:),prop(i,1))
end do
write(*,*) 'Allocated 4 particles'



end subroutine initialize