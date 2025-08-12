`ifndef AXI_MASTER_GLD_SV
`define AXI_MASTER_GLD_SV

// Golden reference model for AXI master behavior
module AXI_master_gld (AXI_if.master_gld m_axi);

    // -------------------------
    // State Machine Definitions
    // -------------------------
    typedef enum logic [2:0] {
        IDLE,   // No transaction in progress
        RADDR,  // Read address phase
        RDATA,  // Read data phase
        WADDR,  // Write address phase
        WDATA,  // Write data phase
        WRESP   // Write response phase
    } state_type;

    state_type state, next_state;

    localparam LEN = 4; // Fixed burst length

    // -------------------------
    // Internal registers
    // -------------------------
    // addr_t addr  = 32'h4;          // Base transaction address
    // data_t data  = 32'hdeadbeef;   // Initial write data
    len_t  len_cnt;                // Burst beat counter
    data_t rdata[0:7];              // Local buffer for read data
    logic [2:0] rdata_cnt;          // Read data beat counter
    logic start_read_delay;         // Delayed start_read signal
    logic start_write_delay;        // Delayed start_write signal

    // -------------------------
    // Read Address Channel
    // -------------------------
    assign m_axi.araddr_ref  = (state == RADDR) ? m_axi.addr : 32'h0;
    assign m_axi.arvalid_ref = (state == RADDR);
    // assign m_axi.arlen   = LEN - 1;
    // assign m_axi.arsize  = SIZE_4_BYTE;
    // assign m_axi.arburst = BURST_INCR;

    // -------------------------
    // Read Data Channel
    // -------------------------
    assign m_axi.rready_ref = (state == RDATA);

    // -------------------------
    // Write Address Channel
    // -------------------------
    assign m_axi.awaddr_ref  = (state == WADDR) ? m_axi.addr : 32'h0;
    assign m_axi.awvalid_ref = (state == WADDR);
    // assign m_axi.awlen   = LEN - 1;
    // assign m_axi.awsize  = SIZE_4_BYTE;
    // assign m_axi.awburst = BURST_INCR;

    // -------------------------
    // Write Data Channel
    // -------------------------
    assign m_axi.wdata_ref  = (state == WDATA) ? m_axi.data + len_cnt : 32'h0;
    // assign m_axi.wstrb  = 4'b1111;
    assign m_axi.wvalid_ref = (state == WDATA);
    assign m_axi.wlast_ref  = (state == WDATA && len_cnt == LEN);

    // -------------------------
    // Write Response Channel
    // -------------------------
    assign m_axi.bready_ref = (state == WRESP);

    // -------------------------
    // Data Capture & Counters
    // -------------------------
    always_ff @(posedge m_axi.aclk) begin
        if (~m_axi.areset_n) begin
            for (int i = 0; i < 8; i++) begin
                rdata[i] <= 32'h0;
            end
            rdata_cnt <= 0;
            len_cnt   <= 0;
        end else begin
            // Store read data into buffer
            if (state == RDATA && m_axi.rvalid_ref && m_axi.rready_ref) begin
                rdata[m_axi.addr + rdata_cnt] <= m_axi.rdata_ref;
                rdata_cnt <= rdata_cnt + 1;
            end
            // Increment write data counter
            if (state == WDATA && m_axi.wvalid_ref && m_axi.wready_ref)
                len_cnt <= len_cnt + 1;
        end
    end

    // -------------------------
    // Delay start signals
    // -------------------------
    always_ff @(posedge m_axi.aclk) begin
        if (~m_axi.areset_n) begin
            start_read_delay  <= 0;
            start_write_delay <= 0;
        end else begin
            start_read_delay  <= m_axi.start_read;
            start_write_delay <= m_axi.start_write;
        end
    end

    // -------------------------
    // Next State Logic
    // -------------------------
    always_comb begin
        case (state)
            IDLE  : next_state = (start_read_delay) ? RADDR :
                                 (start_write_delay) ? WADDR : IDLE;
            RADDR : if (m_axi.arvalid_ref && m_axi.arready_ref) next_state = RDATA;
            RDATA : if (m_axi.rvalid_ref && m_axi.rready_ref && m_axi.rlast_ref) next_state = IDLE;
            WADDR : if (m_axi.awvalid_ref && m_axi.awready_ref) next_state = WDATA;
            WDATA : if (m_axi.wvalid_ref && m_axi.wready_ref && m_axi.wlast_ref) next_state = WRESP;
            WRESP : if (m_axi.bvalid_ref && m_axi.bready_ref) next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // -------------------------
    // State Register
    // -------------------------
    always_ff @(posedge m_axi.aclk) begin
        if (~m_axi.areset_n)
            state <= IDLE;
        else
            state <= next_state;
    end

endmodule : AXI_master_gld

`endif // AXI_MASTER_GLD_SV