# Nodes 
# node $nodeTag (ndm $coords) <-mass (ndf $massValues)>
node 1	0       0                    
node 2	0       315.69           
node 3	0       631.37           
node 4	0       947.06           
node 5	0       1262.74         
node 6	0       1578.43         
node 7	0       1894.11        
node 8	0       2209.8         
node 9	0       2438.4          
node 10	0       2667        

# Restraint Fixes
# fix $nodeTag (ndf $constrValues)
fix 1 1 1 1;                       

# Diaphragm Restraints
# rigidDiaphragm $perpDirn $masterNodeTag $slaveNodeTag1 $slaveNodeTag2 ...

# Node Restraints 
#equalDOF $masterNodeTag $slaveNodeTag $dof1 $dof2 ...