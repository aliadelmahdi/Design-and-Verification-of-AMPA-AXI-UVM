`ifndef AXI_FLOW_CONTROL_TEST_SVH
`define AXI_FLOW_CONTROL_TEST_SVH

// Test class for verifying AXI flow control scenarios
class AXI_flow_control_test extends AXI_test_base;
  `uvm_component_utils(AXI_flow_control_test)

  // Sequence handles for different flow control behaviors
  AXI_master_partial_write_strobe_seq  AXI_master_partial_write_strobe;   // Partial byte-lane writes
  AXI_master_interleaved_rw_seq        AXI_master_interleaved_rw;         // Interleaved read/write transactions
  AXI_master_read_backpressure_seq     AXI_master_read_backpressure;      // Apply backpressure on read data channel
  AXI_master_write_backpressure_seq    AXI_master_write_backpressure;     // Apply backpressure on write response/data
  AXI_master_read_after_write_seq      AXI_master_read_after_write;       // Read immediately after a write
  AXI_master_write_after_read_seq      AXI_master_write_after_read;       // Write immediately after a read

  // Constructor
  function new(string name="AXI_flow_control_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Main test body: create and run all flow control sequences on master
  virtual task run_scenarios();
    // Create sequence objects
    AXI_master_partial_write_strobe = AXI_master_partial_write_strobe_seq::type_id::create("AXI_master_partial_write_strobe");
    AXI_master_interleaved_rw       = AXI_master_interleaved_rw_seq::type_id::create("AXI_master_interleaved_rw");
    AXI_master_read_backpressure    = AXI_master_read_backpressure_seq::type_id::create("AXI_master_read_backpressure");
    AXI_master_write_backpressure   = AXI_master_write_backpressure_seq::type_id::create("AXI_master_write_backpressure");
    AXI_master_read_after_write     = AXI_master_read_after_write_seq::type_id::create("AXI_master_read_after_write");
    AXI_master_write_after_read     = AXI_master_write_after_read_seq::type_id::create("AXI_master_write_after_read");

    // Execute sequences to validate master behavior under various flow control conditions
    run_on_master(AXI_master_partial_write_strobe);
    run_on_master(AXI_master_interleaved_rw);
    run_on_master(AXI_master_read_backpressure);
    run_on_master(AXI_master_write_backpressure);
    run_on_master(AXI_master_read_after_write);
    run_on_master(AXI_master_write_after_read);
  endtask
endclass

`endif // AXI_FLOW_CONTROL_TEST_SVH