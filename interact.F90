subroutine interact()

! *****************************************************************************
! 
!     purpose: 	  to call interact() so that the collisions are 
!                 detected and contact laws are applied then call evolve()
!                 to apply the property changes and position changes to the particles
! 
!     log:        2022/06   s. jena
!
! *****************************************************************************

  use moduleParticle
  use moduleOverlap
  use moduleContactLaw
  use moduleGlobalVariables
  
  implicit none

  real :: dist, def, projVel ! distance and deformation
  integer :: i,j    ! loop variables
  real :: vr_pq(2), vt_pq(2), normal(2), v_pq(2), omega, omegaTilde(3,3), normalTilde(3,1), crossProduct(3,1)
  real :: omgXnormal(2), upq(2) = (/0,0/), Fr_pq(2)=(/0.0, 0.0/), Ft_pq(2)=(/0.0, 0.0/), F(2) = (/0.0, 0.0/), tau = 0
  real :: rP, rQ, mP, mQ, mEff
  real :: factor, grm, gtm, a, b

#include "main.def"

write(*,*) ''


do i = 1,Np ! particle - p
  
  ! properties of 'p'
  rP = P(i)%radius  ! radius
  mP = P(i)%mass    ! mass


  do j = i+1,Np ! particle - q
    
    ! properties of 'q'
    rQ = P(j)%radius  ! radius
    mQ = P(j)%mass ! mass

    !write(*,*) 'particle i,j =', i,j
    ! distance between two particles
    dist = distance(P(i)%positions,P(j)%positions)
    !write(*,*) 'distance =', dist

    ! overlap between two particles
    def = overlap(dist,rP,rQ) 
    !write(*,*) 'overlap = ', def

    ! if def > 0 => overlap, then apply contact laws
    if (def .ge. 0) then
      write(*,*) "overlap between i,j", i,j
      normal = unitNormal(P(i)%positions,P(j)%positions) ! calling unitNormal function from moduleContactLaw
      write(*,*) "unit normal: ", normal
      
      ! radial relative velocity
      !write(*,*) 'relative velocity p,q: ', (P(i)%velocity - P(j)%velocity)
      v_pq = (P(i)%velocity - P(j)%velocity)
      projVel = dot_product( v_pq, normal ) ! relative velocity projected along normal
      !write(*,*) 'projected velocity: ', projVel
      vr_pq =  projVel * normal
      write(*,*) "radial velocity", vr_pq

      omega = ( (P(i)%angVelocity * P(i)%radius) + (P(j)%angVelocity * P(j)%radius)) 
      !write(*,*) 'omega : ', omega
      omegaTilde = reshape( (/0.0, - omega, 0.0, omega, 0.0, 0.0, 0.0, 0.0, 0.0/), (/3,3/) )
      normalTilde = reshape( (/normal(1), normal(2), normal(3)/), (/3,1/) )
      !write(*,*) 'omegaTilde: ', omegaTilde
      !write(*,*) 'normalTilde: ', normalTilde
      !write(*,*) 'cross product: ', matmul(omegaTilde,normalTilde)
      crossProduct = matmul(omegaTilde,normalTilde)
      omgXnormal = (/crossProduct(1,1), crossProduct(2,1)/)
      vt_pq = v_pq - vr_pq - omgXnormal
      write(*,*) 'tangential velocity: ', vt_pq

      ! integration of elastic tangential deformation - didn't understand this
      P(j)%elTanDef =  P(j)%elTanDef + upq +  dt * vt_pq

      ! radial contact force (Eq. 4.18)
      factor = sqrt(def/(rP+rQ))
      mEff = (mP * mQ) / (mP + mQ)
      grm = gamma_r * mEff
      Fr_pq = factor * (k_r * def * normal - grm * vr_pq)

      ! tangential contact force (Eq. 4.19)
      gtm = gamma_t * mEff
      Ft_pq = factor * (- k_t * P(j)%elTanDef - gtm * vt_pq)

      ! truncate displacement to satisfy Coulomb yield criterion (Eq. 4.20) 
      a = mu * mu * (dot_product(Fr_pq,Fr_pq)) ! scalar product
      b = dot_product(Ft_pq,Ft_pq) ! scalar product

      if (b .ge. a) then
      
        a = sqrt(a/b)
        
        ! truncate the force magnitude accordingly
        Ft_pq = Ft_pq * a
        
        ! compute the corresponding u_pq from Eq. 4.21
        factor = 1.0 / factor
        P(j)%elTanDef = (-1/k_t) * ( factor * Ft_pq + gtm * vt_pq)
            
      end if 

      ! total force on the particle (Eq. 4.22) 
      F = F + Fr_pq + Ft_pq
      ! total torque on the particle (Eq. 4.23) 
      tau = tau + (normal(1)*Fr_pq(2) - normal(2)*Fr_pq(1)) ! cross product

      ! property change of particles
      P(i)%velocityChange = F
      P(i)%angVelocityChange = tau
      
      ! Newton's third law: Fpq = Fqp
      P(j)%velocityChange = - F
      P(j)%angVelocityChange = - tau
    
    end if 
  
  end do

  ! evolve - Explicit Euler
  P(i)%angVelocity = P(i)%angVelocity + (P(i)%angVelocityChange * dt)/P(i)%polarInertia
  P(i)%velocity = P(i)%velocity + (P(i)%velocityChange * dt)/(P(i)%mass)
  P(i)%positions = P(i)%positions + dt * P(i)%velocity

  ! check if particle moved out of the boundary
  if (P(i)%positions(1) .ge. 1) then 
    P(i)%positions(1) = P(i)%positions(1) - 1
  end if 
  
  
end do

end subroutine interact
