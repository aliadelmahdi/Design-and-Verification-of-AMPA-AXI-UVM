`ifndef AXI_SLAVE_MONITOR_SV
`define AXI_SLAVE_MONITOR_SV

    class AXI_slave_monitor extends uvm_monitor;

        `uvm_component_utils (AXI_slave_monitor)
        virtual AXI_if.slave_monitor axi_if;
        AXI_slave_seq_item slave_response_seq_item;
        uvm_analysis_port #(AXI_slave_seq_item) slave_monitor_ap;

        // Default Constructor
        function new(string name = "AXI_slave_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction : new

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            slave_monitor_ap = new ("slave_monitor_ap",this);
        endfunction : build_phase

        // Connect Phase
        function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
		endfunction : connect_phase

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                slave_response_seq_item = AXI_slave_seq_item::type_id::create("slave_response_seq_item");
                @(negedge axi_if.aclk);
                // slave_response_seq_item.PRESETn = axi_if.PRESETn;
                slave_monitor_ap.write(slave_response_seq_item);
                `uvm_info("run_phase", slave_response_seq_item.sprint(), UVM_HIGH)
            end

        endtask : run_phase
        
    endclass : AXI_slave_monitor

`endif // AXI_SLAVE_MONITOR_SV