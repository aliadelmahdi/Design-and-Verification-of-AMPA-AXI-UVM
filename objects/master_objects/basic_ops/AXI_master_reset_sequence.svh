`ifndef AXI_MASTER_RESET_SEQUENCE_SVH
`define AXI_MASTER_RESET_SEQUENCE_SVH

// AXI Master Reset Sequence - sends a reset transaction or idle state to DUT
class AXI_master_reset_sequence extends uvm_sequence #(AXI_master_seq_item);

    `uvm_object_utils(AXI_master_reset_sequence)

    AXI_master_seq_item master_seq_item; // Transaction item for reset

    // Constructor
    function new(string name = "AXI_master_reset_sequence");
        super.new(name);
    endfunction : new

    // Main sequence body
    task body;
        // Create a new sequence item
        master_seq_item = AXI_master_seq_item::type_id::create("master_seq_item");

        // Start and finish the item (can include reset-specific field assignments)
        start_item(master_seq_item);
            // Example: master_seq_item.SWRITE = `LOW; // Set control fields for reset
        finish_item(master_seq_item);
    endtask : body
    
endclass : AXI_master_reset_sequence

`endif // AXI_MASTER_RESET_SEQUENCE_SVH
