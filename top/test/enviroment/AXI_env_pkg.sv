package AXI_env_pkg;

    // Import required packages
    import uvm_pkg::*;     // UVM base classes and macros
    import shared_pkg::*;  // Shared typedefs, parameters, and utilities

    // Environment configuration and components
    `include "AXI_config.svh"              // AXI configuration object
    `include "AXI_master_pkg.svh"          // AXI master agent package
    `include "AXI_slave_pkg.svh"           // AXI slave agent package
    `include "AXI_coverage_collector.svh"  // Functional coverage collector
    `include "AXI_scoreboard.svh"          // Scoreboard for results checking
    `include "AXI_env.svh"                 // Top-level AXI environment

endpackage : AXI_env_pkg