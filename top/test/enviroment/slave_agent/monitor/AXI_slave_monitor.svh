`ifndef AXI_SLAVE_MONITOR_SVH
`define AXI_SLAVE_MONITOR_SVH

// AXI Slave Monitor - observes slave-side AXI signals and forwards transactions
class AXI_slave_monitor extends uvm_monitor;

    `uvm_component_utils (AXI_slave_monitor)

    virtual AXI_if.slave_monitor axi_if; // Virtual interface for monitoring AXI slave signals
    AXI_slave_seq_item slave_response_seq_item; // Sequence item to hold observed transaction
    uvm_analysis_port #(AXI_slave_seq_item) slave_monitor_ap; // Sends observed transactions to subscribers

    // Constructor
    function new(string name = "AXI_slave_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - create analysis port
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        slave_monitor_ap = new("slave_monitor_ap", this);
    endfunction : build_phase

    // Connect Phase - connect ports/exports if needed
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    // Run Phase - continuously sample slave signals
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        forever begin
            // Create a new transaction object
            slave_response_seq_item = AXI_slave_seq_item::type_id::create("slave_response_seq_item");

            // Wait for a clock edge to sample signals
            @(negedge axi_if.aclk);

            // ---------------------------
            // Global control
            // ---------------------------
            slave_response_seq_item.areset_n     = axi_if.areset_n;
            slave_response_seq_item.s_fsm_state  = axi_if.s_fsm_state;

            // ---------------------------
            // DUT Read Address Channel (AR)
            // ---------------------------
            slave_response_seq_item.araddr    = axi_if.araddr;
            slave_response_seq_item.arvalid   = axi_if.arvalid;
            slave_response_seq_item.arlen     = axi_if.arlen;
            slave_response_seq_item.arsize    = axi_if.arsize;
            slave_response_seq_item.arburst   = axi_if.arburst;
            slave_response_seq_item.arready   = axi_if.arready;

            // ---------------------------
            // DUT Read Data Channel (R)
            // ---------------------------
            slave_response_seq_item.rdata     = axi_if.rdata;
            slave_response_seq_item.rresp     = axi_if.rresp;
            slave_response_seq_item.rvalid    = axi_if.rvalid;
            slave_response_seq_item.rready    = axi_if.rready;
            slave_response_seq_item.rlast     = axi_if.rlast;

            // ---------------------------
            // DUT Write Address Channel (AW)
            // ---------------------------
            slave_response_seq_item.awaddr    = axi_if.awaddr;
            slave_response_seq_item.awvalid   = axi_if.awvalid;
            slave_response_seq_item.awlen     = axi_if.awlen;
            slave_response_seq_item.awsize    = axi_if.awsize;
            slave_response_seq_item.awburst   = axi_if.awburst;
            slave_response_seq_item.awready   = axi_if.awready;

            // ---------------------------
            // DUT Write Data Channel (W)
            // ---------------------------
            slave_response_seq_item.wdata     = axi_if.wdata;
            slave_response_seq_item.wstrb     = axi_if.wstrb;
            slave_response_seq_item.wvalid    = axi_if.wvalid;
            slave_response_seq_item.wready    = axi_if.wready;
            slave_response_seq_item.wlast     = axi_if.wlast;

            // ---------------------------
            // DUT Write Response Channel (B)
            // ---------------------------
            slave_response_seq_item.bresp     = axi_if.bresp;
            slave_response_seq_item.bvalid    = axi_if.bvalid;
            slave_response_seq_item.bready    = axi_if.bready;

            // ---------------------------
            // REF Read Address Channel (AR)
            // ---------------------------
            slave_response_seq_item.araddr_ref  = axi_if.araddr_ref;
            slave_response_seq_item.arvalid_ref = axi_if.arvalid_ref;
            slave_response_seq_item.arready_ref = axi_if.arready_ref;

            // ---------------------------
            // REF Read Data Channel (R)
            // ---------------------------
            slave_response_seq_item.rdata_ref   = axi_if.rdata_ref;
            slave_response_seq_item.rresp_ref   = axi_if.rresp_ref;
            slave_response_seq_item.rvalid_ref  = axi_if.rvalid_ref;
            slave_response_seq_item.rready_ref  = axi_if.rready_ref;
            slave_response_seq_item.rlast_ref   = axi_if.rlast_ref;

            // ---------------------------
            // REF Write Address Channel (AW)
            // ---------------------------
            slave_response_seq_item.awaddr_ref  = axi_if.awaddr_ref;
            slave_response_seq_item.awvalid_ref = axi_if.awvalid_ref;
            slave_response_seq_item.awready_ref = axi_if.awready_ref;

            // ---------------------------
            // REF Write Data Channel (W)
            // ---------------------------
            slave_response_seq_item.wdata_ref   = axi_if.wdata_ref;
            slave_response_seq_item.wvalid_ref  = axi_if.wvalid_ref;
            slave_response_seq_item.wready_ref  = axi_if.wready_ref;
            slave_response_seq_item.wlast_ref   = axi_if.wlast_ref;

            // ---------------------------
            // REF Write Response Channel (B)
            // ---------------------------
            slave_response_seq_item.bresp_ref   = axi_if.bresp_ref;
            slave_response_seq_item.bvalid_ref  = axi_if.bvalid_ref;
            slave_response_seq_item.bready_ref  = axi_if.bready_ref;


            // Send transaction to subscribers
            slave_monitor_ap.write(slave_response_seq_item);

            // Log captured transaction
            `uvm_info("run_phase", slave_response_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_slave_monitor

`endif // AXI_SLAVE_MONITOR_SVH
