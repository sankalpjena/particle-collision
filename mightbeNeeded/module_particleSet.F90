module moduleParticleSet

use moduleParticle

implicit none

type particleSet
    
    ! variables for instance of class particleSet
    !real :: positions(4,2), properties(4)
    type(particle) :: listParticles(4)



end type particleSet


type(particleSet), allocatable :: PSet(:)


end module moduleParticleSet