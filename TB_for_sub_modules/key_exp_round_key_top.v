`include "config.vh"
module key_exp_round_key_top(
    input [`KEY_BITS - 1 : 0] key_input,
    input enable_top,
    input [3 : 0] round_top,
    output [127 : 0] key_output
);
    wire [(4*32*(`Nr+1) - 1) : 0] words_top;
    key_exp expantion (
        .key(key_input),
        .words(words_top)
    );

    round_key round (
        .enable(enable_top),
        .round(round_top), 
        .words(words_top),
        .key(key_output)
    );
endmodule 