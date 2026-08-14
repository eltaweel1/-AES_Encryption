`include "config.vh"

module round_key(
    input enable,
    input [3 : 0] round, 
    input [(4*32*(`Nr+1) - 1) : 0] words,
    output reg [127 : 0] key
);


    always @(*) begin 
                if(enable) begin
                    // key = words[`KEY_BITS*round +: `KEY_BITS];
                    key = {
                        words[128*round + 0  +: 32],
                        words[128*round + 32 +: 32],
                        words[128*round + 64 +: 32],
                        words[128*round + 96 +: 32]
                    };
                end 
                else begin 
                    key = 0;
                end 
            end 
endmodule 