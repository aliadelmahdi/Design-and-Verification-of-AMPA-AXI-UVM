`ifndef AXI_SLAVE_SEQ_ITEM_SVH
`define AXI_SLAVE_SEQ_ITEM_SVH

// AXI Slave Sequence Item - defines a single slave transaction's data fields
class AXI_slave_seq_item extends uvm_sequence_item;

    // ---------------------------
    // Global Signals
    // ---------------------------
    logic areset_n;   // Active-low reset signal for the interface
    bit [2:0] s_fsm_state;

    // ---------------------------
    // Read Address Channel (AR)
    // ---------------------------
    addr_t  araddr;   // Read address from master
    logic   arvalid;  // Indicates that the read address and control signals are valid
    logic   arready;  // Indicates that the slave is ready to accept the read address
    len_t   arlen;    // Burst length: number of data transfers in the burst
    size_t  arsize;   // Burst size: number of bytes per data transfer
    burst_t arburst;  // Burst type: FIXED, INCR, or WRAP

    // ---------- REF ----------
    addr_t  araddr_ref;   // Read address from master
    logic   arvalid_ref;  // Indicates that the read address and control signals are valid
    logic   arready_ref;  // Indicates that the slave is ready to accept the read address
    len_t   arlen_ref;    // Burst length: number of data transfers in the burst
    size_t  arsize_ref;   // Burst size: number of bytes per data transfer
    burst_t arburst_ref;  // Burst type: FIXED, INCR, or WRAP

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
    addr_t  awaddr;   // Write address from master
    logic   awvalid;  // Indicates that the write address and control signals are valid
    logic   awready;  // Indicates that the slave is ready to accept the write address
    len_t   awlen;    // Burst length for write transactions
    size_t  awsize;   // Burst size for write transactions
    burst_t awburst;  // Burst type for write transactions

    // ---------- REF ----------
    addr_t  awaddr_ref;   // Write address from master
    logic   awvalid_ref;  // Indicates that the write address and control signals are valid
    logic   awready_ref;  // Indicates that the slave is ready to accept the write address
    len_t   awlen_ref;    // Burst length for write transactions
    size_t  awsize_ref;   // Burst size for write transactions
    burst_t awburst_ref;  // Burst type for write transactions

    // ---------------------------
    // Write Data Channel (W)
    // ---------------------------
    data_t  wdata;    // Write data from master to slave
    strb_t  wstrb;    // Write strobes: indicates which byte lanes are valid
    logic   wvalid;   // Indicates that the write data is valid
    logic   wready;   // Indicates that the slave is ready to accept the write data
    logic   wlast;    // Indicates the last transfer in a write burst

    // ---------- REF ----------
    data_t  wdata_ref;    // Write data from master to slave
    strb_t  wstrb_ref;    // Write strobes: indicates which byte lanes are valid
    logic   wvalid_ref;   // Indicates that the write data is valid
    logic   wready_ref;   // Indicates that the slave is ready to accept the write data
    logic   wlast_ref;    // Indicates the last transfer in a write burst

    // ---------------------------
    // Write Response Channel (B)
    // ---------------------------
    resp_t  bresp;    // Write response from slave
    logic   bvalid;   // Indicates that the write response is valid
    logic   bready;   // Indicates that the master is ready to accept the write response

    // ---------- REF ----------
    resp_t  bresp_ref;    // Write response from slave
    logic   bvalid_ref;   // Indicates that the write response is valid
    logic   bready_ref;   // Indicates that the master is ready to accept the write response

    // ------------------------------------------------------------------------
    // Factory registration
    // ------------------------------------------------------------------------
    `uvm_object_utils_begin(AXI_slave_seq_item)
        `uvm_field_int(areset_n   , UVM_DEFAULT)

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
        `uvm_field_int(arlen_ref  , UVM_DEFAULT)
        `uvm_field_int(arsize_ref , UVM_DEFAULT)
        `uvm_field_int(arburst_ref, UVM_DEFAULT)

        `uvm_field_int(rdata_ref  , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(rresp_ref  , UVM_DEFAULT)
        `uvm_field_int(rvalid_ref , UVM_DEFAULT)
        `uvm_field_int(rready_ref , UVM_DEFAULT)
        `uvm_field_int(rlast_ref  , UVM_DEFAULT)

        `uvm_field_int(awaddr_ref , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(awvalid_ref, UVM_DEFAULT)
        `uvm_field_int(awready_ref, UVM_DEFAULT)
        `uvm_field_int(awlen_ref  , UVM_DEFAULT)
        `uvm_field_int(awsize_ref , UVM_DEFAULT)
        `uvm_field_int(awburst_ref, UVM_DEFAULT)

        `uvm_field_int(wdata_ref  , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(wstrb_ref  , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(wvalid_ref , UVM_DEFAULT)
        `uvm_field_int(wready_ref , UVM_DEFAULT)
        `uvm_field_int(wlast_ref  , UVM_DEFAULT)

        `uvm_field_int(bresp_ref  , UVM_DEFAULT)
        `uvm_field_int(bvalid_ref , UVM_DEFAULT)
        `uvm_field_int(bready_ref , UVM_DEFAULT)
    `uvm_object_utils_end

    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------
    function new(string name = "AXI_slave_seq_item");
        super.new(name);
    endfunction : new

endclass : AXI_slave_seq_item

`endif // AXI_SLAVE_SEQ_ITEM_SVH