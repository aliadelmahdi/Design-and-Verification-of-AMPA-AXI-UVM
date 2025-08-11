// ============================================================================
// Unaligned access sequence
// ============================================================================
`ifndef AXI_MASTER_UNALIGNED_ACCESS_SEQ_SVH
`define AXI_MASTER_UNALIGNED_ACCESS_SEQ_SVH

// Issues transfers with addresses not aligned to size (if allowed in your model).
class AXI_master_unaligned_access_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_unaligned_access_seq)

    function new(string name = "AXI_master_unaligned_access_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            // TODO: addr % size != 0 (when permitted)
            // assert(seq_item.randomize() with { (addr & (size_bytes-1)) != 0; }) else ...
            assert(seq_item.randomize()) else $error("Master Randomization Failed");
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_unaligned_access_seq

`endif // AXI_MASTER_UNALIGNED_ACCESS_SEQ_SVH