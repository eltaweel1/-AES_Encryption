`include "config.vh"

module TOP(
    input clk, 
    input rst,
    input start,
    input [`KEY_BITS - 1 : 0] key_input,
    input [`DATA_WIDTH - 1 : 0] plain_text,
    output [`DATA_WIDTH - 1 : 0] cipher_text,
    output done
);

    wire [(4*32*(`Nr+1) - 1) : 0] words_top;
    wire [3 : 0] round_key;

    wire start_state_top;
    wire final_round_top;
    wire [127 : 0] key_output;
    wire [127 : 0] initial_state_top;
    wire [127 : 0] round_state_top;

    wire state_enable_top;

    fsm FSM(
        .clk(clk),
        .rst(rst),
        .start(start),

        .round(round_key),
        .start_state(start_state_top),
        .final_round(final_round_top),
        .state_enable(state_enable_top),
        .done(done)
    );

    key_exp expantion (
        .key(key_input),
        .words(words_top)
    );

    round_key round (
        .enable(1'b1),
        .round(round_key), 
        .words(words_top),
        .key(key_output)
    );


    Initial_Round initial_round(
        .data_in(plain_text),
        .initial_key(key_output),
        .initial_state(initial_state_top)
    );

    AES_ROUND rest_of_round (
        .state_in(cipher_text),
        .round_key(key_output),
        .final_round(final_round_top),
        .state_out(round_state_top)
    );

    state_register State_Register(
        .clk(clk),
        .rst(rst),
        .start(start_state_top),
        .enable(state_enable_top),
        .initial_state(initial_state_top),
        .round_state(round_state_top),
        .state_out(cipher_text)
    );

endmodule 