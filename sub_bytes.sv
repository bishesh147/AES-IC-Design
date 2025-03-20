module sub_bytes
    import function_package::*;
(
    input [127:0] data_in,
    output [127:0] data_out
);
    assign data_out[127:96] = sub_word(data_in[127:96]);
    assign data_out[95:64] = sub_word(data_in[95:64]);
    assign data_out[63:32] = sub_word(data_in[63:32]);
    assign data_out[31:0] = sub_word(data_in[31:0]);
endmodule
