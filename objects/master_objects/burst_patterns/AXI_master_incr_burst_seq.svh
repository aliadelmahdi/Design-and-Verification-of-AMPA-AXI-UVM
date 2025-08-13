// ============================================================================
// INCR burst sequence
// ============================================================================
`ifndef AXI_MASTER_INCR_BURST_SEQ_SVH
`define AXI_MASTER_INCR_BURST_SEQ_SVH

// Generates incrementing-address bursts (ARBURST/AWBURST = INCR).
class AXI_master_incr_burst_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_incr_burst_seq)

    function new(string name = "AXI_master_incr_burst_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            assert(seq_item.randomize() with {
                awburst     == BURST_INCR;
                arburst     == BURST_INCR;
            }
            ) else begin
                        `uvm_error("RAND_FAIL",
                            $sformatf("[%0t] Randomization failed in %s: awburst=%0d arburst=%0d",
                                    $time, get_name(), seq_item.awburst, seq_item.arburst))
                    end
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_incr_burst_seq

`endif // AXI_MASTER_INCR_BURST_SEQ_SVH