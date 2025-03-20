module add_round_key
(
    input logic [127:0] data_in, round_key,
    output logic [127:0] data_out
);
    assign data_out = data_in ^ round_key;
endmodule