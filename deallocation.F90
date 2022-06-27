subroutine deallocation()

! *****************************************************************************
! 
!     purpose: 		deallocate fields
! 
!     log:           2015 / 03 - s.tschisgale
!                           05 - b.krull
!
! *****************************************************************************
    
  use moduleParticle
  
  implicit none

  ! deallocation
  deallocate( P )
  
end subroutine deallocation
