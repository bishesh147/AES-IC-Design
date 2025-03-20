module aes_core
    import function_package::*;
(
    input logic clk, rst, start,
    input logic [1:0] key_length,
    input logic encrypt_decrypt,
    input logic [127:0] data,
    input logic [127:0] round_key,

    output logic valid,
    output logic [3:0] round,
    output logic [127:0] aes_out
);
    typedef enum logic[0:0] {
        IDLE = 1'b0,
        WRITE = 1'b1
    } state_t;

    state_t state_reg, state_next;
    logic [3:0] counter_reg, counter_next;
    logic [127:0] encryption_reg, encryption_next;

    logic [127:0] add_round_key_data_in_1, add_round_key_data_out_1; 
    add_round_key ark1(.data_in(add_round_key_data_in_1), .round_key(round_key), .data_out(add_round_key_data_out_1));

    logic [127:0] sub_bytes_data_out; 
    sub_bytes sub1(.data_in(encryption_reg), .data_out(sub_bytes_data_out));

    logic [127:0] shift_rows_data_out; 
    shift_rows shr1(.data_in(sub_bytes_data_out), .data_out(shift_rows_data_out));
    
    logic [127:0] mix_columns_data_out; 
    mix_columns mix1(.data_in(shift_rows_data_out), .data_out(mix_columns_data_out));

    logic [127:0] add_round_key_data_in_2, add_round_key_data_out_2; 
    add_round_key ark2(.data_in(add_round_key_data_in_2), .round_key(round_key), .data_out(add_round_key_data_out_2));

    logic [127:0] inv_shift_rows_out;
    inverse_shift_rows isr1(.data_in(encryption_reg), .data_out(inv_shift_rows_out));

    logic [127:0] inv_sub_bytes_out;
    inverse_sub_bytes isb1(.data_in(inv_shift_rows_out), .data_out(inv_sub_bytes_out));

    logic [127:0] add_round_key_data_out_3;
    add_round_key ark3(.data_in(inv_sub_bytes_out), .round_key(round_key), .data_out(add_round_key_data_out_3));

    logic [127:0] inv_mix_columns_out;
    inverse_mix_columns imc1(.data_in(add_round_key_data_out_3), .data_out(inv_mix_columns_out));
 
    always @(posedge clk) begin
        if (rst) begin
            state_reg <= IDLE;
            counter_reg <= 4'd0;
            encryption_reg <= add_round_key_data_out_1;
        end else begin
            state_reg <= state_next;
            counter_reg <= counter_next;
            encryption_reg <= encryption_next;
        end
    end

    always_comb begin
        round = counter_reg;
        case (key_length)
            2'b10   : round = (encrypt_decrypt) ? counter_reg : 4'd12 - counter_reg;  //key_length = 192
            2'b11   : round = (encrypt_decrypt) ? counter_reg : 4'd14 - counter_reg;  //key_length = 256
            default : round = (encrypt_decrypt) ? counter_reg : 4'd10 - counter_reg;  //key_length = 128
        endcase
    end

    always_comb begin
        state_next = state_reg;
        counter_next = counter_reg;
        add_round_key_data_in_1 = data;
        add_round_key_data_in_2 = mix_columns_data_out;
        aes_out = encryption_reg;
        valid = (state_reg == IDLE) & (!start);
        encryption_next = encryption_reg;
        
        case (state_reg)
            IDLE : begin
                if (start) begin
                    state_next = WRITE;
                    counter_next = 4'd0;
                end
            end
            WRITE : begin
                counter_next = counter_reg + 1;
                if (encrypt_decrypt) encryption_next = (counter_reg == 4'd0) ? add_round_key_data_out_1 : add_round_key_data_out_2;
                else encryption_next = (counter_reg == 4'd0) ? add_round_key_data_out_1 : inv_mix_columns_out;
                case (key_length)
                    2'b10 : begin // key_length = 192
                        if (counter_reg == 4'd12) begin
                            state_next = IDLE;
                            add_round_key_data_in_2 = shift_rows_data_out;
                            if (!encrypt_decrypt) encryption_next = add_round_key_data_out_3;
                        end
                    end
                    2'b11 : begin // key_length = 256
                        if (counter_reg == 4'd14) begin
                            state_next = IDLE;
                            add_round_key_data_in_2 = shift_rows_data_out;
                            if (!encrypt_decrypt) encryption_next = add_round_key_data_out_3;
                        end
                    end
                    default : begin // key_length = 128
                        if (counter_reg == 4'd10) begin
                            state_next = IDLE;
                            add_round_key_data_in_2 = shift_rows_data_out;
                            if (!encrypt_decrypt) encryption_next = add_round_key_data_out_3;
                        end
                    end
                endcase
            end
        endcase
    end
endmodule
