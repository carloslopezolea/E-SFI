wipe all

# Source display procedures
source LibUnits.tcl

# --------------------------------------------------------
# Start of model generation
# --------------------------------------------------------
set dataDir ESFI

file mkdir $dataDir;# Create ModelBuilder for 3D element (with three-dimensions and 6 DOF/node)
model BasicBuilder -ndm 2 -ndf 3;

# --------------------------------------------
# Set geometry, nodes, boundary conditions
# --------------------------------------------
source Nodes.tcl;

# ------------------------------
# Define materials
# ------------------------------
source Materials.tcl

# ------------------------------
#  Define elements
# ------------------------------
source Area_Elements.tcl

# ------------------------------
#  Define recorders
# ------------------------------
source Recorders.tcl

puts "MODEL GENERATED successfully."