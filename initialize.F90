subroutine initialize

use moduleGlobalVariables
use moduleParticle

real, allocatable :: x(:,:) ! position, dimension (Number of particles, 2D)
real, allocatable :: radius(:), mass(:), pMoI(:), velocity(:,:), angVelocity(:), elTanDef(:,:)  ! dimension (Number of particles)
integer :: i 
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

! Particle initialisation
Np = 2 !4 

! creating 'Np' particles

allocate(x(Np,2))
allocate(radius(Np))
allocate(mass(Np))
allocate(pMoI(Np))
allocate(velocity(Np,2))
allocate(angVelocity(Np))
allocate(elTanDef(Np,2))

! positions
x(1,:) = (/0.5, 0.5/) !(/0.0,0.0/)
x(2,:) = (/0.25,0.5/) !(/0.5, 0.5/)
!x(3,:) = (/0.25,0.5/)
!x(4,:) = (/0.25,0.75/)

! properties order of variables: radius, mass, polar moment of inertia, velocity, 
!                                angular velocity, elastic deformation

! Property: radius
radius(:) = (/0.1,0.2/) !(/0.1,0.2,0.3,0.4/)

! mass
mass(:) = (/1,1/) !(/1,1,1,1/)

! moment of inertia
pMoI(:) = (/1,1/) !(/1,1,1,1/)

! velocity
velocity(:,1) = (/0.0,0.1/) !(/0,1,0,0/)
velocity(:,2) = (/0.0,0.0/) !(/0,0,0,0/)

! angular velocity
angVelocity(:) = (/0.0,0.1/) !(/0,1,0,0/)

! elastic displacement
elTanDef(:,1) = (/0.0,0.0/) !(/0,0,0,0/)
elTanDef(:,2) = (/0.0,0.0/) !(/0,0,0,0/)

! Creating an array of Particles i.e set of Particles
allocate(P(Np))

do i=1,Np
  P(i) = particle(x(i,:),radius(i),mass(i),pMoI(i),velocity(i,:),angVelocity(i),elTanDef(i,:))
end do
write(*,*) 'Allocated', Np, 'particles'

!write(*,*) 'particle 2 velocity: ', P(2)%velocity

end subroutine initialize