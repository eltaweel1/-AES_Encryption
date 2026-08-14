`include "config.vh"
module key_exp_round_key_top_tb_256();
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg enable_top_tb;
    reg [3 : 0] round_top_tb;
    wire [127 : 0] key_output_tb;


    key_exp_round_key_top u1 (
        .key_input(key_input_tb),
        .enable_top(enable_top_tb),
        .round_top(round_top_tb),
        .key_output(key_output_tb)
    );

    initial begin 
        key_input_tb = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;

        
        // Round 0 (w0, w1, w2, w3)
        $display("________________________________________");
        test(128'h603deb1015ca71be2b73aef0857d7781, 0);
        $display("________________________________________");

        // Round 1 (w4, w5, w6, w7)
        test(128'h1f352c073b6108d72d9810a30914dff4, 1);
        $display("________________________________________");

        // Round 2 (w8, w9, w10, w11)
        test(128'h9ba354118e6925afa51a8b5f2067fcde, 2);
        $display("________________________________________");

        // Round 3 (w12, w13, w14, w15)
        test(128'ha8b09c1a93d194cdbe49846eb75d5b9a, 3);
        $display("________________________________________");

        // Round 4 (w16, w17, w18, w19)
        test(128'hd59aecb85bf3c917fee94248de8ebe96, 4);
        $display("________________________________________");

        // Round 5 (w20, w21, w22, w23)
        test(128'hb5a9328a2678a647983122292f6c79b3, 5);
        $display("________________________________________");

        // Round 6 (w24, w25, w26, w27)
        test(128'h812c81addadf48ba24360af2fab8b464, 6);
        $display("________________________________________");

        // Round 7 (w28, w29, w30, w31)
        test(128'h98c5bfc9bebd198e268c3ba709e04214, 7);
        $display("________________________________________");

        // Round 8 (w32, w33, w34, w35)
        test(128'h68007bacb2df331696e939e46c518d80, 8);
        $display("________________________________________");

        // Round 9 (w36, w37, w38, w39)
        test(128'hc814e20476a9fb8a5025c02d59c58239, 9);
        $display("________________________________________");

        // Round 10 (w40, w41, w42, w43)
        test(128'hde1369676ccc5a71fa2563959674ee15, 10);
        $display("________________________________________");

        // Round 11 (w44, w45, w46, w47)
        test(128'h5886ca5d2e2f31d77e0af1fa27cf73c3, 11);
        $display("________________________________________");

        // Round 12 (w48, w49, w50, w51)
        test(128'h749c47ab18501ddae2757e4f7401905a, 12);
        $display("________________________________________");

        // Round 13 (w52, w53, w54, w55)
        test(128'hcafaaae3e4d59b349adf6acebd10190d, 13);
        $display("________________________________________");

        // Round 14 (w56, w57, w58, w59)
        test(128'hfe4890d1e6188d0b046df344706c631e, 14);
        $display("________________________________________");
        
        $stop;

    end

    task test (input [127 : 0] in, input [3 : 0] round);
        begin 
            enable_top_tb = 1;
            round_top_tb = round;
            #5;
            if(key_output_tb != in) begin 
                $display("Fail round %0d", round);
                $display("%0h",key_output_tb);
            end 
            else begin 
                $display("round %0d pass", round);
                $display("%0h",key_output_tb);
            end 
            #5;
        end 
    endtask
endmodule 