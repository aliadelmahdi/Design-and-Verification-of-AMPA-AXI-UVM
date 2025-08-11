`ifndef AXI_SLAVE_SEQ_ITEM_SVH
`define AXI_SLAVE_SEQ_ITEM_SVH

// AXI Slave Sequence Item - defines a single slave transaction's data fields
class AXI_slave_seq_item extends uvm_sequence_item;
    
    // Register class and its fields with the UVM factory
    `uvm_object_utils_begin(AXI_slave_seq_item)
        // Example: `uvm_field_int(PRESETn, UVM_DEFAULT) // Reset control signal
        // TODO: Add AXI slave transaction fields (rdata, bresp, etc.)
    `uvm_object_utils_end

    // Constructor
    function new(string name = "AXI_slave_seq_item");
        super.new(name);
    endfunction : new
    
endclass : AXI_slave_seq_item

`endif // AXI_SLAVE_SEQ_ITEM_SVH
