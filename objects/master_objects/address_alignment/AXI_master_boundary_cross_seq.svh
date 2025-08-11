// ============================================================================
// Boundary-crossing sequence
// ============================================================================
`ifndef AXI_MASTER_BOUNDARY_CROSS_SEQ_SVH
`define AXI_MASTER_BOUNDARY_CROSS_SEQ_SVH

// Builds bursts that cross address boundaries (e.g., 4KB), if your system models responses.
class AXI_master_boundary_cross_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_boundary_cross_seq)

    function new(string name = "AXI_master_boundary_cross_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: drive addr/len/size to hit boundary crossing
            // assert(seq_item.randomize() with { crosses_4k_boundary == 1; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_boundary_cross_seq

`endif // AXI_MASTER_BOUNDARY_CROSS_SEQ_SVH