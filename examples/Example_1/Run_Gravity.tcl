# ------------------------------
# Gravity load analysis
# ------------------------------

set Tol .0001
source DEAD_Load_Pattern.tcl

# ------------------------------
# Analysis generation
# ------------------------------
# Create the integration scheme, the LoadControl scheme using steps of 0.05
integrator LoadControl 0.05

# Create the system of equation, a sparse solver with partial pivoting
system BandGeneral

# Create the convergence test, the norm of the residual with a tolerance of
# Tol and a max number of iterations of 100
test NormDispIncr $Tol 100 0

# Create the DOF numberer, the reverse Cuthill-McKee algorithm
numberer RCM

# Create the constraint handler, the transformation method
constraints Transformation

# Create the solution algorithm, a Newton-Raphson algorithm
algorithm Newton -initial # -initialThenCurrent

# Create the analysis object
analysis Static

# Run analysis
analyze 20
