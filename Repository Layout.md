
---

## Repository Layout

The include directories and source files are auto‑discovered by `find_files.py` (see `+incdir+` lines).

```
├── design/
│   ├── AXI_Assertions/
│   │   ├── AXI_assertions.sv
│   │   ├── AXI_master_sva.sv
│   │   └── AXI_slave_sva.sv
│   └── AXI_design/
│       ├── designer_rtl/
│       │   ├── AXI_master.sv
│       │   ├── AXI_slave.sv
│       │   └── design.sv
│       └── golden_models/
│           ├── AXI_master_gld.sv
│           ├── AXI_slave_gld.sv
│           └── golden_models.sv
├── interface/
│   ├── AXI_if.sv
│   ├── shared_pkg.sv
│   └── AXI_defines.svh
├── objects/
│   ├── AXI_config.sv
│   ├── master_objects/
│   │   ├── AXI_master_main_sequence.sv
│   │   ├── AXI_master_reset_sequence.sv
│   │   ├── AXI_master_seq_item.sv
│   │   └── AXI_master_sequences.sv
│   └── slave_objects/
│       ├── AXI_slave_main_sequence.sv
│       ├── AXI_slave_seq_item.sv
│       └── AXI_slave_sequences.sv
├── top/
│   ├── test/
│   │   ├── AXI_test_base.sv
│   │   ├── test.sv
│   │   └── enviroment/
│   │       ├── AXI_env.sv
│   │       ├── AXI_env_pkg.sv
│   │       ├── coverage_collector/
│   │       │   └── AXI_coverage_collector.sv
│   │       ├── master_agent/
│   │       │   ├── AXI_master_agent.sv
│   │       │   ├── AXI_master_pkg.sv
│   │       │   ├── driver/
│   │       │   │   └── AXI_master_driver.sv
│   │       │   ├── monitor/
│   │       │   │   └── AXI_master_monitor.sv
│   │       │   └── sequencer/
│   │       │       └── AXI_master_sequencer.sv
│   │       ├── scoreboard/
│   │       │   └── AXI_scoreboard.sv
│   │       └── slave_agent/
│   │           ├── AXI_slave_agent.sv
│   │           ├── AXI_slave_pkg.sv
│   │           ├── driver/
│   │           │   └── AXI_slave_driver.sv
│   │           ├── monitor/
│   │           │   └── AXI_slave_monitor.sv
│   │           └── sequencer/
│   │               └── AXI_slave_sequencer.sv
│   └── top.sv
├── scripts/
│   ├── run.tcl
│   ├── run.sh
│   └── run.bat
├── waves/
│   ├── run.tcl
│   └── run waves.bat
│   └── waves.vcd
│ 
├── reports/
│   ├── Coverage Report - Code, Assertions, and Directives.html
│   ├── Coverage Report - Code, Assertions, and Directives.txt
│   ├── Functional Coverage Report.html
│   └── Functional Coverage Report.txt
├── docs/
│   ├── AXI Golden Model.docx
│   ├── AXI4 Lite specs.pdf
│   └── AXI4_specification.pdf


```