`ifndef AXI_MASTER_MONITOR_SVH
`define AXI_MASTER_MONITOR_SVH

// AXI Master Monitor - observes AXI master signals and forwards transactions via analysis port
class AXI_master_monitor extends uvm_monitor;
    `uvm_component_utils (AXI_master_monitor)

    virtual AXI_if.master_monitor axi_if; // Virtual interface for monitoring AXI signals
    AXI_master_seq_item master_response_seq_item; // Sequence item for captured transaction
    uvm_analysis_port #(AXI_master_seq_item) master_monitor_ap; // Analysis port for sending data to subscribers

    // Constructor
    function new(string name = "AXI_master_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - create analysis port
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        master_monitor_ap = new("master_monitor_ap", this);
    endfunction : build_phase

    // Connect Phase - for linking ports/exports
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    // Run Phase - continuously sample AXI master signals
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        forever begin
            // Create new sequence item for each captured transaction
            master_response_seq_item = AXI_master_seq_item::type_id::create("master_response_seq_item");

            // Wait for a clock edge
            @(negedge axi_if.aclk);

            // ---------------------------
            // Global control
            // ---------------------------
            master_response_seq_item.areset_n           = axi_if.areset_n;
            master_response_seq_item.start_read         = axi_if.start_read;
            master_response_seq_item.start_write        = axi_if.start_write;
            master_response_seq_item.addr               = axi_if.addr;
            master_response_seq_item.data               = axi_if.data;
            master_response_seq_item.m_fsm_state        = axi_if.m_fsm_state;

            // ---------------------------
            // DUT Read Address Channel (AR)
            // ---------------------------
            master_response_seq_item.araddr      = axi_if.araddr;
            master_response_seq_item.arvalid     = axi_if.arvalid;
            master_response_seq_item.arlen       = axi_if.arlen;
            master_response_seq_item.arsize      = axi_if.arsize;
            master_response_seq_item.arburst     = axi_if.arburst;
            master_response_seq_item.arready     = axi_if.arready;

            // ---------------------------
            // DUT Read Data Channel (R)
            // ---------------------------
            master_response_seq_item.rdata       = axi_if.rdata;
            master_response_seq_item.rresp       = axi_if.rresp;
            master_response_seq_item.rvalid      = axi_if.rvalid;
            master_response_seq_item.rready      = axi_if.rready;
            master_response_seq_item.rlast       = axi_if.rlast;

            // ---------------------------
            // DUT Write Address Channel (AW)
            // ---------------------------
            master_response_seq_item.awaddr      = axi_if.awaddr;
            master_response_seq_item.awvalid     = axi_if.awvalid;
            master_response_seq_item.awlen       = axi_if.awlen;
            master_response_seq_item.awsize      = axi_if.awsize;
            master_response_seq_item.awburst     = axi_if.awburst;
            master_response_seq_item.awready     = axi_if.awready;

            // ---------------------------
            // DUT Write Data Channel (W)
            // ---------------------------
            master_response_seq_item.wdata       = axi_if.wdata;
            master_response_seq_item.wstrb       = axi_if.wstrb;
            master_response_seq_item.wvalid      = axi_if.wvalid;
            master_response_seq_item.wready      = axi_if.wready;
            master_response_seq_item.wlast       = axi_if.wlast;

            // ---------------------------
            // DUT Write Response Channel (B)
            // ---------------------------
            master_response_seq_item.bresp       = axi_if.bresp;
            master_response_seq_item.bvalid      = axi_if.bvalid;
            master_response_seq_item.bready      = axi_if.bready;

            // ---------------------------
            // REF Read Address Channel (AR)
            // ---------------------------
            master_response_seq_item.araddr_ref  = axi_if.araddr_ref;
            master_response_seq_item.arvalid_ref = axi_if.arvalid_ref;
            master_response_seq_item.arready_ref = axi_if.arready_ref;

            // ---------------------------
            // REF Read Data Channel (R)
            // ---------------------------
            master_response_seq_item.rdata_ref   = axi_if.rdata_ref;
            master_response_seq_item.rresp_ref   = axi_if.rresp_ref;
            master_response_seq_item.rvalid_ref  = axi_if.rvalid_ref;
            master_response_seq_item.rready_ref  = axi_if.rready_ref;
            master_response_seq_item.rlast_ref   = axi_if.rlast_ref;

            // ---------------------------
            // REF Write Address Channel (AW)
            // ---------------------------
            master_response_seq_item.awaddr_ref  = axi_if.awaddr_ref;
            master_response_seq_item.awvalid_ref = axi_if.awvalid_ref;
            master_response_seq_item.awready_ref = axi_if.awready_ref;

            // ---------------------------
            // REF Write Data Channel (W)
            // ---------------------------
            master_response_seq_item.wdata_ref   = axi_if.wdata_ref;
            master_response_seq_item.wvalid_ref  = axi_if.wvalid_ref;
            master_response_seq_item.wready_ref  = axi_if.wready_ref;
            master_response_seq_item.wlast_ref   = axi_if.wlast_ref;

            // ---------------------------
            // REF Write Response Channel (B)
            // ---------------------------
            master_response_seq_item.bresp_ref   = axi_if.bresp_ref;
            master_response_seq_item.bvalid_ref  = axi_if.bvalid_ref;
            master_response_seq_item.bready_ref  = axi_if.bready_ref;


            // Send the captured transaction to subscribers
            master_monitor_ap.write(master_response_seq_item);

            // Log captured transaction
            `uvm_info("run_phase", master_response_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_master_monitor

`endif // AXI_MASTER_MONITOR_SVH