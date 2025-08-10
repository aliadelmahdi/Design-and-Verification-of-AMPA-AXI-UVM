// Comments referenced I used are from the ARM AMBA AXI4 specifications  
// For detailed information on the AMBA® AXI4 interface, refer to the official ARM specification:
// http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf
import shared_pkg::*; // For enums and parameters

interface AXI_if(input bit aclk);

	logic areset_n;
	logic start_read;
	logic start_write;

	// Read Address Channel
	addr_t araddr;
	logic arvalid;
	logic arready;
	len_t arlen;
	size_t arsize;
	burst_t arburst;

	// Read Data Channel
	data_t rdata;
	resp_t rresp;
	logic rvalid;
	logic rready;
	logic rlast;

	// Write Address Channel
	addr_t awaddr;
	logic awvalid;
	logic awready;
	len_t awlen;
	size_t awsize;
	burst_t awburst;

	// Write Data Channel
	data_t wdata;
	strb_t wstrb;
	logic wvalid;
	logic wready;
	logic wlast;

	// Write Response Channel
	resp_t bresp;
	logic bvalid;
	logic bready;

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
