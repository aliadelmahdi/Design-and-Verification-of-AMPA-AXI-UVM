`ifndef AXI_R_SVH
`define AXI_R_SVH
  // ---------------------------
  // Read Data Channel (R)
  // ---------------------------
  data_t  rdata;    // Read data returned by the slave
  resp_t  rresp;    // Read response (OKAY, SLVERR, DECERR, etc.)
  logic   rvalid;   // Indicates that the read data is valid
  logic   rready;   // Indicates that the master is ready to accept the read data
  logic   rlast;    // Indicates the last transfer in a read burst

  // ---------------------------
  // Read Data Channel (R) - REF
  // ---------------------------
  data_t  rdata_ref;   // Read data returned by the slave (golden model)
  bit     rresp_ref;   // Read response (OKAY, SLVERR, DECERR, etc.) (golden model)
  bit     rvalid_ref;  // Indicates that the read data is valid (golden model)
  bit     rready_ref;  // Indicates that the master is ready to accept the read data (golden model)
  bit     rlast_ref;   // Indicates the last transfer in a read burst (golden model)
  
`endif // AXI_R_SVH