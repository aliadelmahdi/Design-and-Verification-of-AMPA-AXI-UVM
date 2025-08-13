`ifndef AXI_AW_SVH
`define AXI_AW_SVH
  // ---------------------------
  // Write Address Channel (AW)
  // ---------------------------
  addr_t  awaddr;   // Write address for the transaction
  logic   awvalid;  // Indicates that the write address and control signals are valid
  bit     awready;  // Indicates that the slave is ready to accept the write address
  len_t   awlen;    // Burst length for write transactions
  size_t  awsize;   // Burst size for write transactions
  burst_t awburst;  // Burst type for write transactions

  // ---------------------------
  // Write Address Channel (AW) - REF
  // ---------------------------
  addr_t  awaddr_ref;   // Write address for the transaction (golden model)
  bit     awvalid_ref;  // Indicates that the write address and control signals are valid (golden model)
  bit     awready_ref;  // Indicates that the slave is ready to accept the write address (golden model)
  
`endif // AXI_AW_SVH