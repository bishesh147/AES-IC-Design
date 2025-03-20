module inverse_shift_rows
(
    input logic [127:0] data_in,
    output logic [127:0] data_out
);
    logic [31:0] row0, row1, row2, row3;
    logic [31:0] row0_shifted, row1_shifted, row2_shifted, row3_shifted;
    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin
            assign row0[(4-i)*8-1:(4-i)*8-8] = data_in[(4-i)*32-1:(4-i)*32-8]; 
            assign row1[(4-i)*8-1:(4-i)*8-8] = data_in[(4-i)*32-9:(4-i)*32-16];
            assign row2[(4-i)*8-1:(4-i)*8-8] = data_in[(4-i)*32-17:(4-i)*32-24];
            assign row3[(4-i)*8-1:(4-i)*8-8] = data_in[(4-i)*32-25:(4-i)*32-32];
        end
    endgenerate
    assign row0_shifted = row0;
    assign row1_shifted = {row1[7:0], row1[31:8]};
    assign row2_shifted = {row2[15:0], row2[31:16]};
    assign row3_shifted = {row3[23:0], row3[31:24]};
    generate
        for (i=0; i<4; i=i+1) begin
            assign data_out[(4-i)*32-1:(4-i)*32-32] = {row0_shifted[(4-i)*8-1:(4-i)*8-8], row1_shifted[(4-i)*8-1:(4-i)*8-8], row2_shifted[(4-i)*8-1:(4-i)*8-8], row3_shifted[(4-i)*8-1:(4-i)*8-8]};
        end
    endgenerate
endmodule