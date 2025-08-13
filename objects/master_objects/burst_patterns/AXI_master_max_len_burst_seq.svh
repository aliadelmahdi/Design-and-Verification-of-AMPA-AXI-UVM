// ============================================================================
// Max-length burst sequence
// ============================================================================
`ifndef AXI_MASTER_MAX_LEN_BURST_SEQ_SVH
`define AXI_MASTER_MAX_LEN_BURST_SEQ_SVH

// Stresses longest legal burst length.
class AXI_master_max_len_burst_seq extends AXI_master_main_sequence;

    `uvm_object_utils(AXI_master_max_len_burst_seq)

    function new(string name = "AXI_master_max_len_burst_seq");
        super.new(name);
    endfunction : new

    task body;
        repeat(`TEST_ITER_SMALL) begin
            configure_seq_item();
            start_item(seq_item);
            assert(seq_item.randomize() with {
               awlen == 15;
               arlen == 15;
            }
            )  else begin
                        `uvm_error("RAND_FAIL",
                            $sformatf("[%0t] Randomization failed in %s: awlen=%0d arlen=%0d",
                                    $time, get_name(), seq_item.awlen, seq_item.arlen))
                    end
            finish_item(seq_item);
        end
    endtask : body

endclass : AXI_master_max_len_burst_seq

`endif // AXI_MASTER_MAX_LEN_BURST_SEQ_SVH