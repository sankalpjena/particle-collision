program dummy

use moduleParticle
use dictionary_m

implicit none

real, allocatable :: x(:,:)
real, allocatable :: prop(:,:) ! dimension (Number of particles, Number of properties)

integer :: i, s(2)

! for cellList
real :: rc
integer :: cellIdx(2), numCells
type(dictionary_t) :: cellX(2) ! cells are dictionaries with two indices for 2D domain

!init dictionary: size of hash table
call cellX(1)%init(1024)
call cellX(2)%init(1024)

Np = 4
! creating 'Np' particles

allocate(x(Np,2))
allocate(prop(Np,1))
! positions
x(1,:) = (/0.0,0.0/)
x(2,:) = (/0.5, 0.5/)
x(3,:) = (/0.25,0.5/)
x(4,:) = (/0.25,0.75/)

! Property: radius
prop(:,1) = (/0.1,0.2,0.3,0.4/)

! Creating an array of Particles i.e set of Particles
allocate(P(Np))

do i=1,4
  P(i) = particle(x(i,:),prop(i,1))
end do
write(*,*) 'Allocated 4 particles'


!...particleSet
!allocate(PSet(1))

!PSet = particleSet(Particles) ! figure out why this doesn't work -> update: this is not needed as we have Particle set P(:) already

! cellList
rc = 0.5
numCells = ceiling(1/rc) * ceiling(1/rc)
write(*,*) 'number of  cells', numCells

!allocate(cells(4))
!write(*,*) "particle 1 position:", Particles(1)%positions
!call cells(0,0)%set('1')
! How to get empty lists lists in fortran, and append new neighbor particles as we find them

do i = 1,4

  cellIdx(1) = floor(P(i)%positions(1)/rc)
  cellIdx(2) = floor(P(i)%positions(2)/rc)
  write(*,*) "cell Index:", cellIdx

end do 

! adding a key and a value. here, 0 refers to the cell[0] and 1 refers to the particle inside that cell
write(*,*) "added p1 to cell0"
call cellX(1)%set('0', '1')
write(*,*) "added p2 to cell0, this doesn't work as set() replaces the value of the key"
! how to get append functionality? Need the cell 'keys' to be a list so that arbitrary number of cells could be stored
call cellX(1)%set('0','2')
!call cellX(1)%find('0')

! to show the contents of the dictionary
call cellX(1)%show()

write(*,*) cellX(1)%get('0')


!if (cellIdx(1) == 1) then
  
!end if 

end program dummy