# ----------------------------------------------------------------------------------------
# Define and build steel material
# ----------------------------------------------------------------------------------------

# steel X
set fyX [expr 469.93*$MPa];        # fy
set bx 0.02;                       # strain hardening

# steel Y web
set fyYw [expr 409.71*$MPa];       # fy
set byw 0.02;                      # strain hardening

# steel Y boundary
set fyYb [expr 429.78*$MPa];       # fy
set byb 0.01;                      # strain hardening

# steel misc
set Esy [expr 200000.0*$MPa];      # Young's modulus
set Esx $Esy;                      # Young's modulus
set R0 20.0;                       # initial value of curvature parameter
set A1 0.925;                      # curvature degradation parameter
set A2 0.15;                       # curvature degradation parameter
  
# Build steel materials
uniaxialMaterial  Steel02  1 $fyX  $Esx $bx  $R0 $A1 $A2; # steel X
uniaxialMaterial  Steel02  2 $fyYw $Esy $byw $R0 $A1 $A2; # steel Y web
uniaxialMaterial  Steel02  3 $fyYb $Esy $byb $R0 $A1 $A2; # steel Y boundary

# ----------------------------------------------------------------------------------------
# Define and build concrete material
# ----------------------------------------------------------------------------------------

# unconfined
set fpc [expr -47.09*$MPa];                          # peak compressive stress
set ec0 [expr -0.00232];                             # strain at peak compressive stress
set ft [expr 2.13*$MPa];                             # peak tensile stress
set et [expr 0.00008];                               # strain at peak tensile stress 
set Ec [expr 34766.59*$MPa];                         # Young's modulus     
set xcrnu [expr 1.02];                               # cracking strain - compression (ec0 by xcrnu)
set xcrp [expr 10000];                               # cracking strain - tension
set ru [expr 7.16];                                  # shape parameter - compression
set rt [expr 1.2];                                   # shape parameter - tension

# confined
set fpcc [expr -53.78*$MPa];                         # peak compressive stress
set ec0c [expr -0.00397];                            # strain at peak compressive stress
set Ecc [expr 36542.37*$MPa];                        # Young's modulus
set xcrnc [expr 1.02];                               # cracking strain - compression
set rc [expr 8.44];                                  # shape parameter - compression

# Build concrete materials
uniaxialMaterial ConcreteCM 4 $fpc  $ec0  $Ec  $ru $xcrnu $ft $et $rt $xcrp -GapClose 0; # unconfined concrete
uniaxialMaterial ConcreteCM 5 $fpcc $ec0c $Ecc $rc $xcrnc $ft $et $rt $xcrp -GapClose 0; # confined concrete

# ----------------------------------------------------------------------------------------
# Reinforcing ratios
# ----------------------------------------------------------------------------------------
 
set rouXw 0.0027;   # X web 
set rouXb 0.0082;   # X boundary 
set rouYw 0.0027;   # Y web
set rouYb 0.0323;   # Y boundary

# ----------------------------------------------------------------------------------------
# Shear resisting mechanism parameters
# ----------------------------------------------------------------------------------------

set nu 0.35;                # friction coefficient
set alfadow [expr 0.005];   # dowel action stiffness parameter

# ----------------------------------------------------------------------------------------
# Define FSAM nDMaterial
# ----------------------------------------------------------------------------------------

nDMaterial FSAM 6  0.0  1   2   4  $rouXw $rouYw  $nu  $alfadow; # Web (unconfined concrete)
nDMaterial FSAM 7  0.0  1   3   5  $rouXb $rouYb  $nu  $alfadow; # Boundary (confined concrete)
