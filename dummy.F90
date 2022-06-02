program dummy

implicit none

! *** time integration scheme *****************************
  real              :: t, dt, t_end
  integer           :: n_steps, nt, nt_out
  logical :: lo

namelist /general/   n_steps,    &! number of time steps
                        t_end,     &! final time
                        dt,        &! time step
                        nt_out    ! output-files every nt_bin timesteps


! read parameters from input.dat --------------------------------------------
inquire(file='./input.dat', exist=lo)
if(lo) then  
  open(unit=1, file='input.dat')
    read(1,general)
  close(1)
end if 

end program dummy