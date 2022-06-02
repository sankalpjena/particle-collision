module moduleGlobalVariables

! *****************************************************************************
! 
!     purpose: 		declaration of global variables
! 
!     log:           2022/06    s. jena
!
!
! *****************************************************************************

implicit none
  
! *** time integration scheme *****************************
  real              :: t, dt, t_end
  integer           :: n_steps, nt, nt_out

! *** further variables ***********************************
  logical           :: exit_time_loop = .false.
  
! *** parameters ******************************************
  real, parameter   :: pi = 3.14159265359

end module moduleGlobalVariables    