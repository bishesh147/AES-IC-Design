module IC_top(
    input logic clk, rst,
    input logic rx,
    output logic tx
);
    logic [7:0] receiver_data;
    logic receiver_valid;
    logic [5:0] in_reg_addr;
    logic [263:0] in_reg_data;
    logic aes_start;
    logic aes_ready;
    logic [127:0] aes_result;
    logic out_reg_in_valid;
    logic [3:0] out_reg_addr;
    logic [7:0] out_reg_data;
    logic transmit_start;
    logic transmit_ready;

    uart_receiver ur1(.clk(clk), .rst(rst), 
                      .serial_in(rx), .parallel_out(receiver_data), 
                      .valid(receiver_valid));

    control ctr1(.clk(clk), .rst(rst), 
                 .receiver_valid(receiver_valid), .in_reg_addr(in_reg_addr),
                 .aes_start(aes_start), .aes_ready(aes_ready),
                 .key_data(in_reg_data[7]),
                 .out_reg_in_valid(out_reg_in_valid),
                 .out_reg_addr(out_reg_addr),
                 .transmit_start(transmit_start),
                 .transmit_ready(transmit_ready));

    read_register rr1(.clk(clk), .rst(rst), .data_in(receiver_data), 
                      .in_valid(receiver_valid), .addr(in_reg_addr),
                      .data_out(in_reg_data));

    aes_main am1(.clk(clk), .rst(rst), 
                 .key_data(in_reg_data[7]),
                 .encrypt_decrypt(in_reg_data[6]), 
                 .key_length(in_reg_data[5:4]),  
                 .data(in_reg_data[263:8]),
                 .start(aes_start), .result(aes_result), .ready(aes_ready));

    out_register or1(.clk(clk), .rst(rst), .data_in(aes_result), 
                     .in_valid(out_reg_in_valid), .addr(out_reg_addr),
                     .data_out(out_reg_data));

    uart_transmitter ut1(.clk(clk), .rst(rst), 
                         .data_in(out_reg_data),
                         .start(transmit_start), 
                         .serial_out(tx), .ready(transmit_ready));
endmodule