`include "config.vh"
module key_exp_round_key_top_tb_192();
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
        key_input_tb = 192'h8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b;

        // Round 0 (w0, w1, w2, w3)
        $display("________________________________________");
        test(128'h8e73b0f7da0e6452c810f32b809079e5, 0);
        $display("________________________________________");

        // Round 1 (w4, w5, w6, w7)
        test(128'h62f8ead2522c6b7bfe0c91f72402f5a5, 1);
        $display("________________________________________");

        // Round 2 (w8, w9, w10, w11)
        test(128'hec12068e6c827f6b0e7a95b95c56fec2, 2);
        $display("________________________________________");

        // Round 3 (w12, w13, w14, w15)
        test(128'h4db7b4bd69b5411885a74796e92538fd, 3);
        $display("________________________________________");

        // Round 4 (w16, w17, w18, w19)
        test(128'he75fad4abb095386485af05721efb14f, 4);
        $display("________________________________________");

        // Round 5 (w20, w21, w22, w23)
        test(128'ha448f6d94d6dce24aa326360113b30e6, 5);
        $display("________________________________________");

        // Round 6 (w24, w25, w26, w27)
        test(128'ha25e7ed583b1cf9a27f939436a94f767, 6);
        $display("________________________________________");

        // Round 7 (w28, w29, w30, w31)
        test(128'hc0a69407d19da4e1ec1786eb6fa64971, 7);
        $display("________________________________________");

        // Round 8 (w32, w33, w34, w35)
        test(128'h485f703222cb8755e26d135233f0b7b3, 8);
        $display("________________________________________");

        // Round 9 (w36, w37, w38, w39)
        test(128'h40beeb282f18a2596747d26b458c553e, 9);
        $display("________________________________________");

        // Round 10 (w40, w41, w42, w43)
        test(128'ha7e1466c9411f1df821f750aad07d753, 10);
        $display("________________________________________");

        // Round 11 (w44, w45, w46, w47)
        test(128'hca4005388fcc5006282d166abc3ce7b5, 11);
        $display("________________________________________");
        
        // Round 12 (w48, w49, w50, w51)
        test(128'he98ba06f448c773c8ecc720401002202, 12);
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