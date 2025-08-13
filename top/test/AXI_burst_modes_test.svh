`ifndef AXI_BURST_MODES_TEST_SVH
`define AXI_BURST_MODES_TEST_SVH

// Test class for running various AXI burst mode sequences
class AXI_burst_modes_test extends AXI_test_base;
  `uvm_component_utils(AXI_burst_modes_test)

  // Sequence handles for different burst mode scenarios
  AXI_master_incr_burst_seq           AXI_master_incr_burst;
  AXI_master_fixed_burst_seq          AXI_master_fixed_burst;
  AXI_master_wrap_burst_seq           AXI_master_wrap_burst;
  AXI_master_max_len_burst_seq        AXI_master_max_len_burst;
  AXI_master_unaligned_access_seq     AXI_master_unaligned_access;
  AXI_master_boundary_cross_seq       AXI_master_boundary_cross;

  // Constructor
  function new(string name="AXI_burst_modes_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  // Build phase: create sequence objects
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    AXI_master_incr_burst       = AXI_master_incr_burst_seq::type_id::create("AXI_master_incr_burst");
    AXI_master_fixed_burst      = AXI_master_fixed_burst_seq::type_id::create("AXI_master_fixed_burst");
    AXI_master_wrap_burst       = AXI_master_wrap_burst_seq::type_id::create("AXI_master_wrap_burst");
    AXI_master_max_len_burst    = AXI_master_max_len_burst_seq::type_id::create("AXI_master_max_len_burst");
    AXI_master_unaligned_access = AXI_master_unaligned_access_seq::type_id::create("AXI_master_unaligned_access");
    AXI_master_boundary_cross   = AXI_master_boundary_cross_seq::type_id::create("AXI_master_boundary_cross");
  endfunction : build_phase

  // Main test body: create and run all burst sequences on master
  virtual task run_scenarios();
    // Execute each burst mode sequence on the master agent
    run_on_master(AXI_master_incr_burst);
    run_on_master(AXI_master_fixed_burst);
    run_on_master(AXI_master_wrap_burst);
    run_on_master(AXI_master_max_len_burst);
    run_on_master(AXI_master_unaligned_access);
    run_on_master(AXI_master_boundary_cross);
  endtask : run_scenarios
  
endclass : AXI_burst_modes_test

`endif // AXI_BURST_MODES_TEST_SVH
