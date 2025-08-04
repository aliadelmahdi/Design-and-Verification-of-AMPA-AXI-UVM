
`ifndef AXI_SLAVE_PKG_SV
`define AXI_SLAVE_PKG_SV

    import shared_pkg::*;

    `include "AXI_slave_seq_item.sv"
    `include "AXI_slave_sequences.sv"
    `include "AXI_slave_driver.sv"
    `include "AXI_slave_monitor.sv"
    `include "AXI_slave_sequencer.sv"
    `include "AXI_slave_agent.sv"

`endif // AXI_SLAVE_PKG_SV