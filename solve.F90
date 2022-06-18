subroutine solve()

! *****************************************************************************
! 
!     purpose: 	  to call interact() so that the collisions are 
!                 detected and contact laws are applied then call evolve()
!                 to apply the property changes and position changes to the particles
! 
!     log:        2022/06   s. jena
!
! *****************************************************************************

  use moduleParticle
  use moduleOverlap
  
  implicit none

  real :: dist, def
  integer :: i,j

#include "main.def"


write(*,*) 'solve called successfully'
write(*,*) ''


do i = 1,Np
  do j = i+1,Np
    
    write(*,*) 'particle i,j =', i,j
    ! distance between two particles
    dist = distance(P(i)%positions,P(j)%positions)
    write(*,*) 'distance =', dist

    ! overlap between two particles
    def = overlap(dist,P(i)%properties(1),P(j)%properties(1)) 
    write(*,*) 'overlap = ', def

    ! if def > 0 => overlap, then apply contact laws
  end do
end do

end subroutine solve
