module get_new_keys_128
import function_package::*;
(
    input logic [31:0] in[0:3],
    input logic [3:0] round,
    output logic [31:0] out[0:3]
);
    logic [31:0] rot_res;
    logic [31:0] sub_word_res;
    logic [31:0] rcon_res;
    always_comb begin
        rot_res = rot_word(in[3]);
        sub_word_res = sub_word(rot_res);
        rcon_res = sub_word_res ^ rcon_vals[int'(round)];
        out[0] = rcon_res ^ in[0];
        out[1] = out[0] ^ in[1];
        out[2] = out[1] ^ in[2];
        out[3] = out[2] ^ in[3];
    end
endmodule