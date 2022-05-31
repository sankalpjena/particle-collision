module moduleParticle

implicit none
save

integer :: Np

type particle
  
    ! ... properties of particle
    ! a particle has the following properties: velocity, angular velocity, elastic deformation
    ! mass, polar moment of inertia, 
    real :: X(2), R, & ! position of particle/center of sphere and radius
            v(2), omega, & ! velocity and angular velocity
            u(2), & ! elastic deformation
            m, Ip ! mass, polar moment of inertia

    
  end type particle

  type(particle), allocatable :: P(:)
  end module moduleParticle