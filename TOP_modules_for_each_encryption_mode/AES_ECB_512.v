`include "config.vh"

module AES_ECB_512(
    input clk,
    input rst,
    input start,
    input [`KEY_BITS - 1 : 0] key_input,
    input [511 : 0] plain_text_512,
    output [511 : 0] cipher_text_512,
    output done
);

    wire [3:0] done_bus;

    TOP block0 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_input(key_input),
        .plain_text(plain_text_512[127:0]),
        .cipher_text(cipher_text_512[127:0]),
        .done(done_bus[0])
    );

    TOP block1 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_input(key_input),
        .plain_text(plain_text_512[255:128]),
        .cipher_text(cipher_text_512[255:128]),
        .done(done_bus[1])
    );

    TOP block2 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_input(key_input),
        .plain_text(plain_text_512[383:256]),
        .cipher_text(cipher_text_512[383:256]),
        .done(done_bus[2])
    );

    TOP block3 (
        .clk(clk),
        .rst(rst),
        .start(start),
        .key_input(key_input),
        .plain_text(plain_text_512[511:384]),
        .cipher_text(cipher_text_512[511:384]),
        .done(done_bus[3])
    );

    assign done = &done_bus;

endmodule