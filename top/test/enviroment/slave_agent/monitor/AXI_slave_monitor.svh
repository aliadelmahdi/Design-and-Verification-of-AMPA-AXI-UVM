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

            // TODO: Assign observed AXI slave signal values to seq_item fields here
            // Example: slave_response_seq_item.rdata = axi_if.rdata;

            // Send transaction to subscribers
            slave_monitor_ap.write(slave_response_seq_item);

            // Log captured transaction
            `uvm_info("run_phase", slave_response_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_slave_monitor

`endif // AXI_SLAVE_MONITOR_SVH
