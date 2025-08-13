`ifndef AXI_MASTER_DRIVER_SVH
`define AXI_MASTER_DRIVER_SVH

// AXI Master Driver - drives transactions from sequencer to the AXI interface
class AXI_master_driver extends uvm_driver #(AXI_master_seq_item);
    `uvm_component_utils(AXI_master_driver)

    virtual AXI_if.master_driver axi_if; // Virtual interface for driving AXI signals
    AXI_master_seq_item stimulus_seq_item; // Sequence item containing transaction data

    // Constructor
    function new(string name = "AXI_master_driver", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - initialize components/resources if needed
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    // Connect Phase - connect ports/exports
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase
    
    // Run Phase - main driver loop
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            // Create a fresh sequence item
            stimulus_seq_item = AXI_master_seq_item::type_id::create("master_stimulus_seq_item");

            // Get transaction from sequencer
            seq_item_port.get_next_item(stimulus_seq_item);

            // ---------------------------
            // Global control
            // ---------------------------
            axi_if.areset_n    = stimulus_seq_item.areset_n;
            axi_if.start_read  = stimulus_seq_item.start_read;
            axi_if.start_write = stimulus_seq_item.start_write;
            axi_if.addr        = stimulus_seq_item.addr;
            axi_if.data        = stimulus_seq_item.data;
            axi_if.arlen       = stimulus_seq_item.arlen;
            axi_if.arsize      = stimulus_seq_item.arsize;
            axi_if.arburst     = stimulus_seq_item.arburst;
            axi_if.awburst     = stimulus_seq_item.awburst;
            axi_if.awsize      = stimulus_seq_item.awsize;
            axi_if.awlen       = stimulus_seq_item.awlen;
            axi_if.wstrb       = stimulus_seq_item.wstrb;

            // ---------------------------
            // DUT Master Inputs
            // ---------------------------
            axi_if.arready     = stimulus_seq_item.arready;
            axi_if.rdata       = stimulus_seq_item.rdata;
            axi_if.rresp       = stimulus_seq_item.rresp;
            axi_if.rvalid      = stimulus_seq_item.rvalid;
            axi_if.rlast       = stimulus_seq_item.rlast;
            axi_if.awready     = stimulus_seq_item.awready;
            axi_if.wready      = stimulus_seq_item.wready;
            axi_if.bresp       = stimulus_seq_item.bresp;
            axi_if.bvalid      = stimulus_seq_item.bvalid;

            // ---------------------------
            // REF Master Inputs
            // ---------------------------
            axi_if.arready_ref = stimulus_seq_item.arready_ref;
            axi_if.rdata_ref   = stimulus_seq_item.rdata_ref;
            axi_if.rresp_ref   = stimulus_seq_item.rresp_ref;
            axi_if.rvalid_ref  = stimulus_seq_item.rvalid_ref;
            axi_if.rlast_ref   = stimulus_seq_item.rlast_ref;
            axi_if.awready_ref = stimulus_seq_item.awready_ref;
            axi_if.wready_ref  = stimulus_seq_item.wready_ref;
            axi_if.bresp_ref   = stimulus_seq_item.bresp_ref;
            axi_if.bvalid_ref  = stimulus_seq_item.bvalid_ref;

            @(negedge axi_if.aclk) // Wait for clock edge
            // Indicate to sequencer that driving is done
            seq_item_port.item_done();

            // Log transaction details
            `uvm_info("run_phase", stimulus_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_master_driver

`endif // AXI_MASTER_DRIVER_SVH
