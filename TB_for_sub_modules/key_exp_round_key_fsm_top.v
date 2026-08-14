`include "config.vh"

module key_exp_round_key_fsm_top(
    input clk,
    input rst,
    input [`KEY_BITS - 1 : 0] key_input,
    output [127 : 0] key_output
);
    wire enable_top;
    wire [3 : 0] round_top;
    wire [(4*32*(`Nr+1) - 1) : 0] words_top;

    fsm FSM(
        .clk(clk),
        .rst(rst),
        .key(key_output),
        .round(round_top),
        .EN_ADDROUNDKEY(enable_top)
    );

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