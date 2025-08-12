`ifndef AXI_GLOBALS_SVH
`define AXI_GLOBALS_SVH
  // Global Signals
  logic  areset_n;   // Active-low reset signal for the interface
  logic  start_read; // Control signal to initiate a read transaction
  logic  start_write;// Control signal to initiate a write transaction
  data_t data;
  addr_t addr;
  
`endif // AXI_GLOBALS_SVH
