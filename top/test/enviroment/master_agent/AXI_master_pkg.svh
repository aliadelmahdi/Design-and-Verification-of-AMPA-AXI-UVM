`ifndef AXI_MASTER_PKG_SVH
`define AXI_MASTER_PKG_SVH

    // AXI Master Package - includes all master agent components in one place

    `include "AXI_master_seq_item.svh"     // Sequence item definition (transaction format)
    `include "AXI_master_sequences.svh"    // Predefined sequences for master
    `include "AXI_master_driver.svh"       // Driver - sends transactions to DUT
    `include "AXI_master_monitor.svh"      // Monitor - observes DUT outputs
    `include "AXI_master_sequencer.svh"    // Sequencer - controls sequence execution
    `include "AXI_master_agent.svh"        // Agent - encapsulates driver, sequencer, and monitor

`endif // AXI_MASTER_PKG_SVH