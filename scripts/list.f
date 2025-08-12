# ==========================================================
# Include Directories for AXI Testbench Compilation
# ==========================================================

# --------------------------
# Design & Assertions
# --------------------------
+incdir+./design
+incdir+./design/AXI_Assertions
+incdir+./design/AXI_design
+incdir+./design/AXI_design/designer_rtl
+incdir+./design/AXI_design/golden_models

# --------------------------
# Interfaces
# --------------------------
+incdir+./interface

# --------------------------
# UVM Transaction Objects
# --------------------------
+incdir+./objects
+incdir+./objects/master_objects
+incdir+./objects/master_objects/address_alignment
+incdir+./objects/master_objects/backpressure
+incdir+./objects/master_objects/basic_ops
+incdir+./objects/master_objects/burst_patterns
+incdir+./objects/master_objects/data_strobe
+incdir+./objects/master_objects/error_and_reset
+incdir+./objects/master_objects/mixed_traffic
+incdir+./objects/master_objects/stress
+incdir+./objects/slave_objects

# --------------------------
# Testbench Top-Level
# --------------------------
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

# ==========================================================
# File Compilation Order
# ==========================================================

# --------------------------
# 1- Interfaces
# --------------------------
interface/shared_pkg.sv
interface/AXI_if.sv

# --------------------------
# 2- Design
# --------------------------
design/AXI_design/designer_rtl/design.sv
design/AXI_design/golden_models/golden_models.sv

# --------------------------
# 3- Assertions
# --------------------------
design/AXI_Assertions/AXI_assertions.sv

# --------------------------
# 4- Environment
# --------------------------
top/test/enviroment/AXI_env_pkg.sv

# --------------------------
# 5- Test
# --------------------------
top/test/test.sv

# --------------------------
# 6- Top-Level
# --------------------------
top/top.sv