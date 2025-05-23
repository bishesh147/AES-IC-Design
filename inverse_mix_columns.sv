module inverse_mix_columns
    import function_package::*;
(
    input logic [127:0] data_in,
    output logic [127:0] data_out
);
    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin
            assign data_out[(4-i)*32-1:(4-i)*32-8] = galois_mult_14(data_in[(4-i)*32-1:(4-i)*32-8]) ^ galois_mult_11(data_in[(4-i)*32-9:(4-i)*32-16]) ^ galois_mult_13(data_in[(4-i)*32-17:(4-i)*32-24]) ^ galois_mult_9(data_in[(4-i)*32-25:(4-i)*32-32]);
            assign data_out[(4-i)*32-9:(4-i)*32-16] = galois_mult_9(data_in[(4-i)*32-1:(4-i)*32-8]) ^ galois_mult_14(data_in[(4-i)*32-9:(4-i)*32-16]) ^ galois_mult_11(data_in[(4-i)*32-17:(4-i)*32-24]) ^ galois_mult_13(data_in[(4-i)*32-25:(4-i)*32-32]);
            assign data_out[(4-i)*32-17:(4-i)*32-24] = galois_mult_13(data_in[(4-i)*32-1:(4-i)*32-8]) ^ galois_mult_9(data_in[(4-i)*32-9:(4-i)*32-16]) ^ galois_mult_14(data_in[(4-i)*32-17:(4-i)*32-24]) ^ galois_mult_11(data_in[(4-i)*32-25:(4-i)*32-32]);
            assign data_out[(4-i)*32-25:(4-i)*32-32] = galois_mult_11(data_in[(4-i)*32-1:(4-i)*32-8]) ^ galois_mult_13(data_in[(4-i)*32-9:(4-i)*32-16]) ^ galois_mult_9(data_in[(4-i)*32-17:(4-i)*32-24]) ^ galois_mult_14(data_in[(4-i)*32-25:(4-i)*32-32]);
        end
    endgenerate
endmodule