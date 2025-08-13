`ifndef AXI_W_SVH
`define AXI_W_SVH
  // ---------------------------
  // Write Data Channel (W)
  // ---------------------------
  data_t  wdata;    // Write data from master to slave
  strb_t  wstrb;    // Write strobes: indicates which byte lanes are valid
  logic   wvalid;   // Indicates that the write data is valid
  logic   wready;   // Indicates that the slave is ready to accept the write data
  logic   wlast;    // Indicates the last transfer in a write burst

  // ---------------------------
  // Write Data Channel (W) - REF
  // ---------------------------
  data_t  wdata_ref;   // Write data from master to slave (golden model)
  bit     wvalid_ref;  // Indicates that the write data is valid (golden model)
  bit     wready_ref;  // Indicates that the slave is ready to accept the write data (golden model)
  bit     wlast_ref;   // Indicates the last transfer in a write burst (golden model)
  
`endif // AXI_W_SVH