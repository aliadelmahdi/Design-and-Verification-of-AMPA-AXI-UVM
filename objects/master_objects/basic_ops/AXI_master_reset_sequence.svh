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
        
        // ---------------------------
        // Global control
        // ---------------------------
        master_seq_item.areset_n    = `ON_n;
        master_seq_item.start_read  = `LOW;
        master_seq_item.start_write = `LOW;
        master_seq_item.addr        = `LOW;
        master_seq_item.data        = `LOW;

        // ---------------------------
        // DUT Master Inputs
        // ---------------------------
        master_seq_item.arready     = `LOW;
        master_seq_item.rdata       = `LOW;
        master_seq_item.rresp       = `LOW;
        master_seq_item.rvalid      = `LOW;
        master_seq_item.rlast       = `LOW;
        master_seq_item.awready     = `LOW;
        master_seq_item.wready      = `LOW;
        master_seq_item.bresp       = `LOW;
        master_seq_item.bvalid      = `LOW;

        // ---------------------------
        // REF Master Inputs
        // ---------------------------
        master_seq_item.arready_ref = `LOW;
        master_seq_item.rdata_ref   = `LOW;
        master_seq_item.rresp_ref   = `LOW;
        master_seq_item.rvalid_ref  = `LOW;
        master_seq_item.rlast_ref   = `LOW;
        master_seq_item.awready_ref = `LOW;
        master_seq_item.wready_ref  = `LOW;
        master_seq_item.bresp_ref   = `LOW;
        master_seq_item.bvalid_ref  = `LOW;


        finish_item(master_seq_item);
    endtask : body
    
endclass : AXI_master_reset_sequence

`endif // AXI_MASTER_RESET_SEQUENCE_SVH
