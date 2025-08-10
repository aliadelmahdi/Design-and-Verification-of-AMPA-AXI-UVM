`ifndef AXI_CONFIG_SVH
`define AXI_CONFIG_SVH

    class AXI_config extends uvm_object;

        `uvm_object_utils (AXI_config)
        virtual AXI_if axi_if;
        uvm_active_passive_enum is_active;

        // Default Constructor
        function new(string name = "AXI_config");
            super.new(name);
        endfunction : new
        
    endclass : AXI_config

`endif // AXI_CONFIG_SVH