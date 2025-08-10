`ifndef AXI_SCOREBOARD_SVH
`define AXI_SCOREBOARD_SVH

    class AXI_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(AXI_scoreboard)
        
        uvm_analysis_export #(AXI_master_seq_item) master_sb_export;
        uvm_tlm_analysis_fifo #(AXI_master_seq_item) axi_master_sb;
        AXI_master_seq_item master_seq_item_sb;

        uvm_analysis_export #(AXI_slave_seq_item) slave_sb_export;
        uvm_tlm_analysis_fifo #(AXI_slave_seq_item) axi_slave_sb;
        AXI_slave_seq_item slave_seq_item_sb;

        int error_count = 0, correct_count = 0;
        
        // Default Constructor
        function new(string name = "AXI_scoreboard",uvm_component parent);
            super.new(name,parent);
        endfunction : new

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            master_sb_export = new("master_sb_export",this);
            axi_master_sb=new("axi_master_sb",this);
            slave_sb_export = new("slave_sb_export",this);
            axi_slave_sb=new("axi_slave_sb",this);
        endfunction : build_phase

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            master_sb_export.connect(axi_master_sb.analysis_export);
            slave_sb_export.connect(axi_slave_sb.analysis_export);
        endfunction : connect_phase

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                axi_master_sb.get(master_seq_item_sb);
                axi_slave_sb.get(slave_seq_item_sb);
                // check_results(master_seq_item_sb,slave_seq_item_sb);
            end
        endtask : run_phase

        // Report Phase
        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("At time %0t: Simulation Ends and Error count= %0d, Correct count= %0d",$time,error_count,correct_count),UVM_MEDIUM);
        endfunction : report_phase

        function void check_results(AXI_master_seq_item seq_item_ch_master, AXI_slave_seq_item seq_item_ch_slave);
            if (0) begin
                error_count++;
                `uvm_error("run_phase","Comparison Error between the golden model and the DUT")
                `uvm_info("MASTER", $sformatf("Master Transaction:\n%s", seq_item_ch_master.sprint()), UVM_MEDIUM)
                `uvm_info("SLAVE", $sformatf("Slave Transaction:\n%s", seq_item_ch_slave.sprint()), UVM_MEDIUM)
            end
            else
                correct_count++;
        endfunction : check_results
        
    endclass : AXI_scoreboard

`endif // AXI_SCOREBOARD_SVH