module Simulation

    export ergodic_distribution

    import Distributions: MvNormal
    # using Distributions

    using StaticArrays

    function ergodic_distribution(A::Matrix{Float64},Σ::Matrix{Float64})
        converged = false
        it = 0
        maxit = 1000
        η = 1e-10
        S_0 = eye(2)
        S = copy(S_0)
        while !converged && (it<maxit)
            it += 1
            S[:] = A*S_0*A' + Σ # *Σ'
            ϵ = maximum(abs,S-S_0)
            S_0[:] = S
            converged = (ϵ<η)
        end
        return S, it
    end

    function simulate(A::Matrix{Float64},Σ::Matrix{Float64},X_0::Vector{Float64}=zeros(size(A,1)),N::Int=100)
        d = size(A,1)
        Z = zeros(d,N)
        @assert (size(A,2)==d)
        @assert size(Σ)==size(A)
        dist = MvNormal(Σ)
        Z[:,1] = X_0
        for n=2:N
            Z[:,n] = A*Z[:,n-1] + rand(dist)
        end
        return Z
    end

    #
    simulate(A::Matrix{Float64},Σ::Matrix{Float64},N=100) = simulate(A,Σ,zeros(size(A,1)),N)

    function simulate(A::SMatrix{d,d,Float64},Σ::SMatrix{d,d,Float64},X_0::SVector{d,Float64},N::Int=100) where d
        Z = zeros(d,N)

        s_Z = reinterpret(SVector{d,Float64}, Z, (N,))

        dist = MvNormal(Array(Σ))
        s_Z[1] = X_0
        for n=2:N
            s_Z[n] = A*s_Z[n-1] + SVector{d,Float64}(rand(dist)...)
        end
        return Z
    end

end



function marco(x)
    throw("error")
    return exp(x)
end
