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

            // TODO: Assign AXI signal values to master_response_seq_item fields here
            // Example: master_response_seq_item.awaddr = axi_if.awaddr;

            // Send the captured transaction to subscribers
            master_monitor_ap.write(master_response_seq_item);

            // Log captured transaction
            `uvm_info("run_phase", master_response_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_master_monitor

`endif // AXI_MASTER_MONITOR_SVH