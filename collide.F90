program collide

! *****************************************************************************
! 
!     purpose: 		collision of particles
!
! *****************************************************************************

 use moduleParticle
 use moduleGlobalVariables

  implicit none

  write(*,*)
  write(*,*)'-----------------------------------------------------------------'
  write(*,*)'           Particle collision             '
  write(*,*)'-----------------------------------------------------------------'
  write(*,*)'-----------------------------------------------------------------'


  ! initialization --------------------
  write(*,*)
  write(*,*) ' initialization ... '
  write(*,*)
  call initialize
  t = 0.d0

  ! solving... ------------------------
  write(*,*)
  write(*,*) ' solving ... '
  write(*,*)
  
  nt=1

  do while(.not.exit_time_loop)
    
    ! update time --------------
    t = t+dt

    write(*,*) ''
    write(*,*) 'Solving for t = ', t

    ! time integration ---------
    call interact

    ! write plot files ---------
    if(modulo(nt,nt_out).eq.0) call output

    ! exit time loop -----------
    !inquire(file='xstop', exist=exit_time_loop)
    !if(exit_time_loop) write(*,*) 'xstop found. Stop.'
    if(nt.eq.n_steps)  exit_time_loop=.true.

    nt=nt+1
    ! add zero velocity at a certain location 
    
  end do
  
  ! deallocation ----------
  call deallocation

  write(*,*)
  write(*,*) ' deallocating'

  write(*,*)
  write(*,*)'-----------------------------------------------------------------'
  write(*,*)' done ... '
  write(*,*)'-----------------------------------------------------------------'
  write(*,*)

end program collide