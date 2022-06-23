set LATERAL 1;                  # Pattern tag	
set PLateral [expr 1.*$kN];		# Reference lateral load	
pattern Plain $LATERAL Linear {
	# Create the nodal load - command: load nodeID xForce yForce zMoment
	load 8 $PLateral 0 0
	load 9 $PLateral 0 0
    load 10 $PLateral 0 0
}