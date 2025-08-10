`ifndef AXI_MASTER_RESET_SEQUENCE_SVH
`define AXI_MASTER_RESET_SEQUENCE_SVH

    class AXI_master_reset_sequence extends uvm_sequence #(AXI_master_seq_item);

        `uvm_object_utils (AXI_master_reset_sequence)
        AXI_master_seq_item master_seq_item;

        // Default Constructor
        function new (string name = "AXI_master_reset_sequence");
            super.new(name);
        endfunction : new

        task body;
            master_seq_item = AXI_master_seq_item::type_id::create("master_seq_item");
            start_item(master_seq_item);
                // master_seq_item.SWRITE = `LOW;
            finish_item(master_seq_item);
        endtask : body
        
    endclass : AXI_master_reset_sequence

`endif // AXI_MASTER_RESET_SEQUENCE_SVH