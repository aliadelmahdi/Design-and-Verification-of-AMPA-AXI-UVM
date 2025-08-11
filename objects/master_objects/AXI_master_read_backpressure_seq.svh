// ============================================================================
// Read backpressure sequence
// ============================================================================
`ifndef AXI_MASTER_READ_BACKPRESSURE_SEQ_SVH
`define AXI_MASTER_READ_BACKPRESSURE_SEQ_SVH

// Applies backpressure on R channel (toggle rready pattern).
class AXI_master_read_backpressure_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_read_backpressure_seq)

    function new(string name = "AXI_master_read_backpressure_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_MEDIUM) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: set rready_gaps / handshake policy fields in seq_item
            // assert(seq_item.randomize() with { rready_gap_en == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_read_backpressure_seq

`endif // AXI_MASTER_READ_BACKPRESSURE_SEQ_SVH