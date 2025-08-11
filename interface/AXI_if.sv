// Comments referenced I used are from the ARM AMBA AXI4 specifications  
// For detailed information on the AMBA® AXI4 interface, refer to the official ARM specification:
// http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf
import shared_pkg::*; // For enums and parameters

interface AXI_if(input bit aclk);

	// Global Signals
	logic areset_n;   // Active-low reset signal for the interface
	logic start_read; // Control signal to initiate a read transaction
	logic start_write;// Control signal to initiate a write transaction

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
	// Read Data Channel (R)
	// ---------------------------
	data_t  rdata;    // Read data returned by the slave
	resp_t  rresp;    // Read response (OKAY, SLVERR, DECERR, etc.)
	logic   rvalid;   // Indicates that the read data is valid
	logic   rready;   // Indicates that the master is ready to accept the read data
	logic   rlast;    // Indicates the last transfer in a read burst

	// ---------------------------
	// Write Address Channel (AW)
	// ---------------------------
	addr_t  awaddr;   // Write address for the transaction
	logic   awvalid;  // Indicates that the write address and control signals are valid
	logic   awready;  // Indicates that the slave is ready to accept the write address
	len_t   awlen;    // Burst length for write transactions
	size_t  awsize;   // Burst size for write transactions
	burst_t awburst;  // Burst type for write transactions

	// ---------------------------
	// Write Data Channel (W)
	// ---------------------------
	data_t  wdata;    // Write data from master to slave
	strb_t  wstrb;    // Write strobes: indicates which byte lanes are valid
	logic   wvalid;   // Indicates that the write data is valid
	logic   wready;   // Indicates that the slave is ready to accept the write data
	logic   wlast;    // Indicates the last transfer in a write burst

	// ---------------------------
	// Write Response Channel (B)
	// ---------------------------
	resp_t  bresp;    // Write response from slave (OKAY, SLVERR, DECERR, etc.)
	logic   bvalid;   // Indicates that the write response is valid
	logic   bready;   // Indicates that the master is ready to accept the write response


	// Modport for active AXI Master
	modport master_gld (
	output araddr, arvalid, arlen, arsize, arburst,
	input  arready, aclk, areset_n, start_read, start_write,
	input  rdata, rresp, rvalid, rlast,
	output rready,
	output awaddr, awvalid, awlen, awsize, awburst,
	input  awready,
	output wdata, wstrb, wvalid, wlast,
	input  wready,
	input  bresp, bvalid,
	output bready
	);

	// Modport for active AXI Slave
	modport slave_gld (
	input  araddr, arvalid, arlen, arsize, arburst, aclk, areset_n,
	output arready,
	output rdata, rresp, rvalid, rlast,
	input  rready,
	input  awaddr, awvalid, awlen, awsize, awburst,
	output awready,
	input  wdata, wstrb, wvalid, wlast,
	output wready,
	output bresp, bvalid,
	input  bready
	);

	// Modport for master driver (drives master's outputs, observes master's inputs)
	modport master_driver (
	input  aclk, areset_n, start_read, start_write,
	output araddr, arvalid, arlen, arsize, arburst,
	input  arready,
	input  rdata, rresp, rvalid, rlast,
	output rready,
	output awaddr, awvalid, awlen, awsize, awburst,
	input  awready,
	output wdata, wstrb, wvalid, wlast,
	input  wready,
	input  bresp, bvalid,
	output bready
	);

	// Modport for master monitor (only observes signals)
	modport master_monitor (
	input  aclk, areset_n, start_read, start_write,
	input  araddr, arvalid, arlen, arsize, arburst, arready,
	input  rdata, rresp, rvalid, rready, rlast,
	input  awaddr, awvalid, awlen, awsize, awburst, awready,
	input  wdata, wstrb, wvalid, wready, wlast,
	input  bresp, bvalid, bready
	);

	// Modport for slave driver (drives slave's outputs, observes slave's inputs)
	modport slave_driver (
	input  aclk, areset_n,
	input  araddr, arvalid, arlen, arsize, arburst,
	output arready,
	output rdata, rresp, rvalid, rlast,
	input  rready,
	input  awaddr, awvalid, awlen, awsize, awburst,
	output awready,
	input  wdata, wstrb, wvalid, wlast,
	output wready,
	output bresp, bvalid,
	input  bready
	);

	// Modport for slave monitor (only observes signals)
	modport slave_monitor (
	input  aclk, areset_n,
	input  araddr, arvalid, arlen, arsize, arburst, arready,
	input  rdata, rresp, rvalid, rready, rlast,
	input  awaddr, awvalid, awlen, awsize, awburst, awready,
	input  wdata, wstrb, wvalid, wready, wlast,
	input  bresp, bvalid, bready
	);

endinterface : AXI_if
