// ============================================================================
// Partial write strobe sequence
// ============================================================================
`ifndef AXI_MASTER_PARTIAL_WRITE_STROBE_SEQ_SVH
`define AXI_MASTER_PARTIAL_WRITE_STROBE_SEQ_SVH

// Uses selective byte enables (WSTRB) to write partial data.
class AXI_master_partial_write_strobe_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_partial_write_strobe_seq)

    function new(string name = "AXI_master_partial_write_strobe_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: constrain wstrb to non-all-ones, non-zero patterns
            // assert(seq_item.randomize() with { wstrb != '0; wstrb != '1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_partial_write_strobe_seq

`endif // AXI_MASTER_PARTIAL_WRITE_STROBE_SEQ_SVH