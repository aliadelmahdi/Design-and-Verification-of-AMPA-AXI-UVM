`ifndef AXI_SLAVE_DRIVER_SV
`define AXI_SLAVE_DRIVER_SV

    class AXI_slave_driver extends uvm_driver #(AXI_slave_seq_item);
        `uvm_component_utils(AXI_slave_driver)
        virtual AXI_if.slave_driver axi_if;
        AXI_slave_seq_item stimulus_seq_item;

        // Default Constructor
        function new(string name = "AXI_slave_driver", uvm_component parent);
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
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stimulus_seq_item = AXI_slave_seq_item::type_id::create("slave_stimulus_seq_item");
                seq_item_port.get_next_item(stimulus_seq_item);
                // axi_if.PRESETn = stimulus_seq_item.PRESETn;
                @(negedge axi_if.aclk)
                seq_item_port.item_done();
                `uvm_info("run_phase",stimulus_seq_item.sprint(),UVM_HIGH)
            end
        endtask : run_phase
        
    endclass : AXI_slave_driver

`endif // AXI_SLAVE_DRIVER_SV