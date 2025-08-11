`ifndef AXI_MASTER_SEQ_ITEM_SVH
`define AXI_MASTER_SEQ_ITEM_SVH

// AXI Master Sequence Item - defines a single master transaction's data fields
class AXI_master_seq_item extends uvm_sequence_item;

    // Constructor
    function new(string name = "AXI_master_seq_item");
        super.new(name);
    endfunction : new

    // Register fields with the UVM factory and enable automation
    `uvm_object_utils_begin(AXI_master_seq_item)
        // Example: `uvm_field_int(SWRITE, UVM_DEFAULT) // Write control bit
        // TODO: Add AXI transaction fields (addr, data, burst, etc.)
    `uvm_object_utils_end

endclass : AXI_master_seq_item

`endif // AXI_MASTER_SEQ_ITEM_SVH
