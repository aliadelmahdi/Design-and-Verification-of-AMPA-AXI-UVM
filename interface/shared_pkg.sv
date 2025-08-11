package shared_pkg;

    // Include macros inside the package
    `include "AXI_defines.svh"
    `include "uvm_macros.svh"
    
	// ---------------------------
	// Parameter Definitions
	// ---------------------------

	localparam ADDR_WIDTH = 32;              // Width of the address bus (in bits)
	localparam DATA_WIDTH = 32;              // Width of the data bus (in bits)
	localparam STRB_WIDTH = DATA_WIDTH / 8;  // Width of the write strobe signal (1 bit per byte)

	// ---------------------------
	// AXI Transfer Sizes (ARSIZE / AWSIZE)
	// ---------------------------
	// Specifies the number of bytes per transfer
	localparam SIZE_1_BYTE   = 3'b000; // Transfer size: 1 byte
	localparam SIZE_2_BYTE   = 3'b001; // Transfer size: 2 bytes
	localparam SIZE_4_BYTE   = 3'b010; // Transfer size: 4 bytes
	localparam SIZE_8_BYTE   = 3'b011; // Transfer size: 8 bytes
	localparam SIZE_16_BYTE  = 3'b100; // Transfer size: 16 bytes
	localparam SIZE_32_BYTE  = 3'b101; // Transfer size: 32 bytes
	localparam SIZE_64_BYTE  = 3'b110; // Transfer size: 64 bytes
	localparam SIZE_128_BYTE = 3'b111; // Transfer size: 128 bytes

	// ---------------------------
	// AXI Burst Types (ARBURST / AWBURST)
	// ---------------------------
	// Defines how the address changes between transfers
	localparam BURST_FIXED = 2'b00; // Address remains the same for every transfer
	localparam BURST_INCR  = 2'b01; // Address increments after each transfer
	localparam BURST_WRAP  = 2'b10; // Address wraps around at a boundary (useful for circular buffers)

	// ---------------------------
	// AXI Response Codes (RRESP / BRESP)
	// ---------------------------
	// Indicates the status of a read or write transaction
	localparam RESP_OKAY   = 2'b00; // Normal access success
	localparam RESP_EXOKAY = 2'b01; // Exclusive access okay (AXI3 feature, rarely used in AXI4)
	localparam RESP_SLVERR = 2'b10; // Slave error (e.g., unsupported address)
	localparam RESP_DECERR = 2'b11; // Decode error (e.g., no slave at given address)

	// ---------------------------
	// Data Types
	// ---------------------------
	// Custom typedefs for AXI signal readability and maintainability
	typedef logic [ADDR_WIDTH - 1 : 0] addr_t; // Address type
	typedef logic [DATA_WIDTH - 1 : 0] data_t; // Data type
	typedef logic [STRB_WIDTH - 1 : 0] strb_t; // Write strobe type (byte enables)
	typedef logic [7 : 0] len_t;               // Burst length type (number of transfers in burst - 1)
	typedef logic [2 : 0] size_t;              // Burst size type (bytes per transfer)
	typedef logic [1 : 0] burst_t;             // Burst type
	typedef logic [1 : 0] resp_t;              // Response type


endpackage : shared_pkg
    