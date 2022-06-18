module moduleOverlap
implicit none
public :: overlap, distance

contains 

function distance(xP,xQ) result(d)
    implicit none
    real, intent(in) :: xP(2),xQ(2)  ! intent(in) is an input parameter, it cannot be modified
    real :: d            ! result 'd' is an output

    d = sqrt( (xP(1) - xQ(1))*(xP(1) - xQ(1)) + (xP(2) - xQ(2))*(xP(2) - xQ(2)) )

end function distance

function overlap(d,Rp,Rq) result(defPQ)
    implicit none
    real, intent(in) :: d, Rp, Rq
    real :: defPQ

    defPQ = (Rp + Rq) - d

end function overlap

end module moduleOverlap