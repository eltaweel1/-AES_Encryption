`include "config.vh"

// state_in     = 128'hd42711aee0bf98f1b8b45de51e415230
// expected_out = 128'hd4bf5d30e0b452aeb84111f11e2798e5

module SHIFTROWS(
    input [`DATA_WIDTH - 1 : 0] data_in,
    output reg [`DATA_WIDTH - 1 : 0] data_out_after_shifting
);
    integer i,j;
    reg [7 : 0] state [4][4];
    reg [7 : 0] shifted_state [4][4];
    
    always @(*) begin 
        for (i = 0; i < 4; i = i+1) begin 
            for (j = 0; j < 4; j = j+1) begin 
                state[i][j] = data_in[128-1-8*(i + 4*j) -: 8];
            end 
        end 


        for (i = 0; i < 4; i = i+1) begin 
            for (j = 0; j < 4; j = j+1) begin 
                shifted_state[i][j] = state[i][(i+j) % 4];
            end 
        end 


        for (i = 0; i < 4; i = i+1) begin 
            for (j = 0; j < 4; j = j+1) begin 
                data_out_after_shifting [128-1-8*(i + 4*j) -: 8] = shifted_state[i][j];
            end 
        end 
    end 
endmodule 