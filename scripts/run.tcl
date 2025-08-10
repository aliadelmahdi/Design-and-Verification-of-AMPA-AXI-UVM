vlib work
vlog  -f "scripts/list.f" -mfcu +cover -covercells
vsim -sv_seed random -voptargs=+acc work.tb_top -cover -classdebug -uvmcontrol=all -fsmdebug 

#*******************************************#
# Code Coverage
coverage save top.ucdb -onexit -du work.AXI_master -du work.AXI_slave
#*******************************************#
vcd file waves/waves.vcd
vcd add -r /* 
run -all
#*******************************************#
# # Functional Coverage Report
# coverage report -detail -cvg -directive \
#     -output "reports/Functional Coverage Report.txt" \
#     /AXI_env_pkg/AXI_coverage/*

# coverage report -detail -cvg -directive \
#     -html -output "reports/Functional Coverage Report" \
#     /AXI_env_pkg/AXI_coverage/*

#*******************************************#
quit -sim
# # Save Coverage Report
# vcover report top.ucdb -details -annotate -all -output "reports/Coverage Report - Code, Assertions, and Directives.txt"
# vcover report top.ucdb -details -annotate -html -output "reports/Coverage Report - Code, Assertions, and Directives"