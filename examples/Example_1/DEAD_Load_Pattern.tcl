set DEAD 2;                    # Pattern tag
set NAxial [expr 640.544*$kN]; # Axial load
pattern Plain $DEAD Linear {
	# Create the nodal load - command: load nodeID xForce yForce zMoment
	load 10  0.0 -$NAxial 0.0  
}