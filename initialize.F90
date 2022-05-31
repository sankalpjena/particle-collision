subroutine initialize
use moduleParticle

real :: positions(2), x, y
 
Np = 1 
allocate(P(Np))
positions = 2
! use of random_number: https://masuday.github.io/fortran_tutorial/random.html
! note that the random number(s) are stored in the variable that is passed
! to the generator and are of the same type as of the variable
do i=1,Np
  call random_number(p(i)%X)
  p(i)%m = 1
  p(i)%R = 0.1
  write(*,*) 'particle p =', i, 'has following properties'
  write(*,*) 'mass: ', p(i)%m
  write(*,*) 'position: ', p(i)%X 
end do 

end subroutine initialize