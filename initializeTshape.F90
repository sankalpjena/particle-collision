subroutine initialize

use moduleGlobalVariables
use moduleParticle

real, allocatable :: x(:,:) ! position, dimension (Number of particles, 2D)
real, allocatable :: radius(:), mass(:), pMoI(:), velocity(:,:), angVelocity(:), elTanDef(:,:), velocityChange(:,:)  ! dimension (Number of particles)
integer :: i
logical :: lo
real :: wallR,wallM,dx,lWall, height


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
NpWall = 500 ! number of wall particles
Np = 20
NpTotal = Np + NpWall

! creating 'Np' particles

allocate(x(NpTotal,2))
allocate(radius(NpTotal))
allocate(mass(NpTotal))
allocate(pMoI(NpTotal))
allocate(velocity(NpTotal,2))
allocate(angVelocity(NpTotal))
allocate(elTanDef(NpTotal,2))
allocate(velocityChange(NpTotal,2))

! wall properties
wallR = 1e-10 !1.0e-12
wallM = 1.0e10
wallI = 1.0e10

! particle properties
partR = 0.1
partM = 1.0
partI = 1.0

! positions
! T shaped position of particles
height = 3.0
x(1,:) = (/1.5,height/)
do i = 2,Np-10
  x(i,:) = (/x(i-1,1) + 2 * partR + 0.01, height/)
end do

x(Np-9,:) = (/2.5,height - 2 * partR/)
do i = Np-8,Np
  x(i,:) = (/2.5, x(i-1,2) - 2 * partR - 0.01/)
end do

! wall positions and properties
lWall = 5 ! length of wall
dx = lWall / (NpWall+1)

x(Np+1,:) = (/0.0,0.0/) ! position of first wall particle
radius(Np+1) = wallR
mass(Np+1) = wallM
pMoI(Np+1) = wallI
velocity(Np+1,1) = 0.0 
velocity(Np+1,2) = 0.0
angVelocity(Np+1) = 0.0
elTanDef(Np+1,1) = 0.0 
elTanDef(Np+1,2) = 0.0
velocityChange(Np+1,1) = 0.0
velocityChange(Np+1,2) = 0.0

do i=Np+2,NpTotal
  x(i,:) = (/x(i-1,1)+dx, 0.0/) !(/0.5, 0.5/)
  radius(i) = wallR
  mass(i) = wallM
  pMoI(i) = wallI
  velocity(i,1) = 0.0 
  velocity(i,2) = 0.0
  angVelocity(i) = 0.0
  elTanDef(i,1) = 0.0 
  elTanDef(i,2) = 0.0
  velocityChange(i,1) = 0.0
  velocityChange(i,2) = 0.0
end do

! particle properties
! Property: radius
do i = 1,Np
  radius(i) = partR
  mass(i) = partM 
  pMoI(i) = partI 
  velocity(i,1) = 0.0 
  velocity(i,2) = 0.0 
  angVelocity(i) = 0.0 
  elTanDef(i,1) = 0.0 
  elTanDef(i,2) = 0.0 
  velocityChange(i,1) = 0.0
  velocityChange(i,2) = - mass(i) * gravity
end do

! Creating an array of Particles i.e set of Particles
allocate(P(NpTotal))

do i=1,NpTotal
  P(i) = particle(x(i,:),radius(i),mass(i),pMoI(i),velocity(i,:),angVelocity(i),elTanDef(i,:),(/0.0 , 0.0/), velocityChange(i,:))
end do
write(*,*) 'Allocated', NpTotal, 'particles'

end subroutine initialize