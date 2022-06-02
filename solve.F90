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
  
  implicit none

#include "main.def"
  
write(*,*) 'solve called successfully'
   
 
end subroutine solve
