module read_register(
    input logic clk, rst,
    input logic [7:0] data_in,
    input logic in_valid,
    input logic [5:0] addr,
    output logic [263:0] data_out
);
    logic [7:0] data_reg[0:32];
    logic [7:0] data_next[0:32];

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i<33; i=i+1)
                data_reg[i] <= 0;
        end
        else begin
            for (int i = 0; i<33; i=i+1)
                data_reg[i] <= data_next[i];
        end
    end

    always_comb begin
        for (int i = 0; i<33; i=i+1)
            data_next[i] = data_reg[i];
        if (in_valid) data_next[addr] = data_in;
    end

    genvar i;
    generate
        for (i=1; i < 34; i=i+1)
            assign data_out[i*8-1:i*8-8] = data_reg[i-1];
    endgenerate
endmodule