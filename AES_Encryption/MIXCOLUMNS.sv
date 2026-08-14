`include "config.vh"

//state_in     = 128'hd4bf5d30e0b452aeb84111f11e2798e5
//expected_out = 128'h046681e5e0cb199a48f8d37a2806264c

module MIXCOLUMNS(
    input [`DATA_WIDTH - 1 : 0] data_in,
    output reg [`DATA_WIDTH - 1 : 0] data_out_after_mixing
);
    integer i,j;
    reg [7 : 0] state [4][4];
    reg [7 : 0] mixed_state [4][4];

    always @(*) begin 
        for (i = 0; i < 4; i = i+1) begin 
            for (j = 0; j < 4; j = j+1) begin 
                state[i][j] = data_in[128-1-8*(i + 4*j) -: 8];
            end 
        end

        mixed_state[0][0] = XTIMES(state[0][0]) ^ ((XTIMES(state[1][0])) ^ state[1][0]) ^ state[2][0] ^ state[3][0];
        mixed_state[1][0] = state[0][0] ^ XTIMES(state[1][0]) ^ ((XTIMES(state[2][0])) ^ state[2][0]) ^ state[3][0];
        mixed_state[2][0] = state[0][0] ^ state[1][0] ^ XTIMES(state[2][0]) ^ ((XTIMES(state[3][0])) ^ state[3][0]);
        mixed_state[3][0] = ((XTIMES(state[0][0])) ^ state[0][0]) ^ state[1][0] ^ state[2][0] ^ XTIMES(state[3][0]);

        mixed_state[0][1] = XTIMES(state[0][1]) ^ ((XTIMES(state[1][1])) ^ state[1][1]) ^ state[2][1] ^ state[3][1];
        mixed_state[1][1] = state[0][1] ^ XTIMES(state[1][1]) ^ ((XTIMES(state[2][1])) ^ state[2][1]) ^ state[3][1];
        mixed_state[2][1] = state[0][1] ^ state[1][1] ^ XTIMES(state[2][1]) ^ ((XTIMES(state[3][1])) ^ state[3][1]);
        mixed_state[3][1] = ((XTIMES(state[0][1])) ^ state[0][1]) ^ state[1][1] ^ state[2][1] ^ XTIMES(state[3][1]);

        mixed_state[0][2] = XTIMES(state[0][2]) ^ ((XTIMES(state[1][2])) ^ state[1][2]) ^ state[2][2] ^ state[3][2];
        mixed_state[1][2] = state[0][2] ^ XTIMES(state[1][2]) ^ ((XTIMES(state[2][2])) ^ state[2][2]) ^ state[3][2];
        mixed_state[2][2] = state[0][2] ^ state[1][2] ^ XTIMES(state[2][2]) ^ ((XTIMES(state[3][2])) ^ state[3][2]);
        mixed_state[3][2] = ((XTIMES(state[0][2])) ^ state[0][2]) ^ state[1][2] ^ state[2][2] ^ XTIMES(state[3][2]);

        mixed_state[0][3] = XTIMES(state[0][3]) ^ ((XTIMES(state[1][3])) ^ state[1][3]) ^ state[2][3] ^ state[3][3];
        mixed_state[1][3] = state[0][3] ^ XTIMES(state[1][3]) ^ ((XTIMES(state[2][3])) ^ state[2][3]) ^ state[3][3];
        mixed_state[2][3] = state[0][3] ^ state[1][3] ^ XTIMES(state[2][3]) ^ ((XTIMES(state[3][3])) ^ state[3][3]);
        mixed_state[3][3] = ((XTIMES(state[0][3])) ^ state[0][3]) ^ state[1][3] ^ state[2][3] ^ XTIMES(state[3][3]);

        for (i = 0; i < 4; i = i+1) begin 
            for (j = 0; j < 4; j = j+1) begin 
                data_out_after_mixing [128-1-8*(i + 4*j) -: 8] = mixed_state[i][j];
            end 
        end 
    end 

    function [7 : 0] XTIMES;
    input [7 : 0] b;
        begin 
            if(b[7] == 1'b0) begin 
                XTIMES = {b[6 : 0], 1'b0}; //{b6 b5 b4 b3 b2 b1 b0 0} if b7 = 0 
            end 
            else begin 
                XTIMES = {b[6 : 0], 1'b0} ^ 8'h1b; //{b6 b5 b4 b3 b2 b1 b0 0}⊕{0 0 0 1 1 0 1 1} if b7 = 1.
            end 
        end 
    endfunction

endmodule 