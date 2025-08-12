`ifndef AXI_SMOKE_TEST_SVH
`define AXI_SMOKE_TEST_SVH

// Simple "smoke test" to quickly verify basic AXI master read/write functionality
class AXI_smoke_test extends AXI_test_base;
  `uvm_component_utils(AXI_smoke_test)

  // Basic sequence handles
  AXI_master_main_sequence      AXI_master_main;         // Main default AXI sequence
  AXI_master_single_read_seq    AXI_master_single_read;  // Single read transaction
  AXI_master_single_write_seq   AXI_master_single_write; // Single write transaction

  // Constructor
  function new(string name="AXI_smoke_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new

  // Build phase: create sequence objects
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    AXI_master_main         = AXI_master_main_sequence::type_id::create("AXI_master_main");
    AXI_master_single_read  = AXI_master_single_read_seq::type_id::create("AXI_master_single_read");
    AXI_master_single_write = AXI_master_single_write_seq::type_id::create("AXI_master_single_write");
  endfunction : build_phase

  // Main test body: run basic sanity sequences
  virtual task run_scenarios();
    run_on_master(AXI_master_main);
    run_on_master(AXI_master_single_read);
    run_on_master(AXI_master_single_write);
  endtask : run_scenarios
endclass : AXI_smoke_test

`endif // AXI_SMOKE_TEST_SVH