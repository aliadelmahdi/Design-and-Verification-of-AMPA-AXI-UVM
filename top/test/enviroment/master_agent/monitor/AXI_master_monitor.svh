`ifndef AXI_MASTER_MONITOR_SVH
`define AXI_MASTER_MONITOR_SVH

    class AXI_master_monitor extends uvm_monitor;
        `uvm_component_utils (AXI_master_monitor)
        virtual AXI_if.master_monitor axi_if;
        AXI_master_seq_item master_response_seq_item;
        uvm_analysis_port #(AXI_master_seq_item) master_monitor_ap;

        // Default Constructor
        function new(string name = "AXI_master_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction : new

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            master_monitor_ap = new ("master_monitor_ap",this);
        endfunction : build_phase

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction : connect_phase

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                master_response_seq_item = AXI_master_seq_item::type_id::create("master_response_seq_item");
                @(negedge axi_if.aclk);
                // master_response_seq_item.PRESETn = axi_if.PRESETn;
                master_monitor_ap.write(master_response_seq_item);
                `uvm_info("run_phase", master_response_seq_item.sprint(), UVM_HIGH)
            end

        endtask : run_phase
        
    endclass : AXI_master_monitor

`endif // AXI_MASTER_MONITOR_SVH