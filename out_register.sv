module out_register(
    input logic clk, rst,
    input logic [127:0] data_in,
    input logic in_valid,
    input logic [3:0] addr,
    output logic [7:0] data_out 
);
    logic [7:0] data_reg[0:15];
    logic [7:0] data_next[0:15];

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i<16; i=i+1)
                data_reg[i] <= 0;
        end
        else begin
            for (int i = 0; i<16; i=i+1)
                data_reg[i] <= data_next[i];
        end
    end

    logic [7:0] data_next_n[0:15];
    genvar i;
    generate
        for (i=1; i < 17; i=i+1) begin
            assign data_next_n[i-1] = data_in[i*8-1:i*8-8];
        end
    endgenerate

    always_comb begin
        for (int i = 0; i<16; i=i+1)
            data_next[i] = data_reg[i];
        if (in_valid) begin
            for (int i = 0; i < 16; i=i+1) begin
                data_next[i] = data_next_n[i];
            end
        end
    end

    assign data_out = data_reg[addr];
endmodule