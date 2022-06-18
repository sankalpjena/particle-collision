module moduleParticle
! particle module

implicit none
save

integer :: Np

! particle class
type particle
    
    ! ... properties of particle
    ! a particle has the following properties: velocity, angular velocity, elastic deformation
    ! mass, polar moment of inertia, 
    !real :: X(2), R, & ! position of particle/center of sphere and radius
    !        v(2), omega, & ! velocity and angular velocity
    !        u(2), & ! elastic deformation
    !        m, Ip ! mass, polar moment of inertia

    real :: positions(2), properties(1), &
            positionChange(2) = (/0.0 , 0.0/), propertiesChange(1) = (/0./) 
end type particle

type(particle), allocatable :: P(:) !only for compiling output.F90, remove later

end module moduleParticle


  ! to be included: interact and evolve

  ! contains 
  ! subroutine evolve
  ! end subroutine evolve
  
  ! subroutine interact
  ! end subroutine interact

  