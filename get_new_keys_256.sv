module get_new_keys_256
import function_package::*;
(
    input logic [31:0] in[0:7],
    input logic [3:0] round,
    output logic [31:0] out[0:7]
);
    logic [31:0] rot_res;
    logic [31:0] sub_word_res;
    logic [31:0] rcon_res;
    always_comb begin
        rot_res = rot_word(in[7]);
        sub_word_res = sub_word(rot_res);
        rcon_res = sub_word_res ^ rcon_vals[int'(round)];
        out[0] = rcon_res ^ in[0];
        out[1] = out[0] ^ in[1];
        out[2] = out[1] ^ in[2];
        out[3] = out[2] ^ in[3];
        out[4] = sub_word(out[3]) ^ in[4];
        out[5] = out[4] ^ in[5];
        out[6] = out[5] ^ in[6];
        out[7] = out[6] ^ in[7];
    end
endmodule