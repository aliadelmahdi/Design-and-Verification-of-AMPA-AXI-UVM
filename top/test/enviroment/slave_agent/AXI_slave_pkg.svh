
`ifndef AXI_SLAVE_PKG_SVH
`define AXI_SLAVE_PKG_SVH

    import shared_pkg::*;

    `include "AXI_slave_seq_item.svh"
    `include "AXI_slave_sequences.svh"
    `include "AXI_slave_driver.svh"
    `include "AXI_slave_monitor.svh"
    `include "AXI_slave_sequencer.svh"
    `include "AXI_slave_agent.svh"

`endif // AXI_SLAVE_PKG_SVH