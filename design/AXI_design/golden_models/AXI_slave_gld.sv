`ifndef AXI_SLAVE_GLD_SV
`define AXI_SLAVE_GLD_SV

// Golden reference model for AXI slave behavior
module AXI_slave_gld (AXI_if.slave_gld s_axi);

    // -------------------------
    // State Machine Definitions
    // -------------------------
    typedef enum logic [2:0] {
        IDLE,   // No active transaction
        RADDR,  // Read address handshake
        RDATA,  // Read data phase
        WADDR,  // Write address handshake
        WDATA,  // Write data phase
        WRESP   // Write response phase
    } state_type;

    state_type state, next_state;

    // -------------------------
    // Internal registers
    // -------------------------
    addr_t  addr;     // Transaction address
    len_t   len;      // Burst length
    size_t  size;     // Transfer size
    burst_t burst;    // Burst type
    data_t  data;     // Data placeholder

    size_t  len_cnt;           // Burst beat counter
    data_t  buffer[0:7];       // Local storage for read/write data

    // -------------------------
    // Read Address Channel
    // -------------------------
    assign s_axi.arready = (state == RADDR) ? 1 : 0;

    // -------------------------
    // Read Data Channel
    // -------------------------
    assign s_axi.rdata  = (state == RDATA) ? buffer[addr + len_cnt] : 0;
    assign s_axi.rresp  = RESP_OKAY;
    assign s_axi.rvalid = (state == RDATA) ? 1 : 0;
    assign s_axi.rlast  = (state == RDATA && len_cnt == len && s_axi.rvalid && s_axi.rready);

    // -------------------------
    // Write Address Channel
    // -------------------------
    assign s_axi.awready = (state == WADDR) ? 1 : 0;

    // -------------------------
    // Write Data Channel
    // -------------------------
    assign s_axi.wready = (state == WDATA) ? 1 : 0;

    // -------------------------
    // Write Response Channel
    // -------------------------
    assign s_axi.bvalid = (state == WRESP) ? 1 : 0;
    assign s_axi.bresp  = RESP_OKAY;

    // -------------------------
    // Address & Burst Info Latching
    // -------------------------
    always_ff @(posedge s_axi.aclk) begin
        if (~s_axi.areset_n) begin
            addr  <= 0;
            len   <= 0;
            size  <= 0;
            burst <= 0;
        end else begin
            case (state)
                RADDR: begin
                    addr  <= s_axi.araddr;
                    len   <= s_axi.arlen;
                    size  <= s_axi.arsize;
                    burst <= s_axi.arburst;
                end
                WADDR: begin
                    addr  <= s_axi.awaddr;
                    len   <= s_axi.awlen;
                    size  <= s_axi.awsize;
                    burst <= s_axi.awburst;
                end
            endcase
        end
    end

    // -------------------------
    // Data Transfer & Storage
    // -------------------------
    always_ff @(posedge s_axi.aclk) begin
        if(~s_axi.areset_n) begin
            len_cnt <= 0;
            for (int i = 0; i < 8; i++) begin
                buffer[i] <= 32'h0;
            end
        end else begin
            case (state)
                RDATA: begin
                    if (s_axi.rvalid && s_axi.rready)
                        len_cnt <= len_cnt + 1;		
                end
                WDATA: begin
                    if (s_axi.wvalid && s_axi.wready) begin
                        if (burst == BURST_INCR) buffer[addr + len_cnt] <= s_axi.wdata;
                        else buffer[addr] <= s_axi.wdata;
                        len_cnt <= len_cnt + 1;
                    end
                end
                default: len_cnt <= 0;
            endcase
        end
    end

    // -------------------------
    // Next State Logic
    // -------------------------
    always_comb begin
        case (state)
            IDLE  : next_state = (s_axi.arvalid) ? RADDR :
                                 (s_axi.awvalid) ? WADDR : IDLE;
            RADDR : if (s_axi.arvalid && s_axi.arready) next_state = RDATA;
            RDATA : if (s_axi.rvalid && s_axi.rready && len == len_cnt) next_state = IDLE;
            WADDR : if (s_axi.awvalid && s_axi.awready) next_state = WDATA;
            WDATA : if (s_axi.wvalid && s_axi.wready && s_axi.wlast) next_state = WRESP;
            WRESP : if (s_axi.bvalid && s_axi.bready) next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // -------------------------
    // State Register
    // -------------------------
    always_ff @(posedge s_axi.aclk) begin
        if (~s_axi.areset_n)
            state <= IDLE;
        else
            state <= next_state;
    end
   
endmodule : AXI_slave_gld

`endif // AXI_SLAVE_GLD_SV