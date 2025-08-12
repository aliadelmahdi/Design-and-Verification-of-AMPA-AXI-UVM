# ⚙️ Simulation Scripts

This folder contains scripts and helper files for **compilation, simulation, coverage collection, and automation** when running the UVM-based AXI4 testbench.

**Contents:**

| File / Folder   | Description                                                                                                                                                               |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `run.tcl`       | Main Questa/ModelSim compile and simulation script. Handles library creation, compilation of RTL/UVM sources, simulation setup, waveform dumping, and coverage reporting. |
| `run_all.tcl`   | Automation script to run **multiple UVM tests in sequence**, collect coverage from each, and merge results into a single UCDB and report. Useful for nightly regressions. |
| `run.sh`        | Linux shell wrapper to execute `run.tcl` (or `run_all.tcl`) in batch mode without opening the GUI.                                                                        |
| `run.bat`       | Windows batch file to execute `run.tcl` (or `run_all.tcl`) from the command line on Windows.                                                                                  |
| `list.f`        | Master **file list** of all RTL, interface, UVM, and testbench source files to be compiled. Paths in this file are referenced by the TCL scripts.                         |
| `incdirs.f`     | File containing all `+incdir+` include directory paths needed for compilation. Keeps include paths centralized.                                                           |
| `find_files.py` | Python utility that scans the repository and updates `list.f` and/or `incdirs.f` automatically by discovering SystemVerilog source files and include directories.         |
| `ucdb/`         | Output folder where **coverage databases** (`.ucdb`) are stored for each test and for merged coverage runs.                                                               |
| `sim.log`       | Transcript/log file of the last simulation run, useful for debugging compile-time or run-time issues.                                                                     |
| `README.md`     | This documentation file.                                                                                                                                                  |

> **Note:**
> * Edit `list.f` if you add/remove source files.
> * Edit `incdirs.f` if you add new include directories.
> * `find_files.py` can automate those updates.
> * `run_all.tcl` is especially useful for regression runs where multiple UVM tests and merged coverage reports are required.<br><br>

---