`ifndef AXI_MASTER_MAIN_SEQUENCE_SVH
`define AXI_MASTER_MAIN_SEQUENCE_SVH

    class AXI_master_main_sequence extends uvm_sequence #(AXI_master_seq_item);

        `uvm_object_utils (AXI_master_main_sequence);
        AXI_master_seq_item seq_item;

        // Default Constructor
        function new(string name = "AXI_master_main_sequence");
            super.new(name);            
        endfunction : new
        
        task body;

            repeat(`TEST_ITER_SMALL) begin
                seq_item = AXI_master_seq_item::type_id::create("seq_item");
                start_item(seq_item);
                assert(seq_item.randomize()) else $error("Master Randomization Failed");
                finish_item(seq_item);
            end

        endtask : body
        
    endclass : AXI_master_main_sequence

`endif // AXI_MASTER_MAIN_SEQUENCE_SVH