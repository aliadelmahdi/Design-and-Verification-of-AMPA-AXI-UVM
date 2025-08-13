`ifndef AXI_COVERAGE_SVH
`define AXI_COVERAGE_SVH

// AXI Coverage Component - collects functional coverage from AXI transactions
class AXI_coverage extends uvm_component;
    `uvm_component_utils(AXI_coverage)

    // Analysis exports & FIFOs for receiving transactions from master/slave monitors
    uvm_analysis_export     #(AXI_master_seq_item) master_cov_export;
    uvm_tlm_analysis_fifo   #(AXI_master_seq_item) master_cov_axi;
    AXI_master_seq_item     master_seq_item_cov;
    uvm_analysis_export     #(AXI_slave_seq_item) slave_cov_export;
    uvm_tlm_analysis_fifo   #(AXI_slave_seq_item) slave_cov_axi;
    AXI_slave_seq_item      slave_seq_item_cov;

    covergroup axi_cov_grp with function sample(AXI_master_seq_item t);

        // -------- Burst Length --------
        len_cp: coverpoint ((t.arvalid==`HIGH) ? t.arlen : t.awlen) {
        bins len_1 = {1};
        bins len_4 = {4};
        bins len_mid[] = {[2:3],[5:8]};
        ignore_bins len_long = {[16:255]};
        bins len_zero = {0};
        }

        // -------- Burst Type --------
        burst_cp: coverpoint ((t.arvalid==`HIGH) ? t.arburst : t.awburst) {
        bins fixed = {shared_pkg::BURST_FIXED};
        bins incr  = {shared_pkg::BURST_INCR}; 
        bins wrap  = {shared_pkg::BURST_WRAP};
        illegal_bins reserved = {2'b11};
        }

        // -------- Size --------
        size_cp: coverpoint ((t.arvalid==`HIGH) ? t.arsize : t.awsize) {
        bins size_1B  = {shared_pkg::SIZE_1_BYTE};
        bins size_2B  = {shared_pkg::SIZE_2_BYTE};
        bins size_4B  = {shared_pkg::SIZE_4_BYTE}; 
        bins size_8B  = {shared_pkg::SIZE_8_BYTE};
        bins size_16B = {shared_pkg::SIZE_16_BYTE};
        ignore_bins size_big = {shared_pkg::SIZE_32_BYTE,
                                shared_pkg::SIZE_64_BYTE,
                                shared_pkg::SIZE_128_BYTE};
        }

        // -------- Address LSB[2:0] range 0..7 --------
        addr_cp: coverpoint (((t.arvalid==`HIGH)? t.araddr[2:0] : t.awaddr[2:0])) {
        bins a0={0}; bins a1={1}; bins a2={2}; bins a3={3};
        bins a4={4}; bins a5={5}; bins a6={6}; bins a7={7};
        }

        // -------- WSTRB patterns --------
        wstrb_cp: coverpoint t.wstrb {
        bins all_ones = { {shared_pkg::STRB_WIDTH{1'b1}} };
        bins low_half     = { (shared_pkg::STRB_WIDTH>=4) ? 4'b0011 : 0 };
        bins high_half    = { (shared_pkg::STRB_WIDTH>=4) ? 4'b1100 : 0 };
        bins alternating1 = { (shared_pkg::STRB_WIDTH>=4) ? 4'b1010 : 0 };
        bins alternating2 = { (shared_pkg::STRB_WIDTH>=4) ? 4'b0101 : 0 };
        // ignore_bins wide_misc = default iff (shared_pkg::STRB_WIDTH > 4);
        }

        // -------- FSM State (from master_seq_item_cov) --------

        m_fsm_state_cp: coverpoint t.m_fsm_state {
        bins idle = {0};
        bins ar   = {1};
        bins r    = {2};
        bins aw   = {3};
        bins w    = {4};
        bins b    = {5};
        // illegal_bins bad = default iff (!(item inside {0,1,2,3,4,5}));
        // Transition coverage (no prev variables; pure transition bins)
        bins idle_to_ar = (0 => 1);
        bins ar_to_r    = (1 => 2);
        bins r_to_idle  = (2 => 0);
        bins idle_to_aw = (0 => 3);
        bins aw_to_w    = (3 => 4);
        bins w_to_b     = (4 => 5);
        bins b_to_idle  = (5 => 0);
        // Some illegal arcs
        illegal_bins ar_to_w  = (1 => 4);
        illegal_bins w_to_r   = (4 => 2);
        // illegal_bins selfloop = (1 => 1), (2 => 2), (3 => 3), (4 => 4), (5 => 5);
        }

        // -------- BRESP --------
        bresp_cp: coverpoint t.bresp {
        bins okay   = {shared_pkg::RESP_OKAY};
        bins slverr = {shared_pkg::RESP_SLVERR};
        bins decerr = {shared_pkg::RESP_DECERR};
        ignore_bins exokay = {shared_pkg::RESP_EXOKAY};
        }

        // -------- Read/Write Mix (transition bins) --------
        // Map op to: 1=READ, 0=WRITE, 2=IDLE/other (ignored via ignore_bins).
        op_cp: coverpoint {t.start_read, t.start_write} {
        // steady-state bins
        bins READ  = {2'b10};
        bins WRITE = {2'b01};

        // ignore idle and illegal both-asserted
        ignore_bins idle_or_both = {2'b00, 2'b11};

        // Mixed traffic via transitions (legal sequences over time)
        bins read_to_write = (2'b10 => 2'b01);
        bins write_to_read = (2'b01 => 2'b10);
        }

        // -------- Crosses --------
        // Burst x Size x Len at boundary addresses
        burst_size_len_x_addr: cross burst_cp, size_cp, len_cp, addr_cp {
        }

        // Size x WSTRB
        size_wstrb_x: cross size_cp, wstrb_cp;

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
            axi_cov_grp.sample(master_seq_item_cov);
        end
    endtask : run_phase

endclass : AXI_coverage

`endif // AXI_COVERAGE_SVH