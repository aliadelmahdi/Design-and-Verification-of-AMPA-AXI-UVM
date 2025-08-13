`ifndef AXI_AR_SVH
`define AXI_AR_SVH
  // ---------------------------
  // Read Address Channel (AR)
  // ---------------------------
  addr_t  araddr;   // Read address for the transaction
  logic   arvalid;  // Indicates that the read address and control signals are valid
  logic   arready;  // Indicates that the slave is ready to accept the read address
  len_t   arlen;    // Burst length: number of data transfers in the burst
  size_t  arsize;   // Burst size: number of bytes per data transfer
  burst_t arburst;  // Burst type: FIXED, INCR, or WRAP

  // ---------------------------
  // Read Address Channel (AR) - REF
  // ---------------------------
  addr_t  araddr_ref;   // Read address for the transaction (golden model)
  bit     arvalid_ref;  // Indicates that the read address and control signals are valid (golden model)
  bit     arready_ref;  // Indicates that the slave is ready to accept the read address (golden model)
  
`endif // AXI_AR_SVH