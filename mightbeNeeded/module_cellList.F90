module cellList

use module particle

type cellList
type(particle) :: particleSet(Np)
real :: cutOff

end type cellList


end module cellList