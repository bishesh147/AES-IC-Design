module key_expand
    import function_package::*;
(
    input logic clk, rst, change_key,
    input logic [255:0] key,
    input logic [1:0] key_length_in,
    input logic [3:0] round,
    output logic [127:0] round_key,
    output logic [1:0] key_length_out,
    output logic valid
);
    typedef enum logic[0:0] { 
        IDLE=1'b0,
        WRITE=1'b1
    } state_t;

    state_t state_reg, state_next;
    logic [1:0] key_length_reg, key_length_next;
    logic [31:0] round_key_reg[0:63];
    logic [31:0] round_key_next[0:63];
    logic [3:0] counter_reg, counter_next;
    
    logic [6:0] shifted_round;
    logic [6:0] shifted_counter_reg;

    logic [31:0] curr_keys_128[0:3];
    logic [31:0] curr_keys_192[0:5];
    logic [31:0] curr_keys_256[0:7];
    logic [31:0] next_keys_128[0:3];
    logic [31:0] next_keys_192[0:5];
    logic [31:0] next_keys_256[0:7];
    get_new_keys_128 gnk128(.in(curr_keys_128), .round(counter_reg), .out(next_keys_128));
    get_new_keys_192 gnk192(.in(curr_keys_192), .round(counter_reg), .out(next_keys_192));
    get_new_keys_256 gnk256(.in(curr_keys_256), .round(counter_reg), .out(next_keys_256));

    always @(posedge clk) begin
        if (rst) begin // If rst, use a default key of 256 bits
            state_reg <= IDLE;
            key_length_reg <= 2'b11;
            counter_reg <= 4'b0;
            for (int i=0; i<64; i=i+1) begin
                round_key_reg[i] <= rst_round_keys[i];
            end
        end else begin
            state_reg <= state_next;
            for (int i=0; i<64; i=i+1) begin
                round_key_reg[i] <= round_key_next[i];
            end
            key_length_reg <= key_length_next;
            counter_reg <= counter_next;
        end
    end

    always_comb begin
        shifted_round = round << 2;
        state_next = state_reg;
        key_length_next = key_length_reg;
        counter_next = counter_reg;
        shifted_counter_reg = counter_reg << 2;
        round_key = 128'd0;
        for (int i=0; i<4; i=i+1) begin
            curr_keys_128[i] = 32'd0;
        end
        curr_keys_192[5] = 32'd0;
        curr_keys_192[6] = 32'd0;
        curr_keys_256[5] = 32'd0;
        curr_keys_256[6] = 32'd0;
        curr_keys_256[7] = 32'd0;
        curr_keys_256[8] = 32'd0;
        for (int i=0; i<64; i=i+1) begin
            round_key_next[i] = round_key_reg[i];
        end
        case (state_reg)
            IDLE : begin
                if (change_key) begin
                    state_next = WRITE;
                    key_length_next = key_length_in;
                    counter_next = 0;
                    case (key_length_in)
                        2'b10 : begin // key_length = 192
                            round_key_next[0] = key[191:160];
                            round_key_next[1] = key[159:128];
                            round_key_next[2] = key[127:96];
                            round_key_next[3] = key[95:64];
                            round_key_next[4] = key[63:32];
                            round_key_next[5] = key[31:0];
                        end
                        2'b11 : begin // key_length = 256
                            round_key_next[0] = key[255:224];
                            round_key_next[1] = key[223:192];
                            round_key_next[2] = key[191:160];
                            round_key_next[3] = key[159:128];
                            round_key_next[4] = key[127:96];
                            round_key_next[5] = key[95:64];
                            round_key_next[6] = key[63:32];
                            round_key_next[7] = key[31:0];
                        end
                        default : begin // key_length = 128
                            round_key_next[0] = key[127:96];
                            round_key_next[1] = key[95:64];
                            round_key_next[2] = key[63:32];
                            round_key_next[3] = key[31:0];
                        end
                    endcase
                end
                valid = 1'b1;
                round_key = {round_key_reg[shifted_round], round_key_reg[shifted_round+1], round_key_reg[shifted_round+2], round_key_reg[shifted_round+3]};
            end
            WRITE : begin
                valid = 1'b0;
                round_key = 128'h0;
                counter_next = counter_reg + 1;
                case (key_length_reg)
                    2'b10 : begin // key_length = 192
                        shifted_counter_reg = (counter_reg << 2) + (counter_reg << 1);
                        curr_keys_192[0] = round_key_reg[shifted_counter_reg];
                        curr_keys_192[1] = round_key_reg[shifted_counter_reg+1];
                        curr_keys_192[2] = round_key_reg[shifted_counter_reg+2];
                        curr_keys_192[3] = round_key_reg[shifted_counter_reg+3];
                        curr_keys_192[4] = round_key_reg[shifted_counter_reg+4];
                        curr_keys_192[5] = round_key_reg[shifted_counter_reg+5];
                        round_key_next[shifted_counter_reg+6] = next_keys_192[0];
                        round_key_next[shifted_counter_reg+7] = next_keys_192[1];
                        round_key_next[shifted_counter_reg+8] = next_keys_192[2];
                        round_key_next[shifted_counter_reg+9] = next_keys_192[3];
                        round_key_next[shifted_counter_reg+10] = next_keys_192[4];
                        round_key_next[shifted_counter_reg+11] = next_keys_192[5];
                        if (counter_reg == 4'b0111) state_next = IDLE;
                    end
                    2'b11 : begin // key_length = 256
                        shifted_counter_reg = (counter_reg << 3);
                        curr_keys_256[0] = round_key_reg[shifted_counter_reg];
                        curr_keys_256[1] = round_key_reg[shifted_counter_reg+1];
                        curr_keys_256[2] = round_key_reg[shifted_counter_reg+2];
                        curr_keys_256[3] = round_key_reg[shifted_counter_reg+3];
                        curr_keys_256[4] = round_key_reg[shifted_counter_reg+4];
                        curr_keys_256[5] = round_key_reg[shifted_counter_reg+5];
                        curr_keys_256[6] = round_key_reg[shifted_counter_reg+6];
                        curr_keys_256[7] = round_key_reg[shifted_counter_reg+7];
                        round_key_next[shifted_counter_reg+8] = next_keys_256[0];
                        round_key_next[shifted_counter_reg+9] = next_keys_256[1];
                        round_key_next[shifted_counter_reg+10] = next_keys_256[2];
                        round_key_next[shifted_counter_reg+11] = next_keys_256[3];
                        round_key_next[shifted_counter_reg+12] = next_keys_256[4];
                        round_key_next[shifted_counter_reg+13] = next_keys_256[5];
                        round_key_next[shifted_counter_reg+14] = next_keys_256[6];
                        round_key_next[shifted_counter_reg+15] = next_keys_256[7];
                        if (counter_reg == 4'b0110) state_next = IDLE;
                    end
                    default : begin // key_length = 128
                        curr_keys_128[0] = round_key_reg[shifted_counter_reg];
                        curr_keys_128[1] = round_key_reg[shifted_counter_reg+1];
                        curr_keys_128[2] = round_key_reg[shifted_counter_reg+2];
                        curr_keys_128[3] = round_key_reg[shifted_counter_reg+3];
                        round_key_next[shifted_counter_reg+4] = next_keys_128[0];
                        round_key_next[shifted_counter_reg+5] = next_keys_128[1];
                        round_key_next[shifted_counter_reg+6] = next_keys_128[2];
                        round_key_next[shifted_counter_reg+7] = next_keys_128[3];
                        if (counter_reg == 4'b1001) state_next = IDLE;
                    end
                endcase
            end       
        endcase
        key_length_out = key_length_reg;
    end
endmodule
