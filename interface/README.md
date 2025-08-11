# 🔌 AXI Interface Definitions

This folder contains the **AXI interface** and supporting packages.

**Contents:**
- `AXI_if.sv` – Interface definition with modports for master/slave/golden/UVM connections.
- `shared_pkg.sv` – Common typedefs and parameters (addr_t, data_t, etc.).
- `AXI_defines.svh` – Protocol constants and macros.

> Changing typedef widths here affects both RTL and verification components.