import uvm_pkg::*;
import AXI_env_pkg::*;
import AXI_test_pkg::*;
import shared_pkg::*; // For enums and parameters
`timescale `TIME_UNIT / `TIME_PRECISION

module tb_top;
    bit aclk;
    // Clock Generation
    initial begin
        aclk = `LOW;
        forever #(`CLK_PERIOD/2) aclk = ~ aclk;
    end
   
    AXI_env env_instance; // Instantiate the AXI4 enviroment
    AXI_test_base test; // Instantiate the AXI4 test

    // Instantiate the interface
    AXI_if axi_if (aclk);
    AXI_master_gld master_gld (axi_if);
    AXI_slave_gld slave_gld (axi_if);


    initial begin
      uvm_top.set_report_verbosity_level(UVM_MEDIUM); // Set verbosity level
      uvm_top.finish_on_completion = `DISABLE_FINISH; // Prevent UVM from calling $finish
      uvm_config_db#(virtual AXI_if)::set(null, "*", "axi_if", axi_if); // Set AXI interface globally
      run_test("AXI_test_base"); // Start the UVM test
      `uvm_info("SEED", $sformatf("Current seed: %0d", $get_initial_random_seed()), UVM_LOW)
      repeat(3) `display_separator
      $stop; // Stop simulation after test execution
    end
endmodule : tb_top