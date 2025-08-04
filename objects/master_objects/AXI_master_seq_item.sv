`ifndef AXI_MASTER_SEQ_ITEM_SV
`define AXI_MASTER_SEQ_ITEM_SV

    class AXI_master_seq_item extends uvm_sequence_item;

        // Default Constructor
        function new(string name = "AXI_master_seq_item");
            super.new(name);
        endfunction : new

        `uvm_object_utils_begin(AXI_master_seq_item)
            // `uvm_field_int(SWRITE, UVM_DEFAULT)
        `uvm_object_utils_end

    endclass : AXI_master_seq_item

`endif // AXI_MASTER_SEQ_ITEM_SV