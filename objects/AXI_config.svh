`ifndef AXI_CONFIG_SVH
`define AXI_CONFIG_SVH

// AXI Configuration Object - holds interface and activity mode for an agent
class AXI_config extends uvm_object;

    `uvm_object_utils(AXI_config)

    // Virtual interface to connect agent components to DUT signals
    virtual AXI_if axi_if;

    // Determines if the agent is active (drives + monitors) or passive (monitors only)
    uvm_active_passive_enum is_active;

    // Constructor
    function new(string name = "AXI_config");
        super.new(name);
    endfunction : new
    
endclass : AXI_config

`endif // AXI_CONFIG_SVH