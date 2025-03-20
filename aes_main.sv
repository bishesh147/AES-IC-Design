module aes_main
(
    input logic clk, rst, key_data,
    input logic [1:0] key_length,
    input logic encrypt_decrypt,
    input logic [255:0] data,
    input logic start,

    output logic [127:0] result,
    output logic ready
);
    // key_data = 1 means the data must be read as data, else as key
    logic [1:0] internal_key_length;
    logic [127:0] round_key;
    logic [3:0] round;
    logic aes_core_start;
    logic key_expand_start;
    logic aes_core_valid;
    logic key_expand_valid;

    typedef enum logic[0:0] {
        IDLE = 1'b0,
        WORK = 1'b1
    } state_t;

    state_t state_reg, state_next;

    aes_core ac1(.clk(clk), .rst(rst), .start(aes_core_start),
                 .key_length(internal_key_length),
                 .encrypt_decrypt(encrypt_decrypt),
                 .data(data[127:0]),
                 .round_key(round_key),
                 .valid(aes_core_valid),
                 .round(round),
                 .aes_out(result));

    key_expand kex1(.clk(clk), .rst(rst), .change_key(key_expand_start),
                    .key(data), .key_length_in(key_length),
                    .round(round),
                    .round_key(round_key),
                    .key_length_out(internal_key_length),
                    .valid(key_expand_valid));

    always @(posedge clk) begin
        if (rst) begin
            state_reg <= IDLE;
        end else begin
            state_reg <= state_next;
        end
    end

    always_comb begin
        state_next = state_reg;
        aes_core_start = 1'b0;
        key_expand_start = 1'b0;
        case (state_reg)
            IDLE : begin
                if (start) state_next = WORK;
            end
            WORK : begin
                if (key_data) aes_core_start = 1'b1;
                else key_expand_start = 1'b1;
                if (key_expand_valid && aes_core_valid) state_next = IDLE;
            end
        endcase
    end

    assign ready = (state_reg == IDLE);
endmodule