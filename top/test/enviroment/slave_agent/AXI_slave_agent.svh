`ifndef AXI_SLAVE_AGENT_SVH
`define AXI_SLAVE_AGENT_SVH

// AXI Slave Agent - encapsulates driver, sequencer, and monitor for the AXI slave
// Can operate in ACTIVE mode (drives + monitors) or PASSIVE mode (monitors only)
class AXI_slave_agent extends uvm_agent;

    `uvm_component_utils(AXI_slave_agent)

    // Agent subcomponents
    AXI_slave_sequencer axi_slave_seqr;   // Sequencer - controls transaction flow to driver
    AXI_slave_driver    axi_slave_drv;    // Driver - drives responses to DUT
    AXI_slave_monitor   axi_slave_mon;    // Monitor - observes DUT requests
    AXI_config          axi_slave_cnfg;   // Configuration object
    uvm_analysis_port #(AXI_slave_seq_item) axi_slave_agent_ap; // Sends observed transactions to subscribers
    uvm_active_passive_enum is_active;    // Agent mode (UVM_ACTIVE or UVM_PASSIVE)

    // Constructor
    function new(string name = "AXI_slave_agent", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - create subcomponents depending on active/passive mode
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Get configuration from UVM config DB
        if(!uvm_config_db #(AXI_config)::get(this, "", "CFG", axi_slave_cnfg)) 
            `uvm_fatal("build_phase", "Unable to get the slave configuration object from the database")

        // Set active/passive mode
        is_active = axi_slave_cnfg.is_active;

        // Create driver + sequencer if ACTIVE
        if (is_active == UVM_ACTIVE) begin
            axi_slave_drv  = AXI_slave_driver::type_id::create("axi_slave_drv", this);
            axi_slave_seqr = AXI_slave_sequencer::type_id::create("axi_slave_seqr", this);
        end

        // Always create monitor
        axi_slave_mon = AXI_slave_monitor::type_id::create("axi_slave_mon", this);

        // Create agent-level analysis port
        axi_slave_agent_ap = new("axi_slave_agent_ap", this);
    endfunction : build_phase

    // Connect Phase - hook up components
    function void connect_phase(uvm_phase phase);
        if (is_active == UVM_ACTIVE) begin
            // Connect sequencer to driver
            axi_slave_drv.seq_item_port.connect(axi_slave_seqr.seq_item_export);
            // Connect interface to driver
            axi_slave_drv.axi_if = axi_slave_cnfg.axi_if;
        end
        // Connect monitor's analysis port to agent's analysis port
        axi_slave_mon.slave_monitor_ap.connect(axi_slave_agent_ap);
        // Connect interface to monitor
        axi_slave_mon.axi_if = axi_slave_cnfg.axi_if;
    endfunction : connect_phase

    // Run Phase - optional agent-level behavior
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
    endtask : run_phase

endclass : AXI_slave_agent

`endif // AXI_SLAVE_AGENT_SVH
