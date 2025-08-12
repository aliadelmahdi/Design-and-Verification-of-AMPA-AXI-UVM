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
  logic   arvalid_ref;  // Indicates that the read address and control signals are valid (golden model)
  logic   arready_ref;  // Indicates that the slave is ready to accept the read address (golden model)
  len_t   arlen_ref;    // Burst length: number of data transfers in the burst (golden model)
  size_t  arsize_ref;   // Burst size: number of bytes per data transfer (golden model)
  burst_t arburst_ref;  // Burst type: FIXED, INCR, or WRAP (golden model)
  
`endif // AXI_AR_SVH