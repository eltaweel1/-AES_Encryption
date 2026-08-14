`include "config.vh"

module Initial_Round(
    input [`DATA_WIDTH - 1 : 0] data_in,
    input [127 : 0] initial_key,
    output [`DATA_WIDTH - 1 : 0] initial_state
);
    assign initial_state = data_in ^ initial_key;
endmodule 