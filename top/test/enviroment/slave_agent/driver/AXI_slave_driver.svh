`ifndef AXI_SLAVE_DRIVER_SVH
`define AXI_SLAVE_DRIVER_SVH

// AXI Slave Driver - drives slave responses based on transactions from the sequencer
class AXI_slave_driver extends uvm_driver #(AXI_slave_seq_item);
    `uvm_component_utils(AXI_slave_driver)

    virtual AXI_if.slave_driver axi_if; // Virtual interface for driving AXI slave signals
    AXI_slave_seq_item stimulus_seq_item; // Sequence item containing slave transaction data

    // Constructor
    function new(string name = "AXI_slave_driver", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - initialization if needed
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    // Connect Phase - connect ports/exports if needed
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    // Run Phase - main loop for driving slave-side behavior
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            // Create new sequence item
            stimulus_seq_item = AXI_slave_seq_item::type_id::create("slave_stimulus_seq_item");

            // Get transaction from sequencer
            seq_item_port.get_next_item(stimulus_seq_item);

            // ---------------------------
            // Global control
            // ---------------------------
            axi_if.areset_n  = stimulus_seq_item.areset_n;

            // ---------------------------
            // DUT Slave Inputs (from Master)
            // ---------------------------
            axi_if.araddr    = stimulus_seq_item.araddr;
            axi_if.arvalid   = stimulus_seq_item.arvalid;
            axi_if.arlen     = stimulus_seq_item.arlen;
            axi_if.arsize    = stimulus_seq_item.arsize;
            axi_if.arburst   = stimulus_seq_item.arburst;

            axi_if.awaddr    = stimulus_seq_item.awaddr;
            axi_if.awvalid   = stimulus_seq_item.awvalid;
            axi_if.awlen     = stimulus_seq_item.awlen;
            axi_if.awsize    = stimulus_seq_item.awsize;
            axi_if.awburst   = stimulus_seq_item.awburst;

            axi_if.wdata     = stimulus_seq_item.wdata;
            axi_if.wstrb     = stimulus_seq_item.wstrb;
            axi_if.wvalid    = stimulus_seq_item.wvalid;
            axi_if.wlast     = stimulus_seq_item.wlast;

            axi_if.rready    = stimulus_seq_item.rready;
            axi_if.bready    = stimulus_seq_item.bready;

            // ---------------------------
            // REF Slave Inputs (from REF Master)
            // ---------------------------
            axi_if.araddr_ref    = stimulus_seq_item.araddr_ref;
            axi_if.arvalid_ref   = stimulus_seq_item.arvalid_ref;

            axi_if.awaddr_ref    = stimulus_seq_item.awaddr_ref;
            axi_if.awvalid_ref   = stimulus_seq_item.awvalid_ref;

            axi_if.wdata_ref     = stimulus_seq_item.wdata_ref;
            axi_if.wvalid_ref    = stimulus_seq_item.wvalid_ref;
            axi_if.wlast_ref     = stimulus_seq_item.wlast_ref;

            axi_if.rready_ref    = stimulus_seq_item.rready_ref;
            axi_if.bready_ref    = stimulus_seq_item.bready_ref;


            @(negedge axi_if.aclk) // Sync with clock

            // Indicate transaction is complete
            seq_item_port.item_done();

            // Log transaction details
            `uvm_info("run_phase", stimulus_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_slave_driver

`endif // AXI_SLAVE_DRIVER_SVH
