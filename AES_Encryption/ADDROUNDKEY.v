`include "config.vh"

module ADDROUNDKEY(
    input [`DATA_WIDTH - 1 : 0] data_in,
    input [127 : 0] key,
    output [`DATA_WIDTH - 1 : 0] data_out
);
    assign data_out = data_in ^ key;
endmodule 