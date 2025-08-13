`ifndef AXI_ROBUSTNESS_TEST_SVH
`define AXI_ROBUSTNESS_TEST_SVH

// Test class for validating AXI master robustness under error, reset, and stress scenarios
class AXI_robustness_test extends AXI_test_base;
  `uvm_component_utils(AXI_robustness_test)

  // Sequence handles for robustness testing
  AXI_master_error_probe_seq       AXI_master_error_probe;       // Inject protocol errors & observe handling
  AXI_master_reset_during_txn_seq  AXI_master_reset_during_txn;  // Assert reset in middle of transactions
  AXI_master_random_stress_seq     AXI_master_random_stress;     // High-load random traffic stress test

  // Constructor
  function new(string name="AXI_robustness_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  // Build phase: create sequence objects
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    AXI_master_error_probe       = AXI_master_error_probe_seq::type_id::create("AXI_master_error_probe");
    AXI_master_reset_during_txn  = AXI_master_reset_during_txn_seq::type_id::create("AXI_master_reset_during_txn");
    AXI_master_random_stress     = AXI_master_random_stress_seq::type_id::create("AXI_master_random_stress");
  endfunction : build_phase

  // Main test body: create and run all robustness scenarios on master
  virtual task run_scenarios();
    // Execute each robustness test sequence
    run_on_master(AXI_master_error_probe);
    run_on_master(AXI_master_reset_during_txn);
    run_on_master(AXI_master_random_stress);
  endtask : run_scenarios
  
endclass : AXI_robustness_test

`endif // AXI_ROBUSTNESS_TEST_SVH