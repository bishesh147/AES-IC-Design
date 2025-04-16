module uart_transmitter
#(
    parameter CLK_SPEED = 100_000_000,
    parameter BAUD_RATE = 625000,
    parameter COUNT_DIV = CLK_SPEED / BAUD_RATE
)
(
    input logic clk, rst,
    input [7:0] data_in,
    input start,
    output serial_out, ready
);
    typedef enum logic[0:0] {
        IDLE = 1'b0,
        SENDING = 1'b1
    } state_t;

    state_t state_reg, state_next;
    logic [9:0] counter_reg, counter_next;
    logic [3:0] data_cnt_reg, data_cnt_next;
    logic [9:0] data_reg, data_next;
    logic counter_rst;

    always_ff @(posedge clk) begin
        if (rst) begin
            state_reg <= IDLE;
            counter_reg <= 0;
            data_cnt_reg <= 0;
            data_reg <= 10'b1111111111;
        end else begin
            state_reg <= state_next;
            counter_reg <= counter_next;
            data_cnt_reg <= data_cnt_next;
            data_reg <= data_next;
        end
    end

    always_comb begin
        counter_rst = (counter_reg == COUNT_DIV-1);
        counter_next = counter_reg;
        data_cnt_next = data_cnt_reg;
        state_next = state_reg;
        data_next = data_reg;
        case (state_reg)
            IDLE : begin
                if (start) begin
                    state_next = SENDING;
                    data_next[8:0] = {data_in, 1'b0};
                end
            end
            SENDING : begin
                counter_next = (counter_rst) ? 0 : counter_reg + 1;
                if (counter_rst) begin
                    data_cnt_next = (data_cnt_reg == 9) ? 0 : data_cnt_reg + 1;
                    data_next = {1'b1, data_reg[9:1]};
                    state_next = (data_cnt_reg == 9) ? IDLE : SENDING;
                end
            end 
        endcase
    end
    assign serial_out = data_reg[0];
    assign ready = (state_reg == IDLE);
endmodule
