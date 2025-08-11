# Design & Verification of an AMBA AXI4 System (UVM)

> Master/Slave RTL + Golden Models • UVM Environment with Active Master Agent & Passive Slave Agent • AXI Protocol Assertions • Functional & Code Coverage • Cross‑platform run scripts (Windows/Linux) • Waveform & Reports

---

## Table of Contents

* [Overview](#overview)
* [Why AXI4 & Where It’s Used](#why-axi4--where-its-used)
* [Protocol Primer (AXI4 vs AXI4‑Lite vs AXI4‑Stream)](#protocol-primer-axi4-vs-axi4lite-vs-axi4stream)
* [Finite State Machines (FSMs)](#finite-state-machines-fsms)

  * [Master — FSM](#master--fsm)
  * [Slave — FSM](#slave--fsm)
* [UVM Verification Architecture](#uvm-verification-architecture)

  * [Why Active Master Agent & Passive Slave Agent?](#why-active-master-agent--passive-slave-agent)
  * [Transactions, Sequences, Drivers & Monitors](#transactions-sequences-drivers--monitors)
  * [Scoreboard & Coverage Collector](#scoreboard--coverage-collector)
* [Assertions (SVA)](#assertions-sva)
* [Functional & Code Coverage](#functional--code-coverage)
* [Repository Layout](#repository-layout)
* [Getting Started](#getting-started)

  * [Prerequisites](#prerequisites)
  * [Clone the Repository](#clone-the-repository)
  * [Build & Run (Windows / Linux)](#build--run-windows--linux)
  * [Waveforms (GTKWave)](#waveforms-gtkwave)
  * [Reports (Coverage & Assertions)](#reports-coverage--assertions)
* [Configuration Notes](#configuration-notes)
* [How to Extend](#how-to-extend)
* [References](#references)

---

## Overview

This repository contains a **complete design-and-verification flow** for an **AMBA AXI4** system consisting of a **Master** and **Slave**. Each block is provided in two forms:

* **Golden Models** (behavioral/SystemVerilog) — clean reference behavior used for checking.
* **Designer RTL** — synthesizable implementations intended for Vivado flows.

The verification environment is built in **UVM 1.2** and includes:

* **Active Master Agent** (driver + sequencer + monitor)
* **Passive Slave Agent** (monitor-only)
* **Scoreboard** (reference vs. RTL compare)
* **Coverage Collector** (functional coverage of protocol features)
* **AXI Protocol Assertions** (SVA) bound to interfaces

Cross‑platform simulation is supported via **run scripts** for **QuestaSim/ModelSim**:

* Windows: `run.bat`
* Linux: `run.sh`

Waveform post-processing is available via **GTKWave** scripts.

> **Repo:** [https://github.com/aliadelmahdi/Design-and-Verification-of-AMPA-AXI-UVM](https://github.com/aliadelmahdi/Design-and-Verification-of-AMPA-AXI-UVM)

---

## Why AXI4 & Where It’s Used

**AMBA AXI4** is a de‑facto standard interconnect for SoCs. It provides a high‑performance, memory‑mapped, burst‑capable interface between masters (CPUs, DMA engines) and slaves (memories, peripherals). AXI4 is ubiquitous in **ARM‑based SoCs, Xilinx/AMD Vivado IP Integrator designs (Zynq/ZynqMP/Versal)**, and custom ASICs/FPGA systems that require scalable bandwidth, well‑defined handshakes, and decoupled address/data channels.

<p align="center">
  <img width="565" height="644" alt="axi" src="https://github.com/user-attachments/assets/938bdd5b-8491-413e-8451-d38a674ff2c1" />
</p>

Typical deployments:

* **Processor ↔ Memory/Cache** interfaces
* **DMA/IP Masters ↔ Memory‑mapped peripherals**
* **FPGA IP blocks** integrated via **Vivado** AXI interconnect

---

## Protocol Primer (AXI4 vs AXI4‑Lite vs AXI4‑Stream)

* **AXI4** (this project): memory‑mapped, supports **bursts** (length/size/burst type), separate **Read** and **Write** address/data channels.
* **AXI4‑Lite**: simplified subset (no bursts), ideal for control/status registers.
* **AXI4‑Stream**: unidirectional streaming with no address channel.

**Common handshake**: every channel uses **VALID/READY** two‑way flow control. Transfers complete on a rising edge where both VALID and READY are asserted.


---

## Finite State Machines (FSMs)

Each block implements a compact FSM covering address, data, and response phases.

### Master — FSM

**States (example):** `IDLE → RADDR → RDATA` and `IDLE → WADDR → WDATA → WRESP`.

* **IDLE**: wait for `start_read` / `start_write` (via `AXI_if`).
* **RADDR**: drive `ARADDR/ARLEN/ARSIZE/ARBURST` and assert `ARVALID`; advance when `ARREADY`.
* **RDATA**: assert `RREADY`; collect beats until `RLAST`; handle `RRESP`.
* **WADDR**: drive `AW*` and assert `AWVALID`; wait for `AWREADY`.
* **WDATA**: stream `WDATA/WSTRB`, assert `WVALID`; assert `WLAST` on final beat; await `WREADY`.
* **WRESP**: assert `BREADY` and check `BRESP` (OKAY/SLVERR/DECERR) then return to `IDLE`.

Master Golden Model FSM
<p align="center">
  <img width="565" height="644" alt="axi_master_gld fsm" src="https://github.com/user-attachments/assets/e089f3b6-941b-492b-a032-1075fa48bc0f" />
</p>

### Slave — FSM

**Read path:** address accept → data return → final `RLAST` and `RRESP`.
**Write path:** address accept → data absorb (track beats, check `WLAST`) → response.

Emphasizes **protocol correctness** and simple memory model behavior for comparison.

Slave Golden Model FSM
<p align="center">
  <img width="565" height="644" alt="axi_slave_gld fsm" src="https://github.com/user-attachments/assets/c34fe9a3-2c0e-4730-892f-8fdb1acca23f" />
</p>

---

## UVM Verification Architecture

<p align="center">
  <img width="565" height="644" alt="UVM Testbench Architecture" src="https://github.com/user-attachments/assets/9e8a243f-1577-4e3f-a034-327c4359997b" />
</p>

The **`AXI_if.sv`** interface defines signals and **modports** for master/slave **golden models** and for **UVM drivers/monitors**, enabling clean separation of concerns and preventing illegal multi‑driving.

The UVM environment is packaged under `top/test/enviroment/` (intentional spelling kept to match source):

* **`AXI_env.sv` / `AXI_env_pkg.sv`** — top‑level env, config, factory, connections.
* **Agents**

  * **Master Agent (active)**: `driver/`, `monitor/`, `sequencer/`, `AXI_master_pkg.sv`.
  * **Slave Agent (passive)**: `monitor/`, `AXI_slave_pkg.sv`.
* **Scoreboard**: protocol/data checking against golden models.
* **Coverage Collector**: samples transactions for functional coverage.

### Why Active Master Agent & Passive Slave Agent?

* The **DUT drives the slave‑side signals**; actively driving them from UVM would cause **bus contention**. A **passive slave agent** avoids multi‑driving and focuses on **observation**.
* The **master side is the stimulus source**, so an **active master agent** naturally sequences **reads/writes, bursts, back‑pressure scenarios**, etc.
* This split mirrors real SoC use: software (master) initiates; peripherals (slaves) respond.

### Transactions, Sequences, Drivers & Monitors

* **Transaction types** live under `objects/`:

  * Master: `master_objects/AXI_master_seq_item.sv`, sequences (`*_sequences.sv`).
  * Slave: `slave_objects/AXI_slave_seq_item.sv`, sequences (`*_sequences.sv`).
* **Drivers** convert seq\_items → **`AXI_if`** pin wiggles (master only).
* **Monitors** observe channels and publish via **analysis ports** to scoreboard/coverage.

### Scoreboard & Coverage Collector

* **Scoreboard** consumes **golden model outputs** and **observed RTL** to check data, response, and timing expectations.
* **Coverage** tracks: burst length/size/type, read/write mixes, back‑pressure, responses, `WSTRB` patterns, and corner cases (single‑beat vs multi‑beat, `RLAST/WLAST` alignment, etc.). See `coverage_collector/AXI_coverage_collector.sv`.

---

## Assertions (SVA)

Protocol properties live in `design/AXI_Assertions/`:

* **`AXI_assertions.sv`** (bind/glue)
* **`AXI_master_sva.sv`, `AXI_slave_sva.sv`** (channel‑specific properties)

Representative checks:

* **VALID/READY** handshake completion and stability of address/control when `VALID && !READY`.
* **Write path**: `WLAST` must assert on the final beat; `BVALID` only after **both** AW and all W handshakes.
* **Read path**: `RLAST` must assert on last beat of a burst; `RRESP` stability while `RVALID && !RREADY`.

Assertions run during simulation and are summarized in the generated reports.

---

## Functional & Code Coverage

Simulation generates a **UCDB** (`top.ucdb`). Use the supplied `vcover` commands to export **text** and **HTML** coverage reports (**code + assertions + directives**) and **functional coverage** reports:

```tcl
# Code / Assertions / Directives
vcover report top.ucdb -details -annotate -all -output "reports/Coverage Report - Code, Assertions, and Directives.txt"
vcover report top.ucdb -details -annotate -html -output "reports/Coverage Report - Code, Assertions, and Directives"

# Functional Coverage (collector paths under AXI_env_pkg)
coverage report -detail -cvg -directive \
    -output "reports/Functional Coverage Report.txt" \
    /AXI_env_pkg/AXI_coverage/*

coverage report -detail -cvg -directive \
    -html -output "reports/Functional Coverage Report" \
    /AXI_env_pkg/AXI_coverage/*
```

Open the HTML outputs in any browser; the text files are CI‑friendly.

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

**Key files & folders (selection):**

* **Design**

  * `design/AXI_design/designer_rtl/AXI_master.sv`, `AXI_slave.sv`, `design.sv`
  * `design/AXI_design/golden_models/AXI_master_gld.sv`, `AXI_slave_gld.sv`, `golden_models.sv`
  * `design/AXI_Assertions/*.sv` — SVA
* **Interface**

  * `interface/AXI_if.sv` — AXI signals + modports for golden/driver/monitor
* **Verification Objects**

  * `objects/master_objects/*` — master seq\_items, sequences, reset/main sequences
  * `objects/slave_objects/*` — slave seq\_items & sequences
  * `top/test/enviroment/...` — UVM env, agents, drivers, monitors, sequencers, scoreboard, coverage
  * `top/test/test.sv`, `top/test/AXI_test_base.sv`
* **Top**

  * `top.sv` — top‑level, interface instances, DUT+golden wiring
* **Docs**

  * `docs/AXI4_specification.pdf`, `docs/AXI4 Lite specs.pdf`, `docs/AXI Golden Model.docx`
* **Scripts**

  * `scripts/run.tcl` — simulation dofile entry
  * `waves/run.tcl` — post‑sim wave extraction
* **Reports**

  * `reports/` — code & functional coverage (HTML + TXT)
* **Waves**

  * `waves/` — helpers for GTKWave and waveform export

---

## Getting Started

### Prerequisites

* **Simulator**: Siemens **QuestaSim/ModelSim** with **SystemVerilog + UVM 1.2** support
* **Synthesis/IP (optional)**: **Xilinx/AMD Vivado** (for packaging or hw exploration)
* **Tcl**: available on your PATH (both `vsim` and `tclsh`)
* **GTKWave**: for optional waveform viewing

> If your simulator ships with built‑in UVM, no extra compile step is needed. Otherwise, point `UVM_HOME` to your UVM library.

### Clone the Repository

```bash
# HTTPS
git clone https://github.com/aliadelmahdi/Design-and-Verification-of-AMPA-AXI-UVM.git
cd Design-and-Verification-of-AMPA-AXI-UVM
```

### Build & Run (Windows / Linux)

#### Windows

```bat
:: From repo root
run.bat
```

`run.bat` launches Questa **in batch** and executes `scripts/run.tcl`.

#### Linux

```bash
# From repo root
chmod +x run.sh
./run.sh
```

`run.sh` changes to repo root and invokes `vsim -c -do scripts/run.tcl`.

> The Tcl script compiles sources (via the include lists), elaborates `top`, runs simulations, and writes `top.ucdb` and wave dumps (if configured).

### Waveforms (GTKWave)

**Windows** helper (`waves\run waves.bat`) runs a Tcl flow that collects signals and launches post‑processing:

```bat
@echo off
cd /d "%~dp0\.."
start /min cmd /c "tclsh waves/run.tcl"
```

On Linux you can invoke Tcl directly:

```bash
tclsh waves/run.tcl
```

Ensure **GTKWave** is installed and on PATH when opening `.vcd`/`.fst` generated by the script.



## Configuration Notes

* **Bus widths & params** come from `shared_pkg.sv` and the interface typedefs (`addr_t`, `data_t`, etc.). Defaults target **32‑bit** data (`SIZE_4_BYTE`).
* **Burst type** in the golden master defaults to **INCR** (`BURST_INCR`). Extend as needed.
* **AXI\_if modports**:

  * `master_gld`, `slave_gld` for golden models
  * `master_driver`, `master_monitor`, `slave_driver`, `slave_monitor` for UVM
* **Reset** is **active‑low** (`areset_n`) and is sampled on `ACLK` edges (async assert).

---

## How to Extend

* **Add new sequences** under `objects/*_sequences.sv` to randomize burst length, size, and back‑pressure scenarios.
* **Enhance assertions** to cover additional AXI options (e.g., WRAP/FIXED bursts, exclusive accesses if added).
* **Plug alternative memories** into the slave RTL for latency modeling.
* **Parameterize widths** via `shared_pkg.sv` to scale to 64/128‑bit data paths.
* **Hook into CI** (GitHub Actions) to run regressions and publish coverage HTML as artifacts.

---

## References

* **ARM AMBA AXI4 Specification** (official ARM docs)
* **AXI4‑Lite primer** and examples (e.g., RealDigital: AXI basics & transactions)
* **Vivado** documentation for AXI IP packaging/integration

> See `docs/AXI4_specification.pdf` and `docs/AXI4 Lite specs.pdf`.

---

**Issues & Discussions**: Please open a GitHub issue with logs, tool versions, and steps to reproduce.
