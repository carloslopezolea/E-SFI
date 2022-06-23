# UNITS ----------------------------------------------------------------------------

# define basic units -- output units
set mm 1.;
set N 1.; 
set sec 1.; 

# define basic-unit text for output
set LunitTXT "mm";			
set FunitTXT "N";		
set TunitTXT "sec";		

# define engineering units	
set mm2 [expr $mm*$mm]; 	
set MPa [expr $N/$mm2];
set kN [expr 1000.*$N];

# define english units	
set in [expr 25.4*$mm]; 				
set kip [expr 4448.2*$N]; 			
set ft [expr 12.*$in]; 		
set ksi [expr 6.895*$MPa];