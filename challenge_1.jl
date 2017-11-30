

a = 6

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

# 2/ discretize VAR1 process
#    - try first with a 1-d process using tauchen or Rouwenhorst method from Quantecon
#    - discretize a VAR process when the covariance matrix is diagonal

# 3/ create functions (keep the same name for all functions):
#    - to simulate an VAR1 specified by three matrices
#    - to simulate an VAR1 specified by two matrices, assuming mean is zero
#    - to simulate an VAR1 many times
#      (do and replace simulate by "compute ergodic distribution" below)

# 4/ Refactoring:
#    - Create a new file with a Processes module to host the functions.
#    - Write another test files which imports from the module and shows how to use the functions.
#    - Devise various tests that actually check the functions are correct. (use @assert macro)

# 5/ Create a VAR1 type (in the module). Add new functions that operate on this type. Add them to the test file.

# 6/ Bonus: compute likelyhood function
