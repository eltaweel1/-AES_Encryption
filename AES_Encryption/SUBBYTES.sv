`include "config.vh"

module SUBBYTES(
    input  [`DATA_WIDTH - 1 : 0] data_in,
    output [`DATA_WIDTH - 1 : 0] data_out
);
    genvar i;
    generate 
        for (i = 0; i < 16; i = i+1) begin 
            sbox u (.data_in(data_in[i*8 +: 8]), .data_out(data_out[i*8 +: 8]));
        end 
    endgenerate 
    

    // sbox u0 (.data_in(data_in[7  :  0]), .data_out(data_out[7  :  0]));
    // sbox u1 (.data_in(data_in[15 :  8]), .data_out(data_out[15 :  8]));
    // sbox u2 (.data_in(data_in[23 : 16]), .data_out(data_out[23 : 16]));
    // sbox u3 (.data_in(data_in[31 : 24]), .data_out(data_out[31 : 24]));

    // sbox u4 (.data_in(data_in[39  :  32]), .data_out(data_out[39  :  32]));
    // sbox u5 (.data_in(data_in[47  :  40]), .data_out(data_out[47  :  40]));
    // sbox u6 (.data_in(data_in[55  :  48]), .data_out(data_out[55  :  48]));
    // sbox u7 (.data_in(data_in[63  :  56]), .data_out(data_out[63  :  56]));

    // sbox u8  (.data_in(data_in[71  :  64]), .data_out(data_out[71  :  64]));
    // sbox u9  (.data_in(data_in[79  :  72]), .data_out(data_out[79  :  72]));
    // sbox u10 (.data_in(data_in[87  :  80]), .data_out(data_out[87  :  80]));
    // sbox u11 (.data_in(data_in[95  :  88]), .data_out(data_out[95  :  88]));

    // sbox u12 (.data_in(data_in[103 :  96]), .data_out(data_out[103 :  96]));
    // sbox u13 (.data_in(data_in[111 : 104]), .data_out(data_out[111 : 104]));
    // sbox u14 (.data_in(data_in[119 : 112]), .data_out(data_out[119 : 112]));
    // sbox u15 (.data_in(data_in[127 : 120]), .data_out(data_out[127 : 120]));

endmodule 