#!/bin/bash

# ==========================================================
# Disable command echoing for cleaner output
# ==========================================================
set +x

# ==========================================================
# Navigate to the project root directory
# "$(dirname "$0")"  : Path to the script's directory
# "/.."              : Move one level up to project root
# ==========================================================
cd "$(dirname "$0")/.."

# ==========================================================
# Run ModelSim/Questa in command-line mode (-c)
# -do "scripts/run.tcl" : Execute the main simulation script
# ==========================================================
vsim -c -do "scripts/run.tcl"