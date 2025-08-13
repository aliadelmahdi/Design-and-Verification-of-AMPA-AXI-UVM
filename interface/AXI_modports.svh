`ifndef AXI_MODPORTS_SVH
`define AXI_MODPORTS_SVH

  // ---------------------------------------------------------
  // MASTER — DRIVER
  // ---------------------------------------------------------
  modport master_driver (
    input  aclk, areset_n, start_read, start_write, addr, data,

    // DUT master outputs
    output araddr, arvalid, arlen, arsize, arburst,
    output awaddr, awvalid, awlen, awsize, awburst,
    output wdata,  wstrb,  wvalid, wlast,
    output rready,
    output bready,

    // DUT master inputs
    input  arready,
    input  rdata,  rresp,  rvalid, rlast,
    input  awready,
    input  wready,
    input  bresp,  bvalid,

    // REF master outputs
    output araddr_ref, arvalid_ref,
    output awaddr_ref, awvalid_ref,
    output wdata_ref, wvalid_ref, wlast_ref,
    output rready_ref,
    output bready_ref,

    // REF master inputs
    input  arready_ref,
    input  rdata_ref,  rresp_ref,  rvalid_ref, rlast_ref,
    input  awready_ref,
    input  wready_ref,
    input  bresp_ref,  bvalid_ref
  );

  // ---------------------------------------------------------
  // MASTER — MONITOR
  // ---------------------------------------------------------
  modport master_monitor (
    input  aclk, areset_n, start_read, start_write, addr, data,

    // DUT
    input  araddr, arvalid, arlen, arsize, arburst, arready,
    input  rdata,  rresp,  rvalid, rready, rlast,
    input  awaddr, awvalid, awlen, awsize, awburst, awready,
    input  wdata,  wstrb,  wvalid, wready, wlast,
    input  bresp,  bvalid, bready, m_fsm_state,

    // REF
    input  araddr_ref, arvalid_ref, arready_ref,
    input  rdata_ref,  rresp_ref,  rvalid_ref,  rready_ref, rlast_ref,
    input  awaddr_ref, awvalid_ref, awready_ref,
    input  wdata_ref,  wvalid_ref,  wready_ref, wlast_ref,
    input  bresp_ref,  bvalid_ref, bready_ref
  );

  // ---------------------------------------------------------
  // SLAVE — DRIVER
  // ---------------------------------------------------------
  modport slave_driver (
    input  aclk, areset_n,

    // DUT slave inputs (from master)
    input  araddr, arvalid, arlen, arsize, arburst,
    input  awaddr, awvalid, awlen, awsize, awburst,
    input  wdata,  wstrb,  wvalid, wlast,
    input  rready,
    input  bready,

    // DUT slave outputs
    output arready,
    output rdata,  rresp,  rvalid, rlast,
    output awready,
    output wready,
    output bresp,  bvalid,

    // REF slave inputs (from ref master)
    input  araddr_ref, arvalid_ref,
    input  awaddr_ref, awvalid_ref,
    input  wdata_ref,  wvalid_ref, wlast_ref,
    input  rready_ref,
    input  bready_ref,

    // REF slave outputs
    output arready_ref,
    output rdata_ref,  rresp_ref,  rvalid_ref,  rlast_ref,
    output awready_ref,
    output wready_ref,
    output bresp_ref,  bvalid_ref
  );

  // ---------------------------------------------------------
  // SLAVE — MONITOR
  // ---------------------------------------------------------
  modport slave_monitor (
    input  aclk, areset_n,

    // DUT
    input  araddr, arvalid, arlen, arsize, arburst, arready,
    input  rdata,  rresp,  rvalid,  rready, rlast,
    input  awaddr, awvalid, awlen,  awsize, awburst, awready,
    input  wdata,  wstrb,  wvalid,  wready, wlast,
    input  bresp,  bvalid,  bready, s_fsm_state,

    // REF
    input  araddr_ref, arvalid_ref, arready_ref,
    input  rdata_ref,  rresp_ref,  rvalid_ref,  rready_ref, rlast_ref,
    input  awaddr_ref, awvalid_ref, awready_ref,
    input  wdata_ref,  wvalid_ref,  wready_ref, wlast_ref,
    input  bresp_ref,  bvalid_ref,  bready_ref
  );

  // ------------------------------------------------------------
  // Modport for active AXI Master Golden Model (REF master)
  // ------------------------------------------------------------
  modport master_gld (
    // REF master outputs
    output araddr_ref, arvalid_ref, arlen, arsize, arburst,
    output awaddr_ref, awvalid_ref, awlen, awsize, awburst,
    output wdata_ref,  wstrb,  wvalid_ref, wlast_ref,
    output rready_ref,
    output bready_ref,

    // REF master inputs
    input  arready_ref, aclk, areset_n, start_read, start_write, addr, data,
    input  rdata_ref,  rresp_ref,  rvalid_ref, rlast_ref,
    input  awready_ref,
    input  wready_ref,
    input  bresp_ref,  bvalid_ref
  );

  // ------------------------------------------------------------
  // Modport for active AXI Master (DUT master)
  // ------------------------------------------------------------
  modport master (
    // DUT master outputs
    output araddr, arvalid, arlen, arsize, arburst,
    output awaddr, awvalid, awlen, awsize, awburst,
    output wdata,  wstrb,  wvalid, wlast,
    output rready,
    output bready,

    // DUT master inputs
    input  arready, aclk, areset_n, start_read, start_write, addr, data,
    input  rdata,  rresp,  rvalid, rlast,
    input  awready,
    input  wready,
    input  bresp,  bvalid
  );

  // ------------------------------------------------------------
  // Modport for active AXI Slave (DUT slave)
  // ------------------------------------------------------------
  modport slave (
    // DUT slave inputs
    input  araddr, arvalid, arlen, arsize, arburst, aclk, areset_n,
    input  awaddr, awvalid, awlen, awsize, awburst,
    input  wdata,  wstrb,  wvalid, wlast,
    input  rready,
    input  bready,

    // DUT slave outputs
    output arready,
    output rdata,  rresp,  rvalid, rlast,
    output awready,
    output wready,
    output bresp,  bvalid
  );

  // ------------------------------------------------------------
  // Modport for active AXI Slave Golden Model (REF slave)
  // ------------------------------------------------------------
  modport slave_gld (
    // REF slave inputs
    input  araddr_ref, arvalid_ref, arlen, arsize, arburst, aclk, areset_n,
    input  awaddr_ref, awvalid_ref, awlen, awsize, awburst,
    input  wdata_ref,  wstrb,  wvalid_ref, wlast_ref,
    input  rready_ref,
    input  bready_ref,

    // REF slave outputs
    output arready_ref,
    output rdata_ref,  rresp_ref,  rvalid_ref,  rlast_ref,
    output awready_ref,
    output wready_ref,
    output bresp_ref,  bvalid_ref
  );

`endif // AXI_MODPORTS_SVH