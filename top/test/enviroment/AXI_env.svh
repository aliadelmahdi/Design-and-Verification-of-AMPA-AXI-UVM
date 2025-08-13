`ifndef AXI_ENV_SVH
`define AXI_ENV_SVH

// AXI Environment - top-level UVM env containing master/slave agents, scoreboard, and coverage
class AXI_env extends uvm_env;
    `uvm_component_utils(AXI_env)

    // Environment components
    AXI_slave_agent  axi_slave_agent;  // Slave agent (active or passive)
    AXI_master_agent axi_master_agent; // Master agent (active)
    AXI_scoreboard   axi_sb;           // Scoreboard for comparing master & slave transactions
    AXI_coverage     axi_cov;          // Functional coverage collector
    
    // Constructor
    function new (string name = "AXI_env", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - create all environment components
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_slave_agent  = AXI_slave_agent::type_id::create("axi_slave_agent", this);
        axi_master_agent = AXI_master_agent::type_id::create("axi_master_agent", this);
        axi_sb           = AXI_scoreboard::type_id::create("axi_sb", this);
        axi_cov          = AXI_coverage::type_id::create("axi_cov", this);
    endfunction : build_phase

    // Connect Phase - hook up analysis ports from agents to scoreboard & coverage
    function void connect_phase(uvm_phase phase);
        // Slave connections
        axi_slave_agent.axi_slave_agent_ap.connect(axi_sb.slave_sb_export);
        axi_slave_agent.axi_slave_agent_ap.connect(axi_cov.slave_cov_export);
        // Master connections
        axi_master_agent.axi_master_agent_ap.connect(axi_sb.master_sb_export);
        axi_master_agent.axi_master_agent_ap.connect(axi_cov.master_cov_export);
    endfunction : connect_phase

    // Run Phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask : run_phase
    
endclass : AXI_env

`endif // AXI_ENV_SVH
