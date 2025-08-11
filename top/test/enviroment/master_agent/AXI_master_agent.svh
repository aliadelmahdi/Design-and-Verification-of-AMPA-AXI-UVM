`ifndef AXI_MASTER_AGENT_SVH
`define AXI_MASTER_AGENT_SVH

// AXI Master Agent - encapsulates driver, sequencer, and monitor for the AXI master
class AXI_master_agent extends uvm_agent;

    `uvm_component_utils(AXI_master_agent)

    // Agent components
    AXI_master_sequencer axi_master_seqr;   // Sequencer - controls transaction flow
    AXI_master_driver    axi_master_drv;    // Driver - drives transactions to DUT
    AXI_master_monitor   axi_master_mon;    // Monitor - observes DUT outputs
    AXI_config           axi_master_cnfg;   // Configuration object
    uvm_analysis_port #(AXI_master_seq_item) axi_master_agent_ap; // Sends observed transactions to subscribers

    // Constructor
    function new(string name = "AXI_master_agent", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - create subcomponents and get config
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get configuration object from UVM config DB
        if(!uvm_config_db #(AXI_config)::get(this, "", "CFG", axi_master_cnfg)) 
            `uvm_fatal("build_phase", "Unable to get the master configuration object from the database")
        
        // Create driver, sequencer, and monitor
        axi_master_drv   = AXI_master_driver::type_id::create("axi_master_drv", this);
        axi_master_seqr  = AXI_master_sequencer::type_id::create("axi_master_seqr", this);
        axi_master_mon   = AXI_master_monitor::type_id::create("axi_master_mon", this);

        // Create analysis port
        axi_master_agent_ap = new("axi_master_agent_ap", this);
    endfunction : build_phase

    // Connect Phase - hook up components
    function void connect_phase(uvm_phase phase);
        // Connect virtual interface to driver and monitor
        axi_master_drv.axi_if = axi_master_cnfg.axi_if;
        axi_master_mon.axi_if = axi_master_cnfg.axi_if;

        // Connect sequencer to driver
        axi_master_drv.seq_item_port.connect(axi_master_seqr.seq_item_export);

        // Connect monitor's analysis port to agent's analysis port
        axi_master_mon.master_monitor_ap.connect(axi_master_agent_ap);
    endfunction : connect_phase

    // Run Phase - optional custom agent-level behavior
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
    endtask : run_phase
    
endclass : AXI_master_agent

`endif // AXI_MASTER_AGENT_SVH