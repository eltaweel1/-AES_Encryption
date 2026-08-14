`include "config.vh"

module TOP_tb;
    reg clk_tb; 
    reg rst_tb;
    reg start_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg [`DATA_WIDTH - 1 : 0] plain_text_tb;
    wire  [`DATA_WIDTH - 1 : 0] cipher_text_tb;
    wire done_tb;
    reg  [`DATA_WIDTH - 1 : 0] expected_cipher_text;

    TOP u1 (
        .clk(clk_tb), 
        .rst(rst_tb),
        .start(start_tb),
        .key_input(key_input_tb),
        .plain_text(plain_text_tb),
        .cipher_text(cipher_text_tb),
        .done(done_tb)
    );


    initial begin 
        clk_tb = 0;
        forever begin 
            #5 clk_tb = ~clk_tb;
        end 
    end 

    initial begin 
        rst_tb = 1;
        start_tb = 0;
        key_input_tb = 0;
        plain_text_tb = 0;
        expected_cipher_text = 0;

        //teset reset
        rst_tb = 0;
        @(negedge clk_tb);
        rst_tb = 1;
        if((cipher_text_tb != 0) || done_tb != 0) begin 
            $display("fail reset");
        end
        else begin 
            $display("reset pass");
        end 

        //test encryption 
        key_input_tb  = 128'h2B7E151628AED2A6ABF7158809CF4F3C;
        // key_input_tb  = 192'h8E73B0F7DA0E6452C810F32B809079E562F8EAD2522C6B7B;
        // key_input_tb  = 256'h603DEB1015CA71BE2B73AEF0857D77811F352C073B6108D72D9810A30914DFF4;
          
        plain_text_tb        = 128'h3243f6a8885a308d313198a2e0370734;

        expected_cipher_text = 128'h3925841d02dc09fbdc118597196a0b32;
        
        start_tb = 1;
        @(negedge clk_tb);
        start_tb = 0;


        wait(done_tb == 1'b1);
        if(cipher_text_tb != expected_cipher_text) begin 
            $display("fail cipher_text");
        end 
        else begin 
            $display("cipher_text pass");
        end 
         
        $display("Full Ciphertext = %h", cipher_text_tb);

        @(negedge clk_tb);
        @(negedge clk_tb);
        @(negedge clk_tb);
        @(negedge clk_tb);
        @(negedge clk_tb);
        @(negedge clk_tb);

        


        // repeat(12) begin
        //     $display(
        //         "time=%0t | round=%0d | start_state=%b | final_round=%b | done=%b | cipher=%h",
        //         $time,
        //         u1.FSM.round,
        //         u1.FSM.start_state,
        //         u1.FSM.final_round,
        //         done_tb,
        //         cipher_text_tb
        //     );
        //     @(negedge clk_tb);
        // end
        


        $stop;
    end 

    always @(negedge clk_tb) begin
    $display(
        "time=%0t | cs=%0d | round_counter=%0d | round=%0d | start_state=%b | final=%b | done=%b | cipher=%h",
        $time,
        u1.FSM.cs,
        u1.FSM.round_counter,
        u1.FSM.round,
        u1.FSM.start_state,
        u1.FSM.final_round,
        u1.FSM.done,
        cipher_text_tb
    );
end



endmodule