contains
    
    ! Particle constructor
    !subroutine particleInit(this, pX, pY, pR)
    type(particle) function particleInit(this, pX, pY, pR)
    
    type(particle) :: this
    real, value :: pX, pY, pR
    this%X(1) = pX
    this%X(2) = pY
    this%R = pR
    write(*,*) 'radius is', this%R

    end subroutine particleInit


!...initialisation
    integer, allocatable :: numParticles(:)
    integer :: i, size(2)

    ! array of type(particle)
    type(particle) :: listParticles(numParticles)

    size = shape(position)
    numParticles = (shape(position))(1)

    ! Initialisation of particles through implicit constructor
    do i = 1, numParticles
        listParticles(i) = particle(position(i,:), properties(i,1))
    end do 
    

    !...init()
        !...initialisation
    integer :: numParticles
    integer :: i, sizeNumParticles(2)

    ! array of type(particle)
    type(particle) :: listParticles(numParticles)

    !sizeNumParticles = shape(positions)
    numParticles = 4

    ! Initialisation of particles through implicit constructor
    do i = 1, numParticles
        listParticles(i) = particle(positions(i,:), properties(i,1))
    end do 


    !

    ! remove old result files ---------------------------------------------------
  inquire(file='./results/*_P.dat', exist=lo)
  if(lo) then
    open (unit=5, file='./results/*_P.dat', status='old')
    close(unit=5, status='delete')
  end if