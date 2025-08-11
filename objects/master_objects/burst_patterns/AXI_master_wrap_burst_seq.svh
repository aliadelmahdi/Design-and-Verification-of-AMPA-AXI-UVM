// ============================================================================
// WRAP burst sequence
// ============================================================================
`ifndef AXI_MASTER_WRAP_BURST_SEQ_SVH
`define AXI_MASTER_WRAP_BURST_SEQ_SVH

// Generates wrapping-address bursts (boundary aligned).
class AXI_master_wrap_burst_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_wrap_burst_seq)

    function new(string name = "AXI_master_wrap_burst_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: constrain burst type = WRAP
            // assert(seq_item.randomize() with { burst == BURST_WRAP; is_len_wrap_aligned; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_wrap_burst_seq

`endif // AXI_MASTER_WRAP_BURST_SEQ_SVH