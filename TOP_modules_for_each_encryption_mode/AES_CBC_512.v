`include "config.vh"

module AES_CBC_512 (
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

    wire [127:0] block0_in;
    wire [127:0] block1_in;
    wire [127:0] block2_in;
    wire [127:0] block3_in;

    assign block0_in = plain_text_512[511:384] ^ iv;

    TOP block0 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_input(key_input),
        .plain_text(block0_in),
        .cipher_text(cipher_text_512[511:384]),
        .done(done_bus[0])
    );

    assign block1_in = plain_text_512[383:256] ^ cipher_text_512[511:384];

    TOP block1 (
        .clk(clk),
        .rst(rst),
        .start(done_bus[0]),
        .key_input(key_input),
        .plain_text(block1_in),
        .cipher_text(cipher_text_512[383:256]),
        .done(done_bus[1])
    );

    assign block2_in = plain_text_512[255:128] ^ cipher_text_512[383:256];

    TOP block2 (
        .clk(clk),
        .rst(rst),
        .start(done_bus[1]),
        .key_input(key_input),
        .plain_text(block2_in),
        .cipher_text(cipher_text_512[255:128]),
        .done(done_bus[2])
    );

    assign block3_in = plain_text_512[127:0] ^ cipher_text_512[255:128];

    TOP block3 (
        .clk(clk),
        .rst(rst),
        .start(done_bus[2]),
        .key_input(key_input),
        .plain_text(block3_in),
        .cipher_text(cipher_text_512[127:0]),
        .done(done_bus[3])
    );

    assign done = done_bus[3];
endmodule