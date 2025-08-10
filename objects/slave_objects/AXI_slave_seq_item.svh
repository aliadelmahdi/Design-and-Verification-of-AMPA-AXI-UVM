`ifndef AXI_SLAVE_SEQ_ITEM_SVH
`define AXI_SLAVE_SEQ_ITEM_SVH
    class AXI_slave_seq_item extends uvm_sequence_item;
      
        `uvm_object_utils_begin(AXI_slave_seq_item)
            // `uvm_field_int(PRESETn, UVM_DEFAULT)
        `uvm_object_utils_end
        function new(string name = "AXI_slave_seq_item");
            super.new(name);
        endfunction : new
        
    endclass : AXI_slave_seq_item

`endif // AXI_SLAVE_SEQ_ITEM_SVH