subroutine initialize
use moduleParticle

real, dimension (2) :: x1, x2, x3, x4

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

end subroutine initialize