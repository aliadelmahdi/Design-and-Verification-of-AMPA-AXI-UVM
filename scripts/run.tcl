# ==========================================================
# Create simulation library
# ==========================================================
vlib work

# ==========================================================
# Compile design, testbench, and UVM files
# -f "scripts/list.f" : File list containing all source files
# -mfcu               : Merge files into a single compilation unit
# +cover -covercells  : Enable code coverage for all design cells
# ==========================================================
vlog -f "scripts/list.f" -mfcu +cover -covercells

# ==========================================================
# Elaborate and simulate top-level testbench
# -sv_seed random    : Randomize simulation seed for varied scenarios
# +acc               : Enable full signal access for debugging
# -cover             : Collect coverage data
# -classdebug        : Enable UVM class debug info
# -uvmcontrol=all    : Allow UVM phase control
# -fsmdebug          : Enable FSM state debugging
# ==========================================================
vsim -sv_seed random -voptargs=+acc work.tb_top -cover -classdebug -uvmcontrol=all -fsmdebug

# ==========================================================
# Save code coverage database upon simulation exit
# -onexit            : Save when simulation ends
# -du work.<module>  : Include coverage for specified design units
# ==========================================================
# ******************************************* #
# Code Coverage
coverage save top.ucdb -onexit -du work.AXI_master -du work.AXI_slave
# ******************************************* #

# ==========================================================
# Enable waveform dumping in VCD format
# ==========================================================
vcd file waves/waves.vcd
vcd add -r /* 

# ==========================================================
# Run the entire simulation
# ==========================================================
run -all

# ==========================================================
# Functional Coverage Reports
# ==========================================================
# ******************************************* #
coverage report -detail -cvg -directive \
    -output "reports/Functional Coverage Report.txt" \
    /AXI_env_pkg/AXI_coverage/*

coverage report -detail -cvg -directive \
    -html -output "reports/Functional Coverage Report" \
    /AXI_env_pkg/AXI_coverage/*
# ******************************************* #

# ==========================================================
# Exit simulation
# ==========================================================
quit -sim

# ==========================================================
# Save coverage reports in text and HTML formats
# ==========================================================
vcover report top.ucdb -details -annotate -all \
    -output "reports/Coverage Report - Code, Assertions, and Directives.txt"
vcover report top.ucdb -details -annotate -html \
    -output "reports/Coverage Report - Code, Assertions, and Directives"
