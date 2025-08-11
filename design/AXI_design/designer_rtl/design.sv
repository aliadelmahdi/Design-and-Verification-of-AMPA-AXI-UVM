import shared_pkg::*; // Import shared typedefs, enums, and parameters used in AXI protocol

// Include synthesizable DUT components for AXI interface
`include "AXI_master.sv" // AXI master RTL implementation
`include "AXI_slave.sv"  // AXI slave RTL implementation