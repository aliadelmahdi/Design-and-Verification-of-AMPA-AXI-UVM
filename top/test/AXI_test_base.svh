`ifndef AXI_TEST_BASE_SVH
`define AXI_TEST_BASE_SVH

class AXI_test_base extends uvm_test;
        `uvm_component_utils(AXI_test_base)

        AXI_env axi_env; // Enviroment handle to the AXI4

        // Configuration objects for master and slave configurations
        AXI_config axi_master_cnfg; // Master configuration
        AXI_config axi_slave_cnfg; // Slave configuration
        
        virtual AXI_if axi_if; // Virtual interface handle

        AXI_master_main_sequence axi_master_main_seq; // Master main test sequence
        AXI_slave_main_sequence axi_slave_main_seq; // Slave main test sequence
        AXI_master_reset_sequence axi_master_reset_seq; // Master reset test sequence

        // Default constructor
        function new(string name = "AXI_test_base", uvm_component parent);
            super.new(name,parent);
        endfunction : new

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase); // Call parent class's build_phase
            // Create instances from the UVM factory
            axi_env = AXI_env::type_id::create("env",this);

            axi_master_cnfg = AXI_config::type_id::create("AXI_master_config",this);
            axi_slave_cnfg  = AXI_config::type_id::create("AXI_slave_config",this);

            axi_master_main_seq  = AXI_master_main_sequence::type_id::create("master_main_seq",this);
            axi_slave_main_seq   = AXI_slave_main_sequence::type_id::create("slave_main_seq",this);
            axi_master_reset_seq = AXI_master_reset_sequence::type_id::create("reset_seq",this);

            // Retrieve the virtual interface for AXI master from the UVM configuration database
            if(!uvm_config_db #(virtual AXI_if)::get(this,"","axi_if",axi_master_cnfg.axi_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the master virtual interface of the AXI form the configuration database");
            // Retrieve the virtual interface for AXI slave from the UVM configuration database
            if(!uvm_config_db #(virtual AXI_if)::get(this,"","axi_if",axi_slave_cnfg.axi_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the slave virtual interface of the AXI form the configuration database");
        
            // Set the master as an active agent (drives transactions)
            axi_master_cnfg.is_active =UVM_ACTIVE;
            // Set the slave as a passive agent (only monitors transactions)
            axi_slave_cnfg.is_active =UVM_PASSIVE;

            // Store the AXI master and slave configuration objects in the UVM configuration database
            uvm_config_db # (AXI_config)::set(this , "*" , "CFG",axi_master_cnfg);
            uvm_config_db # (AXI_config)::set(this , "*" , "CFG",axi_slave_cnfg);
        endfunction : build_phase

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase); // Call parent class's run phase
            phase.raise_objection(this); // Raise an objection to prevent the test from ending
            // Reset sequence
            `uvm_info("run_phase","stimulus Generation started",UVM_LOW)
            axi_master_reset_seq.start(axi_env.axi_master_agent.axi_master_seqr);
            `uvm_info("run_phase","Reset Deasserted",UVM_LOW)
            // Main Sequence
            `uvm_info("run_phase", "Stimulus Generation Started",UVM_LOW)
            // axi_slave_main_seq.start(axi_env.axi_slave_agent.axi_slave_seqr);
            axi_master_main_seq.start(axi_env.axi_master_agent.axi_master_seqr);
            `uvm_info("run_phase", "Stimulus Generation Ended",UVM_LOW) 

            phase.drop_objection(this); // Drop the objection to allow the test to complete
        endtask : run_phase

endclass : AXI_test_base

`endif // AXI_TEST_BASE_SVH