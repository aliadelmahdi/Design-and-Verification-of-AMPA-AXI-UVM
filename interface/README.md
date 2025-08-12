# 🔌 AXI Interface Definitions

This folder contains the **AXI interface** and supporting packages, split into smaller include files for modularity and clarity.

## Structure and Division
The main interface (`AXI_if.sv`) is divided into separate files, each handling a specific part of the AMBA AXI4 protocol:

- **`AXI_globals.svh`** – Global parameters, typedefs, and common signals used across all channels.
- **`AXI_ar.svh`** – Read Address (AR) channel signals, such as `araddr`, `arlen`, `arburst`, etc.
- **`AXI_r.svh`** – Read Data (R) channel signals, such as `rdata`, `rresp`, `rlast`, etc.
- **`AXI_aw.svh`** – Write Address (AW) channel signals, such as `awaddr`, `awlen`, `awburst`, etc.
- **`AXI_w.svh`** – Write Data (W) channel signals, such as `wdata`, `wstrb`, `wlast`, etc.
- **`AXI_b.svh`** – Write Response (B) channel signals, such as `bresp`, `bvalid`, `bready`, etc.
- **`AXI_modports.svh`** – Modport definitions specifying the direction of signals for master, slave, golden models, and UVM agents.

## Supporting Packages
- **`shared_pkg.sv`** – Common typedefs and parameters (`addr_t`, `data_t`, sizes, enums, etc.).
- **`AXI_defines.svh`** – Protocol constants and reusable macros.

> Changing typedef widths in `shared_pkg.sv` or constants in `AXI_defines.svh` will affect both RTL and verification environments.