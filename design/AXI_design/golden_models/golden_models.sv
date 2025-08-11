import shared_pkg::*; // Import shared typedefs, enums, and parameters

// Include golden reference models for AXI protocol
`include "AXI_master_gld.sv" // Golden model of AXI master behavior
`include "AXI_slave_gld.sv"  // Golden model of AXI slave behavior