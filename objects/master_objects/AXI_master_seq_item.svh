`ifndef AXI_MASTER_SEQ_ITEM_SVH
`define AXI_MASTER_SEQ_ITEM_SVH

// AXI Master Sequence Item - defines a single master transaction's data fields
class AXI_master_seq_item extends uvm_sequence_item;

    // Global Signals 
    rand logic areset_n;   // Active-low reset signal for the interface
    rand logic start_read; // Control signal to initiate a read transaction
    rand logic start_write;// Control signal to initiate a write transaction
    rand data_t data;
    rand addr_t addr;
    bit [2:0] m_fsm_state;

    // ---------------------------
    // Read Address Channel (AR)
    // ---------------------------
    addr_t  araddr;   // Read address for the transaction
    logic   arvalid;  // Indicates that the read address and control signals are valid
    logic   arready;  // Indicates that the slave is ready to accept the read address
    rand len_t   arlen;    // Burst length: number of data transfers in the burst
    rand size_t  arsize;   // Burst size: number of bytes per data transfer
    rand burst_t arburst;  // Burst type: FIXED, INCR, or WRAP

    // ---------- REF ----------
    addr_t  araddr_ref;   // Read address for the transaction
    logic   arvalid_ref;  // Indicates that the read address and control signals are valid
    logic   arready_ref;  // Indicates that the slave is ready to accept the read address

    // ---------------------------
    // Read Data Channel (R)
    // ---------------------------
    data_t  rdata;    // Read data returned by the slave
    resp_t  rresp;    // Read response (OKAY, SLVERR, DECERR, etc.)
    logic   rvalid;   // Indicates that the read data is valid
    logic   rready;   // Indicates that the master is ready to accept the read data
    logic   rlast;    // Indicates the last transfer in a read burst

    // ---------- REF ----------
    data_t  rdata_ref;    // Read data returned by the slave
    resp_t  rresp_ref;    // Read response (OKAY, SLVERR, DECERR, etc.)
    logic   rvalid_ref;   // Indicates that the read data is valid
    logic   rready_ref;   // Indicates that the master is ready to accept the read data
    logic   rlast_ref;    // Indicates the last transfer in a read burst

    // ---------------------------
    // Write Address Channel (AW)
    // ---------------------------
    addr_t  awaddr;   // Write address for the transaction
    logic   awvalid;  // Indicates that the write address and control signals are valid
    logic   awready;  // Indicates that the slave is ready to accept the write address
    rand len_t   awlen;    // Burst length for write transactions
    rand size_t  awsize;   // Burst size for write transactions
    rand burst_t awburst;  // Burst type for write transactions

    // ---------- REF ----------
    addr_t  awaddr_ref;   // Write address for the transaction
    logic   awvalid_ref;  // Indicates that the write address and control signals are valid
    logic   awready_ref;  // Indicates that the slave is ready to accept the write address

    // ---------------------------
    // Write Data Channel (W)
    // ---------------------------
    data_t  wdata;    // Write data from master to slave
    rand strb_t  wstrb;    // Write strobes: indicates which byte lanes are valid
    logic   wvalid;   // Indicates that the write data is valid
    logic   wready;   // Indicates that the slave is ready to accept the write data
    logic   wlast;    // Indicates the last transfer in a write burst

    // ---------- REF ----------
    data_t  wdata_ref;    // Write data from master to slave
    logic   wvalid_ref;   // Indicates that the write data is valid
    logic   wready_ref;   // Indicates that the slave is ready to accept the write data
    logic   wlast_ref;    // Indicates the last transfer in a write burst

    // ---------------------------
    // Write Response Channel (B)
    // ---------------------------
    resp_t  bresp;    // Write response from slave (OKAY, SLVERR, DECERR, etc.)
    logic   bvalid;   // Indicates that the write response is valid
    logic   bready;   // Indicates that the master is ready to accept the write response

    // ---------- REF ----------
    resp_t  bresp_ref;    // Write response from slave (OKAY, SLVERR, DECERR, etc.)
    logic   bvalid_ref;   // Indicates that the write response is valid
    logic   bready_ref;   // Indicates that the master is ready to accept the write response

    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------
    function new(string name = "AXI_master_seq_item");
        super.new(name);
    endfunction : new

    // ------------------------------------------------------------------------
    // Factory registration
    // ------------------------------------------------------------------------

    `uvm_object_utils_begin(AXI_master_seq_item)
        `uvm_field_int(areset_n   , UVM_DEFAULT)
        `uvm_field_int(start_read , UVM_DEFAULT)
        `uvm_field_int(start_write, UVM_DEFAULT)
        `uvm_field_int(data       , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(addr       , UVM_DEFAULT | UVM_HEX)

        `uvm_field_int(araddr     , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(arvalid    , UVM_DEFAULT)
        `uvm_field_int(arready    , UVM_DEFAULT)
        `uvm_field_int(arlen      , UVM_DEFAULT)
        `uvm_field_int(arsize     , UVM_DEFAULT)
        `uvm_field_int(arburst    , UVM_DEFAULT)

        `uvm_field_int(rdata      , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(rresp      , UVM_DEFAULT)
        `uvm_field_int(rvalid     , UVM_DEFAULT)
        `uvm_field_int(rready     , UVM_DEFAULT)
        `uvm_field_int(rlast      , UVM_DEFAULT)

        `uvm_field_int(awaddr     , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(awvalid    , UVM_DEFAULT)
        `uvm_field_int(awready    , UVM_DEFAULT)
        `uvm_field_int(awlen      , UVM_DEFAULT)
        `uvm_field_int(awsize     , UVM_DEFAULT)
        `uvm_field_int(awburst    , UVM_DEFAULT)

        `uvm_field_int(wdata      , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(wstrb      , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(wvalid     , UVM_DEFAULT)
        `uvm_field_int(wready     , UVM_DEFAULT)
        `uvm_field_int(wlast      , UVM_DEFAULT)

        `uvm_field_int(bresp      , UVM_DEFAULT)
        `uvm_field_int(bvalid     , UVM_DEFAULT)
        `uvm_field_int(bready     , UVM_DEFAULT)
        // ---------- REF ----------
        `uvm_field_int(araddr_ref , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(arvalid_ref, UVM_DEFAULT)
        `uvm_field_int(arready_ref, UVM_DEFAULT)

        `uvm_field_int(rdata_ref  , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(rresp_ref  , UVM_DEFAULT)
        `uvm_field_int(rvalid_ref , UVM_DEFAULT)
        `uvm_field_int(rready_ref , UVM_DEFAULT)
        `uvm_field_int(rlast_ref  , UVM_DEFAULT)

        `uvm_field_int(awaddr_ref , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(awvalid_ref, UVM_DEFAULT)
        `uvm_field_int(awready_ref, UVM_DEFAULT)

        `uvm_field_int(wdata_ref  , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(wvalid_ref , UVM_DEFAULT)
        `uvm_field_int(wready_ref , UVM_DEFAULT)
        `uvm_field_int(wlast_ref  , UVM_DEFAULT)

        `uvm_field_int(bresp_ref  , UVM_DEFAULT)
        `uvm_field_int(bvalid_ref , UVM_DEFAULT)
        `uvm_field_int(bready_ref , UVM_DEFAULT)
    `uvm_object_utils_end

    // ------------------------------------------------------------------------
    // Constraint blocks
    // ------------------------------------------------------------------------

    // Reset mostly deasserted; occasionally assert
    constraint c_reset_bias {
        areset_n dist { `OFF_n := 95, `ON_n := 5 };
    }

    // Exactly one op at a time, with bias from macros
    constraint c_rw_xor {
        (start_read ^ start_write) == 1;
        start_write dist { 1 := `WRITE_PROB, 0 := `READ_PROB };
        start_read  == !start_write;
    }

    // Legal burst lengths: AXI enc is len = beats-1 (0..15 -> 1..16 beats)
    constraint c_len_ranges {
        arlen inside {[0:15]};
        awlen inside {[0:15]};
    }

    // Allowed burst types
    constraint c_burst_types {
        arburst inside { BURST_FIXED, BURST_INCR, BURST_WRAP };
        awburst inside { BURST_FIXED, BURST_INCR, BURST_WRAP };
    }

    // Prefer INCR bursts; sprinkle FIXED/WRAP
    constraint c_burst_bias {
        arburst dist { BURST_INCR := 80, BURST_FIXED := 10, BURST_WRAP := 10 };
        awburst dist { BURST_INCR := 80, BURST_FIXED := 10, BURST_WRAP := 10 };
    }

    // Default size = bus width (soft so tests can override)
    // DATA_WIDTH bytes per beat -> size = log2(DATA_WIDTH/8)
    constraint c_size_default {
        soft arsize == size_t'($clog2(STRB_WIDTH));
        soft awsize == size_t'($clog2(STRB_WIDTH));
    }

    // Size must be one of the standard encodings (1..128 bytes)
    constraint c_size_legal {
        arsize inside { SIZE_1_BYTE, SIZE_2_BYTE, SIZE_4_BYTE, SIZE_8_BYTE,
                        SIZE_16_BYTE, SIZE_32_BYTE, SIZE_64_BYTE, SIZE_128_BYTE };
        awsize inside { SIZE_1_BYTE, SIZE_2_BYTE, SIZE_4_BYTE, SIZE_8_BYTE,
                        SIZE_16_BYTE, SIZE_32_BYTE, SIZE_64_BYTE, SIZE_128_BYTE };
    }

    // Keep size not exceeding bus width by default
    constraint c_size_vs_bus {
        arsize <= size_t'($clog2(STRB_WIDTH));
        awsize <= size_t'($clog2(STRB_WIDTH));
    }

    // WRAP requires power-of-two beats: len == {0,1,3,7,15}
    constraint c_wrap_len {
        if (arburst == BURST_WRAP) arlen inside { 0, 1, 3, 7, 15 };
        if (awburst == BURST_WRAP) awlen inside { 0, 1, 3, 7, 15 };
    }

    // Address alignment: align to bytes/beat for the chosen size (soft for flexibility)
    // addr is the base; ar/aw channel addrs (non-rand) can be filled by the driver
    constraint c_addr_align {
        soft (addr % STRB_WIDTH) == 0;
    }

    // Data pattern bias (simple, uses your macros)
    constraint c_data_bias {
        data dist {
        `WDATA_ALL_ZERO := 5,
        `WDATA_ALL_ONE  := 5,
        `WDATA_ALT_1010 := 5,
        `WDATA_ALT_0101 := 5,
        [0 : (2**$bits(data_t))-1] := 80
        };
    }

    // Write strobes: for writes, prefer full mask; allow partials.
    // For reads (no use), keep all-zero to avoid accidental checking.
    constraint c_wstrb_basic {
        if (start_write) {
        wstrb dist {
            {STRB_WIDTH{1'b1}} := 70, // full write
            '0                 :=  1, // rare degenerate (allowed for negative tests)
            [0 : (2**$bits(strb_t))-1] := 29
        };
        } else {
        wstrb == '0;
        }
    }

    // Tie read/write size preferences together (soft equal by default)
    constraint c_size_match_soft {
        soft (arsize == awsize);
    }

    // Slightly prefer shorter bursts; still cover long ones
    constraint c_len_bias {
        arlen dist { 0 := 35, [1:3] := 40, [4:7] := 15, [8:15] := 10 };
        awlen dist { 0 := 35, [1:3] := 40, [4:7] := 15, [8:15] := 10 };
    }

    // Avoid wrap with maximum size by default (soft), to reduce boundary corner explosions
    constraint c_wrap_vs_size_soft {
        if (arburst == BURST_WRAP) soft (arsize <= size_t'($clog2(STRB_WIDTH)));
        if (awburst == BURST_WRAP) soft (awsize <= size_t'($clog2(STRB_WIDTH)));
    }

    // Keep addresses in a sane, positive range by default (soft)
    constraint c_addr_range_soft {
        soft addr inside {[addr_t'(0) : addr_t'(`MEM_DEPTH*STRB_WIDTH - STRB_WIDTH)]};
    }

    // Basic op-driven preferences:
    //  - Reads lean to INCR, writes lean to INCR as well (already biased), but let FIXED appear.
    constraint c_op_burst_hint_soft {
        if (start_read)  soft (arburst == BURST_INCR);
        if (start_write) soft (awburst == BURST_INCR);
    }

    // ------------------------------------------------------------------------
    // Utilities
    // ------------------------------------------------------------------------
    function void set_read(addr_t base);
        start_read  = 1;
        start_write = 0;
        addr = base;
    endfunction

    function void set_write(addr_t base, data_t d);
        start_read  = 0;
        start_write = 1;
        addr = base;
        data = d;
    endfunction

endclass : AXI_master_seq_item

`endif // AXI_MASTER_SEQ_ITEM_SVH