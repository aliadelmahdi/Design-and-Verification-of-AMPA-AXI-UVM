// ============================================================================
// Reset during transaction sequence
// ============================================================================
`ifndef AXI_MASTER_RESET_DURING_TXN_SEQ_SVH
`define AXI_MASTER_RESET_DURING_TXN_SEQ_SVH

// Starts bursts then requests a reset mid-flight (driver/env must support).
class AXI_master_reset_during_txn_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_reset_during_txn_seq)

    function new(string name = "AXI_master_reset_during_txn_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            // Phase 1: start a burst
            configure_seq_item();
            start_item(seq_item);
            // TODO: mark for mid-burst reset trigger
            // assert(seq_item.randomize() with { trigger_mid_reset == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);

            // Phase 2: optional post-reset access
            configure_seq_item();
            start_item(seq_item);
            // TODO: verify system recovers after reset
            // assert(seq_item.randomize() with { post_reset_access == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_reset_during_txn_seq

`endif // AXI_MASTER_RESET_DURING_TXN_SEQ_SVH