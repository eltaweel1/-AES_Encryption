// round 1
// round1_input = 128'h193de3be_a0f4e22b_9ac68d2a_e9f84808
// round1_key   = 128'ha0fafe17_88542cb1_23a33939_2a6c7605
// expected_out = 128'ha49c7ff2_689f352b_6b5bea43_026a5049

// final round 
// round10_input   = 128'heb40f21e_592e3884_8ba113e7_1bc342d2
// round10_key     = 128'hd014f9a8_c9ee2589_e13f0cc8_b6630ca6
// expected_output = 128'h3925841d_02dc09fb_dc118597_196a0b32

module AES_ROUND_tb();
    reg [127 : 0] state_in_tb;
    reg [127 : 0] round_key_tb;
    reg final_round_tb;
    wire [127 : 0] state_out_tb;

    AES_ROUND u (
        .state_in(state_in_tb),
        .round_key(round_key_tb),
        .final_round(final_round_tb),
        .state_out(state_out_tb)
    );

    initial begin 
        state_in_tb = 128'h193de3be_a0f4e22b_9ac68d2a_e9f84808;
        round_key_tb = 128'ha0fafe17_88542cb1_23a33939_2a6c7605;
        final_round_tb = 0;
        #10;
        if(state_out_tb != 128'ha49c7ff2_689f352b_6b5bea43_026a5049) begin
            $display("fail round");
        end 
        else begin 
            $display("round pass");
        end 
        
        state_in_tb = 128'heb40f21e_592e3884_8ba113e7_1bc342d2;
        round_key_tb = 128'hd014f9a8_c9ee2589_e13f0cc8_b6630ca6;
        final_round_tb = 1;
        #10;
        if(state_out_tb != 128'h3925841d_02dc09fb_dc118597_196a0b32) begin
            $display("fail final round");
        end 
        else begin 
            $display("final round pass");
        end 






        $finish;

    end 

endmodule 