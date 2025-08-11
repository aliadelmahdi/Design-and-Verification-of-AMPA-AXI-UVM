// ============================================================================
// Single WRITE (non-burst) sequence
// ============================================================================
`ifndef AXI_MASTER_SINGLE_WRITE_SEQ_SVH
`define AXI_MASTER_SINGLE_WRITE_SEQ_SVH

// Drives single-beat write transactions (simple smoke).
class AXI_master_single_write_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_single_write_seq)

    function new(string name = "AXI_master_single_write_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: constrain as write, single-beat
            // assert(seq_item.randomize() with { is_write == 1; len == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_single_write_seq

`endif // AXI_MASTER_SINGLE_WRITE_SEQ_SVH