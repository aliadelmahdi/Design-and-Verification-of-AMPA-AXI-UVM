// ============================================================================
// Single READ (non-burst) sequence
// ============================================================================
`ifndef AXI_MASTER_SINGLE_READ_SEQ_SVH
`define AXI_MASTER_SINGLE_READ_SEQ_SVH

// Drives single-beat read transactions (simple smoke).
class AXI_master_single_read_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_single_read_seq)

    function new(string name = "AXI_master_single_read_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            assert(seq_item.randomize() with {
                arlen       == 1;
                start_read  == 1;
                arburst     == BURST_FIXED;
            }
            ) else begin
                        `uvm_error("RAND_FAIL",
                            $sformatf("[%0t] Randomization failed in %s: arlen=%0d start_read=%0b arburst=%0d",
                                    $time, get_name(), seq_item.arlen, seq_item.start_read,
                                    seq_item.arburst))
                    end
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_single_read_seq

`endif // AXI_MASTER_SINGLE_READ_SEQ_SVH