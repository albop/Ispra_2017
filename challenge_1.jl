# to launch notebook from atom:
# - load julia kernel: `using IJulia`
# - run notebook: `notebook()`


function f(a::Int)
    z = a+3
    throw("Error")
end

##
## AR1 object: basic matrix work + functions + tests + types
##
# The objective here, is to create an VAR1 object and to simulate it.
#
# Sources to check for inspiration:
# - Julia cheatsheets (there are several of them)
# - Julia manual
# - quantecon
# - dolo.numeric.discretize

# Here are the steps to complete:
# (steps 0,1,2 are meant to be completed below in the same file.

# 0/ preliminaries
#    set n=2. Create autocorrelation matrix R and covariance matrix S. Assume mean of the process is M

# 1/ implement the basic operations for an VAR1:
#    - compute characteristics of ergodic distribution (mean and standard deviations)
#    - simulate a VAR1 process for T periods
#    - simulate a VAR1 process for T periods N times
#    - compare theoretical findings for ergodic distribution and simulations based ones

include("ar1.jl")

ρ = 0.9
A = eye(2)*ρ
σ = 0.001
Σ=eye(2)*σ^2


Simulation.simulate(A,Σ)

@time Simulation.simulate(A,Σ,X_0,10000)


X_0 = zeros(2)

using StaticArrays

s_X_0 = SVector(X_0...)
s_A = SMatrix{2,2}(A)
s_Σ = SMatrix{2,2}(Σ)


@time Simulation.simulate(s_A,s_Σ,s_X_0, 10000)


Z = zeros(2,10)

s_Z = reinterpret(SVector{2,Float64}, Z, (10,))
s_Z[2]


σ_e = σ/sqrt(1-ρ^2)

S, nit = Simulation.ergodic_distribution(A,Σ)
sqrt(S[1,1])

@assert abs(sqrt(S[1,1])-σ_e)<1e-6



# unpacking

obj = linspace(0,1,1000)
typeof(obj)
[x for x in obj]
collect(obj)
[obj...]


function special_sum(x1, x2, x3)
    return 1*x1 + 2*x2 + 3*x3
end

special_sum(1,2,3)


function special_sum_n(l::Vector{Float64})
    n = length(l)
    if n>1
        return special_sum_n(l[1:n-1])+n*l[n]
    else
        return l[1]
    end
end

special_sum_n([1,23,4.0])


function special_sum_n(l::Vector{Float64})
    n = length(l)
    s = 0.0
    for i=1:n
        s+=l[i]*i
    end
    return s
end

function special_sum_g(l...)
    n = length(l)
    s = 0.0
    for i=1:n
        s+=l[i]*i
    end
    return s
end

special_sum_n([1,23,4.0])


special_sum_g(1,23,4.0,10,10)


special_sum_g(linspace(0,1,1000000)...)


v = rand(2)
x1 = v[1]
x2 = v[2]
sv = SVector{2}(x1,x2)

sv = SVector{2}(v...)
