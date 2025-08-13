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
            assert(seq_item.randomize() with {
                awlen       == 1;
                start_write == 1;
                wstrb       == 4'b1111;
                awburst     == BURST_FIXED;
            }
            ) else begin
                        `uvm_error("RAND_FAIL",
                            $sformatf("[%0t] Randomization failed in %s: awlen=%0d start_write=%0b wstrb=%b awburst=%0d",
                                    $time, get_name(), seq_item.awlen, seq_item.start_write,
                                    seq_item.wstrb, seq_item.awburst))
                    end
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_single_write_seq

`endif // AXI_MASTER_SINGLE_WRITE_SEQ_SVH