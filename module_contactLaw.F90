module moduleContactLaw

use moduleOverlap

implicit none

public :: unitNormal

contains

function unitNormal(xP,xQ) result(normal)
    
    implicit none
    real, intent(in) :: xP(2),xQ(2)  ! intent(in) is an input parameter, it cannot be modified
    real :: normal(2), dist           ! result 'normal' is an output
    integer :: i
    
    dist = distance(xP,xQ) 
   
    do i = 1,2
        normal(i) = (xP(i) - xQ(i))/ dist ! Eq. from page 41
    end do 

end function unitNormal


end module moduleContactLaw