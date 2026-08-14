`include "config.vh"

module key_exp_round_key_fsm_top_tb();
    reg clk_tb;
    reg rst_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    wire [127 : 0] key_output_tb;

    key_exp_round_key_fsm_top u1(
        .clk(clk_tb),
        .rst(rst_tb),
        .key_input(key_input_tb),
        .key_output(key_output_tb)
    );

    initial begin 
        clk_tb = 0;
        forever begin 
            #5 clk_tb = ~clk_tb;
        end 
    end 

    initial begin 
        key_input_tb = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        rst_tb = 1;

        //test rst
        rst_tb = 0;
        @(negedge clk_tb);
        rst_tb = 1;
        if(key_output_tb != 0) begin 
            $display("fail reset");
        end 
        else begin 
            $display("pass reset");
        end 

        $display("________________________________________");
        test (128'h2b7e151628aed2a6abf7158809cf4f3c, 0);
        $display("________________________________________");
        test (128'ha0fafe1788542cb123a339392a6c7605, 1);
        $display("________________________________________");
        test (128'hf2c295f27a96b9435935807a7359f67f, 2);
        $display("________________________________________");
        test (128'h3d80477d4716fe3e1e237e446d7a883b, 3);
        $display("________________________________________");
        test (128'hef44a541a8525b7fb671253bdb0bad00, 4);
        $display("________________________________________");
        test (128'hd4d1c6f87c839d87caf2b8bc11f915bc, 5);
        $display("________________________________________");
        test (128'h6d88a37a110b3efddbf98641ca0093fd, 6);
        $display("________________________________________");
        test (128'h4e54f70e5f5fc9f384a64fb24ea6dc4f, 7);
        $display("________________________________________");
        test (128'head27321b58dbad2312bf5607f8d292f, 8);
        $display("________________________________________");
        test (128'hac7766f319fadc2128d12941575c006e, 9);
        $display("________________________________________");
        test (128'hd014f9a8c9ee2589e13f0cc8b6630ca6, 10);
        $display("________________________________________");
        @(negedge clk_tb);



        $stop;
    end 


    task test (input [127 : 0] in, input [3 : 0] round);
        begin 
            @(negedge clk_tb);
            if(key_output_tb != in) begin 
                $display("Fail round %0d", round);
                $display("%0h",key_output_tb);
            end 
            else begin 
                $display("round %0d pass", round);
                $display("%0h",key_output_tb);
            end 
        end 
    endtask
endmodule 