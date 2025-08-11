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

            // TODO: Drive AXI signals here based on stimulus_seq_item fields
            @(negedge axi_if.aclk) // Wait for clock edge

            // Indicate to sequencer that driving is done
            seq_item_port.item_done();

            // Log transaction details
            `uvm_info("run_phase", stimulus_seq_item.sprint(), UVM_HIGH)
        end
    endtask : run_phase
    
endclass : AXI_master_driver

`endif // AXI_MASTER_DRIVER_SVH
