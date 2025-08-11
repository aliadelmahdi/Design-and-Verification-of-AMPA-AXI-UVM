// ============================================================================
// Random stress sequence
// ============================================================================
`ifndef AXI_MASTER_RANDOM_STRESS_SEQ_SVH
`define AXI_MASTER_RANDOM_STRESS_SEQ_SVH

// Broad randomized traffic to shake out corner cases.
class AXI_master_random_stress_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_random_stress_seq)

    function new(string name = "AXI_master_random_stress_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_MEDIUM) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: optionally bias toward interesting cases via weights
            // assert(seq_item.randomize() with { soft is_write dist {0:=1,1:=1}; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_random_stress_seq

`endif // AXI_MASTER_RANDOM_STRESS_SEQ_SVH