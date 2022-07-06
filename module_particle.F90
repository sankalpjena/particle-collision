module moduleParticle
! particle module

implicit none
save

integer :: Np,NpWall,NpTotal

! particle class
type particle
    
    ! ... properties of particle
    ! a particle has the following properties: velocity, angular velocity, elastic deformation
    ! mass, polar moment of inertia, 
    !real :: X(2), R, & ! position of particle/center of sphere and radius
    !        v(2), omega, & ! velocity and angular velocity
    !        u(2), & ! elastic deformation
    !        m, Ip ! mass, polar moment of inertia

    ! Properties: Radius, mass, polar moment of inertia, velocity, angular velocity, elastic tangential deformation
    real :: positions(2),radius = 0.0, mass = 0, polarInertia = 0, velocity(2) = (/0.0, 0.0/), angVelocity = 0, elTanDef(2) = 0, &
            positionChange(2) = (/0.0 , 0.0/), velocityChange(2) = (/0.0 , 0.0/), angVelocityChange = 0.0
end type particle

type(particle), allocatable :: P(:) !array of particles

end module moduleParticle

  