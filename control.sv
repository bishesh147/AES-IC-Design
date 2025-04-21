module control(
    input logic clk, rst,
    input logic receiver_valid,
    input logic aes_ready,
    input logic transmit_ready,
    input logic key_data,
    output logic [5:0] in_reg_addr,
    output logic aes_start,
    output logic out_reg_in_valid,
    output logic [3:0] out_reg_addr,
    output logic transmit_start
);
    typedef enum logic[1:0] {
        IDLE = 2'b00,
        READ_DATA = 2'b01,
        ENCRYPTION = 2'b10,
        SEND_DATA = 2'b11
    } state_t;

    state_t state_reg, state_next;

    logic [15:0] in_reg_counter_reg, in_reg_counter_next;
    logic [5:0] in_reg_addr_reg, in_reg_addr_next;
    logic [3:0] out_reg_addr_reg, out_reg_addr_next;

    always_ff @(posedge clk) begin
        if (rst) begin
            state_reg <= IDLE;
            in_reg_counter_reg <= 0;
            in_reg_addr_reg <= 0;
            out_reg_addr_reg <= 0;
        end else begin
            state_reg <= state_next;
            in_reg_counter_reg <= in_reg_counter_next;
            in_reg_addr_reg <= in_reg_addr_next;
            out_reg_addr_reg <= out_reg_addr_next;
        end
    end

    always_comb begin
        in_reg_counter_next = in_reg_counter_reg + 1;
        state_next = state_reg;
        in_reg_addr_next = in_reg_addr_reg;
        aes_start = 1'b0;
        out_reg_in_valid = 1'b0;
        transmit_start = 1'b0;
        out_reg_addr_next = out_reg_addr_reg;
        case (state_reg)
            IDLE : begin
                if (receiver_valid) begin
                    in_reg_addr_next = 6'd1;
                    in_reg_counter_next = 0;
                    state_next = READ_DATA;
                end
            end
            READ_DATA : begin
                if (in_reg_counter_reg == 16'hffff) begin
                    state_next = IDLE;
                    in_reg_addr_next = 6'd0;
                end else if (in_reg_addr_reg == 6'd33) begin
                    in_reg_addr_next = 6'd0;
                    aes_start = 1'b1;
                    state_next = ENCRYPTION;
                    in_reg_counter_next = 0;
                end else if (receiver_valid) begin
                    in_reg_addr_next = in_reg_addr_reg + 1;
                    in_reg_counter_next = 0;
                end
            end
            ENCRYPTION : begin
                if (aes_ready) begin
                    state_next = (key_data) ? SEND_DATA : IDLE;
                    out_reg_addr_next = 0;
                    out_reg_in_valid = 1'b1;
                end
            end
            SEND_DATA : begin
                if (transmit_ready) begin
                    if (out_reg_addr_reg==4'b1111) begin
                        state_next = IDLE;
                        out_reg_addr_next = 0;
                    end
                    transmit_start = 1'b1;
                    out_reg_addr_next = out_reg_addr_reg + 1;
                end
            end
        endcase
    end
    assign in_reg_addr = in_reg_addr_reg;
    assign out_reg_addr = out_reg_addr_reg;
endmodule