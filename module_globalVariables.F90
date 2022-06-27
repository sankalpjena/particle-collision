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
  real, parameter   :: gamma_r = 1, k_r = 1, gamma_t = 0, k_t = 1, gravity(2) = (/9.81, 0.0/), mu = 0.5

end module moduleGlobalVariables    