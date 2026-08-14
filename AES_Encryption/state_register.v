`include "config.vh"

module state_register(
    input clk,
    input rst,
    input start,
    input enable,
    input [`DATA_WIDTH - 1 : 0] initial_state,
    input [`DATA_WIDTH - 1 : 0] round_state,
    output reg [`DATA_WIDTH - 1 : 0] state_out
);

    always @(posedge clk or negedge rst) begin 
        if(~rst) begin 
            state_out <= 0;
        end 
        else begin 
            if(start) begin 
                state_out <= initial_state;
            end 
            else if(enable) begin 
                state_out <= round_state;
            end 
        end 
    end 
endmodule 