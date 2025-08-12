`ifndef AXI_B_SVH
`define AXI_B_SVH
  // ---------------------------
  // Write Response Channel (B)
  // ---------------------------
  resp_t  bresp;    // Write response from slave (OKAY, SLVERR, DECERR, etc.)
  logic   bvalid;   // Indicates that the write response is valid
  logic   bready;   // Indicates that the master is ready to accept the write response

  // ---------------------------
  // Write Response Channel (B) - REF
  // ---------------------------
  resp_t  bresp_ref;   // Write response from slave (OKAY, SLVERR, DECERR, etc.) (golden model)
  logic   bvalid_ref;  // Indicates that the write response is valid (golden model)
  logic   bready_ref;  // Indicates that the master is ready to accept the write response (golden model)
  
`endif // AXI_B_SVH