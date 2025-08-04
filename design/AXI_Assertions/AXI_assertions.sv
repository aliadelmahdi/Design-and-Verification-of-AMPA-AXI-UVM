`ifndef AXI_ASSERTIONS_SV
`define AXI_ASSERTIONS_SV

import shared_pkg::*; // For enums and parameters
`timescale `TIME_UNIT / `TIME_PRECISION

`include "AXI_master_sva.sv"
`include "AXI_slave_sva.sv"

`endif // AXI_ASSERTIONS_SV