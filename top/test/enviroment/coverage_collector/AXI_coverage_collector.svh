`ifndef AXI_COVERAGE_SVH
`define AXI_COVERAGE_SVH

// AXI Coverage Component - collects functional coverage from AXI transactions
class AXI_coverage extends uvm_component;
    `uvm_component_utils(AXI_coverage)

    // Analysis exports & FIFOs for receiving transactions from master/slave monitors
    uvm_analysis_export #(AXI_master_seq_item) master_cov_export;
    uvm_tlm_analysis_fifo #(AXI_master_seq_item) master_cov_axi;
    AXI_master_seq_item master_seq_item_cov;
    uvm_analysis_export #(AXI_slave_seq_item) slave_cov_export;
    uvm_tlm_analysis_fifo #(AXI_slave_seq_item) slave_cov_axi;
    AXI_slave_seq_item slave_seq_item_cov;

    // Covergroup for AXI transaction coverage
    covergroup axi_cov_grp;
        // Coverage bins/signals to be added here
    endgroup : axi_cov_grp

    // Constructor
    function new (string name = "AXI_coverage", uvm_component parent);
        super.new(name, parent);
        axi_cov_grp = new();
    endfunction : new

    // Build Phase - create analysis exports and FIFOs
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        master_cov_export = new("master_cov_export", this);
        master_cov_axi    = new("master_cov_axi", this);
        slave_cov_export  = new("slave_cov_export", this);
        slave_cov_axi     = new("slave_cov_axi", this);
    endfunction : build_phase

    // Connect Phase - link analysis exports to FIFOs
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        master_cov_export.connect(master_cov_axi.analysis_export);
        slave_cov_export.connect(slave_cov_axi.analysis_export);
    endfunction : connect_phase

    // Run Phase - continuously sample coverage from received transactions
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            master_cov_axi.get(master_seq_item_cov); // Get master transaction
            slave_cov_axi.get(slave_seq_item_cov);   // Get slave transaction
            axi_cov_grp.sample();                    // Sample coverage
        end
    endtask : run_phase

endclass : AXI_coverage

`endif // AXI_COVERAGE_SVH