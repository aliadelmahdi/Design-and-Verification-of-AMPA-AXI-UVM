+incdir+./design
+incdir+./design/AXI_Assertions
+incdir+./design/AXI_design
+incdir+./interface
+incdir+./objects
+incdir+./objects/master_objects
+incdir+./objects/slave_objects
+incdir+./top
+incdir+./top/test
+incdir+./top/test/enviroment
+incdir+./top/test/enviroment/coverage_collector
+incdir+./top/test/enviroment/master_agent
+incdir+./top/test/enviroment/master_agent/driver
+incdir+./top/test/enviroment/master_agent/monitor
+incdir+./top/test/enviroment/master_agent/sequencer
+incdir+./top/test/enviroment/scoreboard
+incdir+./top/test/enviroment/slave_agent
+incdir+./top/test/enviroment/slave_agent/driver
+incdir+./top/test/enviroment/slave_agent/monitor
+incdir+./top/test/enviroment/slave_agent/sequencer

# List of files for the AXI testbench

# Interface files
interface/shared_pkg.sv
interface/AXI_if.sv

# Design file
design/AXI_design/design.sv

# Assertions
design/AXI_Assertions/AXI_assertions.sv

# Enviroment
top/test/enviroment/AXI_env_pkg.sv

# Test file
top/test/test.sv

# Top-level file
top/top.sv