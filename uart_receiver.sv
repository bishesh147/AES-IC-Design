module uart_receiver(
    input logic clk, rst,
    input logic serial_in,
    output logic [7:0] parallel_out,
    output logic valid
);
    typedef enum logic[1:0] {
        IDLE = 2'b00,
        READ_DATA = 2'b01,
        STOP_BIT = 2'b10
    } state_t;

    state_t state_reg, state_next;
    logic [9:0] counter_reg, counter_next;
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
        counter_rst = (counter_reg == 868);
        counter_next = (counter_rst) ? 0 : counter_reg + 1;
        data_next = data_reg;
        data_cnt_next = data_cnt_reg;

        case (state_reg)
            IDLE : begin
                if (!serial_in & counter_rst) begin
                    state_next = READ_DATA;
                end
            end
            READ_DATA : begin
                if (counter_rst) begin
                    data_cnt_next = data_cnt_reg + 1;
                    data_next = {data_reg[6:0], serial_in};
                    state_next = (&data_cnt_reg) ? STOP_BIT : READ_DATA;
                end
            end
            STOP_BIT : begin
                if (counter_rst) state_next = IDLE;
            end
            default : begin
                state_next = state_reg;
                counter_rst = (counter_reg == 868);
                counter_next = (counter_rst) ? 0 : counter_reg + 1;
                data_next = data_reg;
                data_cnt_next = data_cnt_reg;
            end
        endcase
    end
    assign parallel_out = data_reg;
    assign valid = (state_reg == STOP_BIT);
endmodule