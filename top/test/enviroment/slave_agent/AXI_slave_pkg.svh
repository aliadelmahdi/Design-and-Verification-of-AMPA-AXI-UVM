`ifndef AXI_SLAVE_PKG_SVH
`define AXI_SLAVE_PKG_SVH

// AXI Slave Package - groups all slave-side UVM components for easy import
import shared_pkg::*; // Import shared typedefs, parameters, and utilities

`include "AXI_slave_seq_item.svh"     // Sequence item definition (slave transaction format)
`include "AXI_slave_sequences.svh"    // Predefined sequences for slave behavior
`include "AXI_slave_driver.svh"       // Driver - drives responses to DUT
`include "AXI_slave_monitor.svh"      // Monitor - observes DUT requests
`include "AXI_slave_sequencer.svh"    // Sequencer - controls slave sequences
`include "AXI_slave_agent.svh"        // Agent - encapsulates driver, sequencer, and monitor

`endif // AXI_SLAVE_PKG_SVH
