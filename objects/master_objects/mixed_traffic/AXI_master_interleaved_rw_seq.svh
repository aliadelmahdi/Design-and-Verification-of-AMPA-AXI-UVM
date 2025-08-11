// ============================================================================
// Interleaved Read/Write sequence
// ============================================================================
`ifndef AXI_MASTER_INTERLEAVED_RW_SEQ_SVH
`define AXI_MASTER_INTERLEAVED_RW_SEQ_SVH

// Mixes reads and writes to the same/nearby addresses to stress ordering.
class AXI_master_interleaved_rw_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_interleaved_rw_seq)

    function new(string name = "AXI_master_interleaved_rw_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_MEDIUM) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: alternate is_read/is_write and overlap address windows
            // assert(seq_item.randomize() with { interleave_rw == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_interleaved_rw_seq

`endif // AXI_MASTER_INTERLEAVED_RW_SEQ_SVH