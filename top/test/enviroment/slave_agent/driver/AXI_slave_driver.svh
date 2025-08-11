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

            // TODO: Drive slave response signals based on stimulus_seq_item
            // Example: axi_if.rdata = stimulus_seq_item.rdata;

            @(negedge axi_if.aclk) // Sync with clock

            // Indicate transaction is complete
            seq_item_port.item_done();

            // Log transaction details
            `uvm_info("run_phase", stimulus_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_slave_driver

`endif // AXI_SLAVE_DRIVER_SVH
