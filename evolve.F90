subroutine evolve()
    use moduleParticle
    use moduleOverlap
    use moduleContactLaw
    use moduleGlobalVariables

    implicit none
    
    do i = 1, Np
        P(i)%angVelocity = P(i)%angVelocity + (P(i)%angVelocityChange * dt)/P(i)%polarInertia
        P(i)%velocity = P(i)%velocity + (P(i)%velocityChange * dt)/(P(i)%mass)
        P(i)%positions = P(i)%positions + dt * P(i)%velocity
    end do 
    
end subroutine evolve()