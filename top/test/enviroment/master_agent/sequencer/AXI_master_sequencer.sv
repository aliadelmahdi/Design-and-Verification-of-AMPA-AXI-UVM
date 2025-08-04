`ifndef AXI_MASTER_SEQUENCER_SV
`define AXI_MASTER_SEQUENCER_SV

    class AXI_master_sequencer extends uvm_sequencer #(AXI_master_seq_item);

        `uvm_component_utils(AXI_master_sequencer);
      
        // Default Constructor
        function new(string name = "AXI_master_sequence", uvm_component parent);
            super.new(name,parent);
        endfunction : new

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
        endfunction : build_phase

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction : connect_phase

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask : run_phase

    endclass : AXI_master_sequencer

`endif // AXI_MASTER_SEQUENCER_SV