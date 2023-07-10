# ----------------------------------------------------
# Displacement Controlled Analysis
# ----------------------------------------------------

# Set the loads to be constant & reset the time in the domain
loadConst -time 0.0

# Create lateral load pattern
pattern Plain 1 Linear {
	# Create the nodal load - command: load nodeID xForce yForce zMoment
	load 8 1000 0 0
}

# ------------------------------
set Tol 1.e-3;                          # Convergence Test: tolerance
set maxNumIter 1000;              	   	# Convergence Test: maximum number of iterations that will be performed before "failure to converge" is returned
set printFlag 0;                		# Convergence Test: flag used to print information on convergence (optional)        # 1: print information on each step; 
set TestType NormDispIncr;				# Convergence-test type
set algorithmType KrylovNewton;         # Algorithm type

constraints Transformation; 
numberer RCM
system BandGeneral
test $TestType $Tol $maxNumIter $printFlag
algorithm $algorithmType;     	
analysis Static


set fmt1 "%s Cyclic analysis: CtrlNode %.3i, dof %.1i, Disp=%.4f %s";	# format for screen/file output of DONE/PROBLEM analysis

foreach Dmax $iDmax {

	set iDstep [GeneratePeaks $Dmax $Dincr $CycleType $Fact];	# this proc is defined above

	for {set i 1} {$i <= $Ncycles} {incr i 1} {
		
		set zeroD 0
		set D0 0.0 
		foreach Dstep $iDstep {
			set D1 $Dstep
			set Dincr [expr $D1 - $D0]
			integrator DisplacementControl  $IDctrlNode $IDctrlDOF $Dincr
			analysis Static
			# ----------------------------------------------first analyze command------------------------
			set ok [analyze 1]
			# ----------------------------------------------if convergence failure-------------------------
			if {$ok != 0} {
				# if analysis fails, we try some other stuff
				# performance is slower inside this loop	global maxNumIterStatic;# max no. of iterations performed before "failure to converge" is ret'd
				if {$ok != 0} {
					puts "Trying Newton with Current Tangent .."
					test NormDispIncr 0.01 1000 0
					algorithm Newton
					set ok [analyze 1]
					test $TestType $Tol $maxNumIter 0
					algorithm $algorithmType
				}
                if {$ok != 0} {
					puts "Trying Newton with Initial Tangent .."
					test NormDispIncr 0.01 2000 0
					algorithm Newton -initial
					set ok [analyze 1]
					test $TestType $Tol $maxNumIter 0
					algorithm $algorithmType 
				}
                if {$ok != 0} {
					puts "Trying Modified Newton .."
					test NormDispIncr 0.01 2000 0
					algorithm ModifiedNewton
					set ok [analyze 1]
					test $TestType $Tol $maxNumIter 0
					algorithm $algorithmType 
				}
				if {$ok != 0} {
					puts "Trying Broyden .."
					algorithm Broyden 500
					set ok [analyze 1 ]
					algorithm $algorithmType
				}
				if {$ok != 0} {
					set putout [format $fmt1 "PROBLEM" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
					puts $putout
					return -1
				}; # end if
			}; # end if
			# -----------------------------------------------------------------------------------------------------
			set D0 $D1;			# move to next step

			# print load step on the screen
			puts "Load Step: [expr $load_step]"
			set load_step [expr $load_step+1]

		}; # end Dstep

	};	# end i
		
};	# end of iDmaxCycl


# -----------------------------------------------------------------------------------------------------
if {$ok != 0 } {
	puts [format $fmt1 "PROBLEM" $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
} else {
	puts [format $fmt1 "DONE"  $IDctrlNode $IDctrlDOF [nodeDisp $IDctrlNode $IDctrlDOF] $LunitTXT]
}