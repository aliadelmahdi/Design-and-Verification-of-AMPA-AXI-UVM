`ifndef AXI_SLAVE_MAIN_SEQUENCE_SVH
`define AXI_SLAVE_MAIN_SEQUENCE_SVH

// AXI Slave Main Sequence - generates randomized slave response transactions
class AXI_slave_main_sequence extends uvm_sequence #(AXI_slave_seq_item);

    `uvm_object_utils(AXI_slave_main_sequence)

    AXI_slave_seq_item slave_seq_item; // Sequence item for each slave transaction

    // Constructor
    function new(string name = "AXI_slave_main_sequence");
        super.new(name);            
    endfunction : new
    
    // Main sequence body
    task body;

        // Generate a medium number of randomized transactions
        repeat(`TEST_ITER_MEDIUM) begin
            // Create a new sequence item
            slave_seq_item = AXI_slave_seq_item::type_id::create("slave_seq_item");

            // Start the transaction
            start_item(slave_seq_item);

            // Randomize fields (constraints should be defined in seq_item class)
            assert(slave_seq_item.randomize()) 
                else $error("Randomization Failed");

            // Complete the transaction
            finish_item(slave_seq_item);
        end

    endtask : body
    
endclass : AXI_slave_main_sequence

`endif // AXI_SLAVE_MAIN_SEQUENCE_SVH
