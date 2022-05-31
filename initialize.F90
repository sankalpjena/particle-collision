subroutine initialize
use moduleParticle

real :: positions(2), x, y
 
Np = 1 
allocate(P(Np))
positions = 2

do i=1,Np
  call random_number(p(i)%X)
  p(i)%m = 1
  p(i)%R = 0.1
  write(*,*) 'particle p =', i, 'has following properties'
  write(*,*) 'mass: ', p(i)%m
  write(*,*) 'position: ', p(i)%X 
end do 

end subroutine initialize