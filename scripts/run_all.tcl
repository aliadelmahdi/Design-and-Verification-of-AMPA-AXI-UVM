# Compile once (adjust paths/options as needed)
vlib work
vlog -f "scripts/list.f" -mfcu +cover -covercells

# List your tests
set tests {AXI_smoke_test AXI_burst_modes_test AXI_flow_control_test AXI_robustness_test}

file delete -force scripts/ucdb
file mkdir scripts/ucdb

foreach t $tests {
  puts "=== Running $t ==="
  # Launch a fresh sim per test
  vsim -c -quiet -sv_seed random -voptargs=+acc work.tb_top -cover -classdebug -uvmcontrol=all -fsmdebug +UVM_TESTNAME=$t

  # Save UCDB with per-test name; include specific design units if you want
  coverage save scripts/ucdb/${t}.ucdb -onexit -du work.AXI_master -du work.AXI_slave
  run -all
  quit -sim
}

# Merge all test UCDBs
vcover merge scripts/ucdb/merged.ucdb scripts/ucdb/*.ucdb

# One combined coverage report (code + assertions + functional)
vcover report scripts/ucdb/merged.ucdb -details -annotate -all \
  -output "reports/Coverage Report - Code, Assertions, and Directives.txt"

vcover report scripts/ucdb/merged.ucdb -details -annotate -html \
  -output "reports/Coverage Report - Code, Assertions, and Directives"

quit -sim
