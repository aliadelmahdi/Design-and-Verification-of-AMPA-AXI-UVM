// verification/tests/AXI_test_pkg.sv
package AXI_test_pkg;
  import uvm_pkg::*;
  import AXI_env_pkg::*;
    import shared_pkg::*;  // Shared typedefs, parameters, and utilities

  `include "AXI_test_base.svh"
  `include "AXI_smoke_test.svh"
  `include "AXI_burst_modes_test.svh"
  `include "AXI_flow_control_test.svh"
  `include "AXI_robustness_test.svh"
endpackage