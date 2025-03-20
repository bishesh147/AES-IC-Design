module inverse_sub_bytes
    import function_package::*;
(
    input [127:0] data_in,
    output [127:0] data_out
);
    assign data_out[127:96] = inverse_sub_word(data_in[127:96]);
    assign data_out[95:64] = inverse_sub_word(data_in[95:64]);
    assign data_out[63:32] = inverse_sub_word(data_in[63:32]);
    assign data_out[31:0] = inverse_sub_word(data_in[31:0]);
endmodule
