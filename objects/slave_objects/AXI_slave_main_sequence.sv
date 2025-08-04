`ifndef AXI_SLAVE_MAIN_SEQUENCE_SV
`define AXI_SLAVE_MAIN_SEQUENCE_SV

    class AXI_slave_main_sequence extends uvm_sequence #(AXI_slave_seq_item);

        `uvm_object_utils (AXI_slave_main_sequence);
        AXI_slave_seq_item slave_seq_item;

        // Default Constructor
        function new(string name = "AXI_slave_main_sequence");
            super.new(name);            
        endfunction : new
        
        task body;

            repeat(`TEST_ITER_MEDIUM) begin
                slave_seq_item = AXI_slave_seq_item::type_id::create("slave_seq_item");
                start_item(slave_seq_item);
                assert(slave_seq_item.randomize()) else $error("Randomization Failed");
                finish_item(slave_seq_item);
            end

        endtask : body
        
    endclass : AXI_slave_main_sequence

`endif // AXI_SLAVE_MAIN_SEQUENCE_SV