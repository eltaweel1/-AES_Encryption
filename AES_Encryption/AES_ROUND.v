`include "config.vh"

module AES_ROUND(
    input [`DATA_WIDTH - 1 : 0] state_in,
    input [127 : 0] round_key,
    input final_round,
    output [`DATA_WIDTH - 1 : 0] state_out
);
// if(final_round == 0) state_in - > SubBytes -> ShiftRows -> MixColumns  -> AddRoundKey -> state_out                                                   
// if(final_round == 1) state_in - > SubBytes -> ShiftRows ->                AddRoundKey -> state_out

    wire [127 : 0] after_sub;
    wire [127 : 0] after_shift;
    wire [127 : 0] after_mix;
    wire [127 : 0] after_mix_or_bypass;

    
    SUBBYTES sub_bytes(
        .data_in(state_in),
        .data_out(after_sub)
    );

    
    SHIFTROWS shift_rows(
        .data_in(after_sub),
        .data_out_after_shifting(after_shift)
    );

    
    MIXCOLUMNS mix_columns(
        .data_in(after_shift),
        .data_out_after_mixing(after_mix)
    );

    assign after_mix_or_bypass = (final_round) ? after_shift : after_mix;


    ADDROUNDKEY add_round_key(
        .data_in(after_mix_or_bypass),
        .key(round_key),
        .data_out(state_out)
    );


endmodule 