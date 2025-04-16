module uart_receiver
#(
    parameter CLK_SPEED = 100_000_000,
    parameter BAUD_RATE = 625000,
    parameter COUNT_DIV = CLK_SPEED / BAUD_RATE,
    parameter COUNT_DIV_2 = COUNT_DIV/2
)
(
    input logic clk, rst,
    input logic serial_in,
    output logic [7:0] parallel_out,
    output logic valid
);
    typedef enum logic[1:0] {
        IDLE = 2'b00,
        GO_MIDDLE = 2'b01,
        SAMPLE = 2'b11,
        STOP_BIT = 2'b10
    } state_t;

    state_t state_reg, state_next;
    logic [$clog2(COUNT_DIV)-1:0] counter_reg, counter_next;
    logic [2:0] data_cnt_reg, data_cnt_next;
    logic [7:0] data_reg, data_next;

    logic counter_rst;

    always_ff @(posedge clk) begin
        if (rst) begin
            counter_reg <= 0;
            state_reg <= IDLE;
            data_reg <= 0;
            data_cnt_reg <= 0;
        end else begin
            counter_reg <= counter_next;
            state_reg <= state_next;
            data_reg <= data_next;
            data_cnt_reg <= data_cnt_next;
        end
    end

    always_comb begin
        state_next = state_reg;
        counter_rst = (counter_reg == COUNT_DIV-1);
        counter_next = counter_reg;
        data_next = data_reg;
        data_cnt_next = data_cnt_reg;
        case (state_reg)
            IDLE : begin
                if (!serial_in) begin
                    state_next = GO_MIDDLE;
                    data_cnt_next = 0;
                end
            end
            GO_MIDDLE : begin
                counter_next = (counter_rst) ? 0 : counter_reg + 1;
                if (counter_reg == (COUNT_DIV_2-1)) begin
                    if (!serial_in) state_next = SAMPLE;
                    else state_next = IDLE;
                    counter_next = 0;
                end
            end
            SAMPLE : begin
                counter_next = (counter_rst) ? 0 : counter_reg + 1;
                if (counter_rst) begin
                    data_cnt_next = data_cnt_reg + 1;
                    data_next = {data_reg[6:0], serial_in};
                    state_next = (&data_cnt_reg) ? STOP_BIT : SAMPLE;
                end
            end
            STOP_BIT : begin
                counter_next = (counter_rst) ? 0 : counter_reg + 1;
                if (counter_rst) state_next = IDLE;
            end
        endcase
    end
    assign parallel_out = data_reg;
    assign valid = (state_reg == STOP_BIT & state_next == IDLE);
endmodule