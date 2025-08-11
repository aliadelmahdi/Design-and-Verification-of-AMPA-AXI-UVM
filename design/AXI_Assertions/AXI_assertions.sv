`ifndef AXI_ASSERTIONS_SV
`define AXI_ASSERTIONS_SV

import shared_pkg::*; // Import shared typedefs, enums, and parameters for AXI signals
`timescale `TIME_UNIT / `TIME_PRECISION // Set time unit and precision for assertions

// Include protocol assertion checkers for AXI
`include "AXI_master_sva.sv" // Assertions for AXI master protocol compliance
`include "AXI_slave_sva.sv"  // Assertions for AXI slave protocol compliance

`endif // AXI_ASSERTIONS_SV