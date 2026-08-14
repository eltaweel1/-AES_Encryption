`include "config.vh"

module AES_CFB_512 (
    input clk,
    input rst,
    input start,
    input [`KEY_BITS - 1 : 0] key_input,
    input [127 : 0] iv,
    input [511 : 0] plain_text_512,
    output [511 : 0] cipher_text_512,
    output done
);

    wire [3:0] done_bus;

    wire [127:0] block0_out;
    wire [127:0] block1_out;
    wire [127:0] block2_out;
    wire [127:0] block3_out;


    TOP block0 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_input(key_input),
        .plain_text(iv),
        .cipher_text(block0_out),
        .done(done_bus[0])
    );

    assign cipher_text_512[511:384] = plain_text_512[511:384] ^ block0_out;

    TOP block1 (
        .clk(clk),
        .rst(rst),
        .start(done_bus[0]),
        .key_input(key_input),
        .plain_text(cipher_text_512[511:384]),
        .cipher_text(block1_out),
        .done(done_bus[1])
    );

    assign cipher_text_512[383:256] = plain_text_512[383:256] ^ block1_out;

    TOP block2 (
        .clk(clk),
        .rst(rst),
        .start(done_bus[1]),
        .key_input(key_input),
        .plain_text(cipher_text_512[383:256]),
        .cipher_text(block2_out),
        .done(done_bus[2])
    );

    assign cipher_text_512[255:128] = plain_text_512[255:128] ^ block2_out;

    TOP block3 (
        .clk(clk),
        .rst(rst),
        .start(done_bus[2]),
        .key_input(key_input),
        .plain_text(cipher_text_512[255:128]),
        .cipher_text(block3_out),
        .done(done_bus[3])
    );

    assign cipher_text_512[127:0] = plain_text_512[127:0] ^ block3_out;

    assign done = done_bus[3];
endmodule