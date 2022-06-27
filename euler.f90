program euler
implicit none
real,external::f
real::x,y,h,xend   ! h is the interval and xend is the value upto which we want to run the simulation
integer::n,i
print*,"Please insert the initial condition of x i.e. x0"
read*,x
print*,"Please insert the initial condition of y i.e. y0"
read*,y
print*,"Please insert the width of the x interval i.e. the value of h"
read*,h
print*,"Please insert the value of x at which solution is to be found i.e. xend"
read*,xend
n=int((xend-x)/h+0.5)

! Implement the loop iteration for Euler Scheme
do i=1,n
x=x+h
y=y+h*f(x,y)
enddo
print*,"The value of x and it's corresponding y is",x,y
end

real function f(x,y)
real::x,y
f = x+2*y
end
