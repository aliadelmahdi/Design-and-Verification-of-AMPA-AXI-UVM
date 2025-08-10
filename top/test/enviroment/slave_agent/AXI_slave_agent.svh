`ifndef AXI_SLAVE_AGENT_SVH
`define AXI_SLAVE_AGENT_SVH

    class AXI_slave_agent extends uvm_agent;

        `uvm_component_utils(AXI_slave_agent)
        AXI_slave_sequencer axi_slave_seqr;
        AXI_slave_driver axi_slave_drv;
        AXI_slave_monitor axi_slave_mon;
        AXI_config axi_slave_cnfg;
        uvm_analysis_port #(AXI_slave_seq_item) axi_slave_agent_ap;
        uvm_active_passive_enum is_active;

        // Default Constructor
        function new(string name = "AXI_slave_agent", uvm_component parent);
            super.new(name,parent);
        endfunction : new

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if(!uvm_config_db #(AXI_config)::get(this,"","CFG",axi_slave_cnfg)) 
                `uvm_fatal ("build_phase","Unable to get the slave configuration object from the database")
            is_active = axi_slave_cnfg.is_active;
            if(is_active==UVM_ACTIVE)begin
                axi_slave_drv = AXI_slave_driver::type_id::create("axi_slave_drv",this);
                axi_slave_seqr = AXI_slave_sequencer::type_id::create("axi_slave_seqr",this);
            end
            axi_slave_mon = AXI_slave_monitor::type_id::create("axi_slave_mon",this);
            axi_slave_agent_ap = new("axi_slave_agent_ap",this);
        endfunction : build_phase

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            if(is_active==UVM_ACTIVE)begin
              axi_slave_drv.seq_item_port.connect(axi_slave_seqr.seq_item_export);
              axi_slave_drv.axi_if = axi_slave_cnfg.axi_if;
            end
            axi_slave_mon.slave_monitor_ap.connect(axi_slave_agent_ap);
            axi_slave_mon.axi_if = axi_slave_cnfg.axi_if;
        endfunction : connect_phase

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
        endtask : run_phase

    endclass : AXI_slave_agent

`endif // AXI_SLAVE_AGENT_SVH