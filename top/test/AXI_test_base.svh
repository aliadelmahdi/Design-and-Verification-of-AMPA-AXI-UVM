`ifndef AXI_TEST_BASE_SVH
`define AXI_TEST_BASE_SVH

// Base test for AXI environment - sets up configuration, sequences, and runs them
class AXI_test_base extends uvm_test;
    `uvm_component_utils(AXI_test_base)

    AXI_env axi_env; // Environment containing master/slave agents, scoreboard, and coverage

    // Configuration objects for master and slave
    AXI_config axi_master_cnfg; 
    AXI_config axi_slave_cnfg; 
    
    // Virtual interface handle for AXI signals
    virtual AXI_if axi_if; 

    // -------------------------
    // Test sequences (handles)
    // -------------------------
    AXI_master_main_sequence              axi_master_main_seq;            // Main traffic generation
    AXI_slave_main_sequence               axi_slave_main_seq;             // (Optional) slave-side sequence
    AXI_master_reset_sequence             axi_master_reset_seq;           // Reset handling sequence

    // Directed & specialized master sequences
    AXI_master_single_read_seq            axi_master_single_read_seq_h;
    AXI_master_single_write_seq           axi_master_single_write_seq_h;
    AXI_master_incr_burst_seq             axi_master_incr_burst_seq_h;
    AXI_master_fixed_burst_seq            axi_master_fixed_burst_seq_h;
    AXI_master_wrap_burst_seq             axi_master_wrap_burst_seq_h;
    AXI_master_max_len_burst_seq          axi_master_max_len_burst_seq_h;
    AXI_master_unaligned_access_seq       axi_master_unaligned_access_seq_h;
    AXI_master_boundary_cross_seq         axi_master_boundary_cross_seq_h;
    AXI_master_partial_write_strobe_seq   axi_master_partial_write_strobe_seq_h;
    AXI_master_interleaved_rw_seq         axi_master_interleaved_rw_seq_h;
    AXI_master_read_backpressure_seq      axi_master_read_backpressure_seq_h;
    AXI_master_write_backpressure_seq     axi_master_write_backpressure_seq_h;
    AXI_master_read_after_write_seq       axi_master_read_after_write_seq_h;
    AXI_master_write_after_read_seq       axi_master_write_after_read_seq_h;
    AXI_master_error_probe_seq            axi_master_error_probe_seq_h;
    AXI_master_reset_during_txn_seq       axi_master_reset_during_txn_seq_h;
    AXI_master_random_stress_seq          axi_master_random_stress_seq_h;

    // Constructor
    function new(string name = "AXI_test_base", uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // Build Phase - create env, configs, and sequences, and configure agents
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create environment
        axi_env = AXI_env::type_id::create("env", this);

        // Create master and slave configs
        axi_master_cnfg = AXI_config::type_id::create("AXI_master_config", this);
        axi_slave_cnfg  = AXI_config::type_id::create("AXI_slave_config", this);

        // Create base sequences
        axi_master_main_seq  = AXI_master_main_sequence::type_id::create("master_main_seq", this);
        axi_slave_main_seq   = AXI_slave_main_sequence::type_id::create("slave_main_seq", this);
        axi_master_reset_seq = AXI_master_reset_sequence::type_id::create("reset_seq", this);

        // Create directed & specialized master sequences
        axi_master_single_read_seq_h            = AXI_master_single_read_seq           ::type_id::create("single_read_seq",            this);
        axi_master_single_write_seq_h           = AXI_master_single_write_seq          ::type_id::create("single_write_seq",           this);
        axi_master_incr_burst_seq_h             = AXI_master_incr_burst_seq            ::type_id::create("incr_burst_seq",             this);
        axi_master_fixed_burst_seq_h            = AXI_master_fixed_burst_seq           ::type_id::create("fixed_burst_seq",            this);
        axi_master_wrap_burst_seq_h             = AXI_master_wrap_burst_seq            ::type_id::create("wrap_burst_seq",             this);
        axi_master_max_len_burst_seq_h          = AXI_master_max_len_burst_seq         ::type_id::create("max_len_burst_seq",          this);
        axi_master_unaligned_access_seq_h       = AXI_master_unaligned_access_seq      ::type_id::create("unaligned_access_seq",       this);
        axi_master_boundary_cross_seq_h         = AXI_master_boundary_cross_seq        ::type_id::create("boundary_cross_seq",         this);
        axi_master_partial_write_strobe_seq_h   = AXI_master_partial_write_strobe_seq  ::type_id::create("partial_write_strobe_seq",   this);
        axi_master_interleaved_rw_seq_h         = AXI_master_interleaved_rw_seq        ::type_id::create("interleaved_rw_seq",         this);
        axi_master_read_backpressure_seq_h      = AXI_master_read_backpressure_seq     ::type_id::create("read_backpressure_seq",      this);
        axi_master_write_backpressure_seq_h     = AXI_master_write_backpressure_seq    ::type_id::create("write_backpressure_seq",     this);
        axi_master_read_after_write_seq_h       = AXI_master_read_after_write_seq      ::type_id::create("read_after_write_seq",       this);
        axi_master_write_after_read_seq_h       = AXI_master_write_after_read_seq      ::type_id::create("write_after_read_seq",       this);
        axi_master_error_probe_seq_h            = AXI_master_error_probe_seq           ::type_id::create("error_probe_seq",            this);
        axi_master_reset_during_txn_seq_h       = AXI_master_reset_during_txn_seq      ::type_id::create("reset_during_txn_seq",       this);
        axi_master_random_stress_seq_h          = AXI_master_random_stress_seq         ::type_id::create("random_stress_seq",          this);

        // Get virtual interface for master config from UVM config DB
        if(!uvm_config_db #(virtual AXI_if)::get(this, "", "axi_if", axi_master_cnfg.axi_if))
            `uvm_fatal("build_phase", "Unable to get master virtual interface from config DB");

        // Get virtual interface for slave config from UVM config DB
        if(!uvm_config_db #(virtual AXI_if)::get(this, "", "axi_if", axi_slave_cnfg.axi_if))
            `uvm_fatal("build_phase", "Unable to get slave virtual interface from config DB");

        // Set agent activity modes
        axi_master_cnfg.is_active = UVM_ACTIVE;  // Master drives transactions
        axi_slave_cnfg.is_active  = UVM_PASSIVE; // Slave only monitors

        // Store configs in UVM config DB
        uvm_config_db #(AXI_config)::set(this, "*", "CFG", axi_master_cnfg);
        uvm_config_db #(AXI_config)::set(this, "*", "CFG", axi_slave_cnfg);
    endfunction : build_phase

    // Run Phase - execute reset then main stimulus (others are ready to run)
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

        `uvm_info("run_phase", "Stimulus Generation Started", UVM_LOW)

        // Reset sequence
        `uvm_info("run_phase", "Starting: AXI Master Reset Sequence", UVM_LOW)
        axi_master_reset_seq.start(axi_env.axi_master_agent.axi_master_seqr);
        `uvm_info("run_phase", "Reset Deasserted", UVM_LOW)

        // Main sequence (master only — enable others as needed below)
        `uvm_info("run_phase", "Starting: AXI Master Main Sequence", UVM_LOW)
        axi_master_main_seq.start(axi_env.axi_master_agent.axi_master_seqr);

        // -------------------------------------------------------------\\

        // `uvm_info("run_phase", "Starting: AXI Master Single Read Sequence", UVM_LOW)
        // axi_master_single_read_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Single Write Sequence", UVM_LOW)
        // axi_master_single_write_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Incrementing Burst Sequence", UVM_LOW)
        // axi_master_incr_burst_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Fixed Burst Sequence", UVM_LOW)
        // axi_master_fixed_burst_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Wrapping Burst Sequence", UVM_LOW)
        // axi_master_wrap_burst_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Max Length Burst Sequence", UVM_LOW)
        // axi_master_max_len_burst_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Unaligned Access Sequence", UVM_LOW)
        // axi_master_unaligned_access_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Boundary Crossing Sequence", UVM_LOW)
        // axi_master_boundary_cross_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Partial Write Strobe Sequence", UVM_LOW)
        // axi_master_partial_write_strobe_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Interleaved Read/Write Sequence", UVM_LOW)
        // axi_master_interleaved_rw_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Read Backpressure Sequence", UVM_LOW)
        // axi_master_read_backpressure_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Write Backpressure Sequence", UVM_LOW)
        // axi_master_write_backpressure_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Read-After-Write Sequence", UVM_LOW)
        // axi_master_read_after_write_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Write-After-Read Sequence", UVM_LOW)
        // axi_master_write_after_read_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Error Probe Sequence", UVM_LOW)
        // axi_master_error_probe_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Reset During Transaction Sequence", UVM_LOW)
        // axi_master_reset_during_txn_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        // `uvm_info("run_phase", "Starting: AXI Master Random Stress Sequence", UVM_LOW)
        // axi_master_random_stress_seq_h.start(axi_env.axi_master_agent.axi_master_seqr);

        `uvm_info("run_phase", "Stimulus Generation Ended", UVM_LOW) 

        phase.drop_objection(this);
    endtask : run_phase

endclass : AXI_test_base

`endif // AXI_TEST_BASE_SVH
