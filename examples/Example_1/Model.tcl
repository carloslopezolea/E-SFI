# ----------------------------------------------------
# Model Name: RW-A20-P10-S38
# Created by: Carlos Lopez O. (carlos.lopez.o@ug.uchile.cl)
# Last Modification: 21/06/2022
# ----------------------------------------------------
wipe all
# --------------------------------------------------------
# Start of model generation
# --------------------------------------------------------
set dataDir ModelData

file mkdir $dataDir;

# define basic-unit text for output
set LunitTXT "mm";			
set FunitTXT "N";		
set TunitTXT "sec";		

# Create ModelBuilder for 2D element (with two-dimensions and 3 DOF/node)
model BasicBuilder -ndm 2 -ndf 3;

# --------------------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------------------

# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
node 1	0       0                    
node 2	0       348.57           
node 3	0       697.14           
node 4	0       1045.71           
node 5	0       1394.29         
node 6	0       1742.86        
node 7	0       2091.43        
node 8	0       2440.0             

# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
fix 1 1 1 1;    

# --------------------------------------------------------
# Define materials
# --------------------------------------------------------

# Define and build steel material
# steel X
set fyX 469.93;       		 	   # fy
set bx 0.02;                       # strain hardening

# steel Y web
set fyYw 409.71;       			   # fy
set byw 0.02;                      # strain hardening

# steel Y boundary
set fyYb 429.78;       			   # fy
set byb 0.01;                      # strain hardening

# steel misc
set Es 200000.0;  				   # Young's modulus
set R0 20.0;                       # initial value of curvature parameter
set A1 0.925;                      # curvature degradation parameter
set A2 0.15;                       # curvature degradation parameter
  
# Build steel materials
uniaxialMaterial  Steel02  1 $fyX  $Es $bx  $R0 $A1 $A2; # steel X
uniaxialMaterial  Steel02  2 $fyYw $Es $byw $R0 $A1 $A2; # steel Y web
uniaxialMaterial  Steel02  3 $fyYb $Es $byb $R0 $A1 $A2; # steel Y boundary

# Define and build concrete material
# unconfined
set fpc -47.09;                          # peak compressive stress
set ec0 -0.00232;                        # strain at peak compressive stress
set ft 2.13;                             # peak tensile stress
set et 0.00008;                          # strain at peak tensile stress 
set Ec 34766.59;                         # Young's modulus     

# confined
set fpcc -53.78;                         # peak compressive stress
set ec0c -0.00397;                       # strain at peak compressive stress
set Ecc 36542.37;                        # Young's modulus

# Build concrete materials
uniaxialMaterial Concrete02 4 $fpc $ec0 0.0 -0.037 0.1 $ft 1738.33; # unconfined concrete
uniaxialMaterial Concrete02 5 $fpcc $ec0c -9.42 -0.047 0.1 $ft 1827.12; # confined concrete

# Reinforcing ratios
set rouXw 0.0027;   # X web 
set rouXb 0.0082;   # X boundary 
set rouYw 0.0027;   # Y web
set rouYb 0.0323;   # Y boundary

# Shear resisting mechanism parameters
set nu 0.35;                # friction coefficient
set alfadow 0.005;   		# dowel action stiffness parameter

# Define FSAM nDMaterial
nDMaterial FSAM 6  0.0  1   2   4  $rouXw $rouYw  $nu  $alfadow; # Web (unconfined concrete)
nDMaterial FSAM 7  0.0  1   3   5  $rouXb $rouYb  $nu  $alfadow; # Boundary (confined concrete)

# --------------------------------------------------------
#  Define elements
# --------------------------------------------------------
set m_fibers 8;
set c_rot 0.4;
set db 228.6;    # Wall boundary length discretization
set dw 127.133;  # Wall web length discretization
set tw 152.4;    # Wall thickness

element E_SFI 1 1 2 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 2 2 3 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 3 3 4 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 4 4 5 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 5 5 6 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 6 6 7 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;
element E_SFI 7 7 8 $m_fibers $c_rot -thick $tw $tw $tw $tw $tw $tw $tw $tw -width $db $dw $dw $dw $dw $dw $dw $db -mat 7 6 6 6 6 6 6 7;

# --------------------------------------------------------
#  Define recorders
# --------------------------------------------------------

# NODE Recorders:
recorder Node -file $dataDir/Node_base_react.out -time -node 1 -dof 1 2 3 reaction
recorder Node -file $dataDir/Node_top_disp.out -time -node 8 -dof 1 2 3 disp

# AREA ELEMENT Recorders:
# Element recorders
recorder Element -file $dataDir/ESFI_Fgl.out -time -eleRange 1 8 globalForce
recorder Element -file $dataDir/ESFI_Dsh.out -time -eleRange 1 8 ShearDef
recorder Element -file $dataDir/ESFI_Curvature.out -time -eleRange 1 8 Curvature
# Single RC panel (macro-fiber) responses
recorder Element -file $dataDir/ESFI_panel_strain_m1.out -time -eleRange 1 8 RCPanel 1 panel_strain
recorder Element -file $dataDir/ESFI_panel_stress_m1.out -time -eleRange 1 8 RCPanel 1 panel_stress
# Unaxial Steel Recorders
recorder Element -file $dataDir/ESFI_strain_stress_steelX_m1.out -time -eleRange 1 8 RCPanel 1 strain_stress_steelX
recorder Element -file $dataDir/ESFI_strain_stress_steelY_m1.out -time -eleRange 1 8 RCPanel 1 strain_stress_steelY
# Unaxial Concrete Recorders
recorder Element -file $dataDir/ESFI_strain_stress_concrete1_m1.out -time -eleRange 1 8 RCPanel 1 strain_stress_concrete1
recorder Element -file $dataDir/ESFI_strain_stress_concrete2_m1.out -time -eleRange 1 8 RCPanel 1 strain_stress_concrete2
# Cracking angles
recorder Element -file $dataDir/ESFI_cracking_angles_m1.out -time -eleRange 1 8 RCPanel 1 cracking_angles

puts "MODEL GENERATED successfully."