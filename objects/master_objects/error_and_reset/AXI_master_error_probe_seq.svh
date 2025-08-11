// ============================================================================
// Error probe sequence
// ============================================================================
`ifndef AXI_MASTER_ERROR_PROBE_SEQ_SVH
`define AXI_MASTER_ERROR_PROBE_SEQ_SVH

// Accesses unmapped/illegal regions to elicit DECERR/SLVERR (if modeled).
class AXI_master_error_probe_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_error_probe_seq)

    function new(string name = "AXI_master_error_probe_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: target illegal addresses / attributes
            // assert(seq_item.randomize() with { target_error_response == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_error_probe_seq

`endif // AXI_MASTER_ERROR_PROBE_SEQ_SVH