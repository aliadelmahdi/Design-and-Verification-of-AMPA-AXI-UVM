// verification/tests/axi_test_base.svh
`ifndef AXI_TEST_BASE_SVH
`define AXI_TEST_BASE_SVH

// Base test class for all AXI tests.
// Provides environment setup, config initialization, and helper tasks for running sequences.
class AXI_test_base extends uvm_test;
  `uvm_component_utils(AXI_test_base)

  // Testbench components
  AXI_env    axi_env;                  // AXI environment (master + slave agents)
  AXI_config axi_master_cnfg, axi_slave_cnfg; // Master & slave configuration objects
  AXI_master_reset_sequence AXI_master_reset; // Default reset sequence

  // Virtual interface handle for AXI signals
  virtual AXI_if axi_if; 

  // Hook for derived tests to implement their own scenarios
  virtual task run_scenarios(); endtask : run_scenarios

  // Helper to run a sequence on the master sequencer
  virtual task run_on_master(uvm_sequence_base seq);
    if (seq == null) begin
      `uvm_error("RUN_ON_MASTER", "Sequence handle is NULL. Cannot start sequence.")
      return;
    end

    `uvm_info("RUN_ON_MASTER", $sformatf(">>> Starting sequence: %0s", seq.get_name()), UVM_LOW)

    // Start sequence on master agent's sequencer
    seq.start(axi_env.axi_master_agent.axi_master_seqr);

    `uvm_info("RUN_ON_MASTER", $sformatf("<<< Finished sequence: %0s", seq.get_name()), UVM_LOW)
  endtask : run_on_master

  // Constructor
  function new(string name="AXI_test_base", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  // Build phase: create environment, configs, and reset sequence
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create environment
    axi_env = AXI_env::type_id::create("env", this);

    // Create master and slave configs
    axi_master_cnfg = AXI_config::type_id::create("AXI_master_config", this);
    axi_slave_cnfg  = AXI_config::type_id::create("AXI_slave_config", this);

    // Get master virtual interface from config DB
    if(!uvm_config_db #(virtual AXI_if)::get(this, "", "axi_if", axi_master_cnfg.axi_if))
      `uvm_fatal("build_phase", "Unable to get master virtual interface from config DB");

    // Get slave virtual interface from config DB
    if(!uvm_config_db #(virtual AXI_if)::get(this, "", "axi_if", axi_slave_cnfg.axi_if))
      `uvm_fatal("build_phase", "Unable to get slave virtual interface from config DB");

    // Set agent activity modes
    axi_master_cnfg.is_active = UVM_ACTIVE;  // Master drives transactions
    axi_slave_cnfg.is_active  = UVM_PASSIVE; // Slave only monitors

    // Store configs in UVM config DB
    uvm_config_db #(AXI_config)::set(this, "*", "CFG", axi_master_cnfg);
    uvm_config_db #(AXI_config)::set(this, "*", "CFG", axi_slave_cnfg);

    // Create default master reset sequence
    AXI_master_reset = AXI_master_reset_sequence::type_id::create("AXI_master_reset");
    repeat(2) `display_separator // Print separator lines
    factory.print();
    repeat(2) `display_separator // Print separator lines
  endfunction : build_phase

  // Run phase: performs reset and then executes test scenarios
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Always start with a master reset
    run_on_master(AXI_master_reset);

    // Derived test implements stimulus here
    run_scenarios();

    phase.drop_objection(this);
  endtask : run_phase
endclass : AXI_test_base

`endif // AXI_TEST_BASE_SVH