import uvm_pkg::*;        // UVM base classes and utilities
import AXI_env_pkg::*;    // AXI environment components
import AXI_test_pkg::*;   // AXI test definitions
import shared_pkg::*;     // Shared enums, typedefs, parameters

`timescale `TIME_UNIT / `TIME_PRECISION

module tb_top;

    bit aclk; // AXI clock signal

    // ==========================
    // Tests
    // ==========================
    
    string testname, test_n;

    string test_list[$] = {
        "AXI_smoke_test",
        "AXI_burst_modes_test",
        "AXI_flow_control_test",
        "AXI_robustness_test"
    };

    // ------------------------
    // Clock Generation
    // ------------------------
    initial begin
        aclk = `LOW;
        forever #(`CLK_PERIOD/2) aclk = ~aclk; // Toggle clock every half period
    end
   
    // Environment and Test handles
    AXI_env       env_instance; // AXI environment instance
    AXI_test_base test;         // Base AXI test instance

    // ------------------------
    // DUT & Interface Instances
    // ------------------------
    AXI_if         axi_if (aclk);           // AXI interface
    AXI_master_gld master_gld (axi_if);     // Golden model for AXI master
    AXI_slave_gld  slave_gld (axi_if);      // Golden model for AXI slave
    AXI_master     master ();               // DUT for AXI master
    AXI_slave      slave ();                // DUT for AXI slave

    // ------------------------
    // Simulation Control
    // ------------------------
    initial begin
        testname = "AXI_burst_modes_test";

        uvm_top.set_report_verbosity_level(UVM_MEDIUM);    // Set default UVM verbosity
        uvm_top.finish_on_completion = `DISABLE_FINISH;    // Prevent automatic $finish
        uvm_config_db#(virtual AXI_if)::set(null, "*", "axi_if", axi_if); // Set interface globally
        
        if (!$value$plusargs("UVM_TESTNAME=%s", testname)) begin
            test_n = testname;
            `uvm_info("TB_TOP", "No +UVM_TESTNAME specified. Defaulting to testname.", UVM_LOW)
        end
        run_test(test_n);

        `uvm_info("SEED", $sformatf("Current seed: %0d", $get_initial_random_seed()), UVM_LOW)
        repeat(3) `display_separator // Print separator lines
        $stop; // Stop simulation after test completion
    end
endmodule : tb_top