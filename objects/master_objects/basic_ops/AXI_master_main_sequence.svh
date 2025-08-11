`ifndef AXI_MASTER_MAIN_SEQUENCE_SVH
`define AXI_MASTER_MAIN_SEQUENCE_SVH

// AXI Master Main Sequence - generates randomized AXI master transactions
class AXI_master_main_sequence extends uvm_sequence #(AXI_master_seq_item);

    `uvm_object_utils(AXI_master_main_sequence)

    AXI_master_seq_item seq_item; // Sequence item for each transaction

    // Constructor
    function new(string name = "AXI_master_main_sequence");
        super.new(name);            
    endfunction : new
    
    // Configure the sequence item
    function void configure_seq_item();
        seq_item = AXI_master_seq_item::type_id::create("seq_item");
    endfunction : configure_seq_item

    // Main sequence body
    virtual task body;
    endtask : body
    
endclass : AXI_master_main_sequence

`endif // AXI_MASTER_MAIN_SEQUENCE_SVH
