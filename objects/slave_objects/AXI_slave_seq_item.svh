`ifndef AXI_SLAVE_SEQ_ITEM_SVH
`define AXI_SLAVE_SEQ_ITEM_SVH

// AXI Slave Sequence Item - defines a single slave transaction's data fields
class AXI_slave_seq_item extends uvm_sequence_item;

    // ---------------------------
    // Global Signals
    // ---------------------------
    logic areset_n;   // Active-low reset signal for the interface

    // ---------------------------
    // Read Address Channel (AR)
    // ---------------------------
    addr_t  araddr;   // Read address from master
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
    addr_t  awaddr;   // Write address from master
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
    resp_t  bresp;    // Write response from slave
    logic   bvalid;   // Indicates that the write response is valid
    logic   bready;   // Indicates that the master is ready to accept the write response

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
    `uvm_object_utils_end

    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------
    function new(string name = "AXI_slave_seq_item");
        super.new(name);
    endfunction : new

endclass : AXI_slave_seq_item

`endif // AXI_SLAVE_SEQ_ITEM_SVH