@echo off
REM ==========================================================
REM Turn off command echoing for cleaner output
REM ==========================================================

REM ==========================================================
REM Navigate to the project root directory (uncomment if needed)
REM "%~dp0" : Path to this batch file's directory
REM "\.."   : Move one level up to the project root
REM ==========================================================
REM cd /d "%~dp0\.."

REM ==========================================================
REM Run ModelSim/Questa in command-line mode (-c)
REM -do "scripts/run.tcl" : Execute the main simulation script
REM ==========================================================
rm vsim.wlf
vsim -c -do "scripts/run.tcl" | tee scripts/sim.log
@REM vsim -c -do "scripts/run_all.tcl" | tee scripts/sim.log