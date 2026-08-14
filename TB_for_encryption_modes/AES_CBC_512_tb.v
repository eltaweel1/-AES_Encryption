`include "config.vh"
//Cipher Block Chaining (CBC)

module AES_CBC_512_tb;
    reg clk_tb; 
    reg rst_tb;
    reg start_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg [127 : 0] iv_tb;
    reg [511 : 0] plain_text_512_tb;
    wire [511 : 0] cipher_text_512_tb;
    wire done_tb;

    reg [511 : 0] expected_cipher_text_512;

    AES_CBC_512 u0 (
        .clk(clk_tb),
        .rst(rst_tb),
        .start(start_tb),
        .key_input(key_input_tb),
        .iv(iv_tb),
        .plain_text_512(plain_text_512_tb),
        .cipher_text_512(cipher_text_512_tb),
        .done(done_tb)
    );

    initial begin 
        clk_tb = 0;
        forever begin 
            #5 clk_tb = ~clk_tb;
        end 
    end 
    initial begin 
        expected_cipher_text_512 = 0;
        rst_tb = 1;
        start_tb = 0;
        key_input_tb = 0;
        iv_tb = 0;
        plain_text_512_tb = 0;

        // test reset 
        rst_tb = 0;
        @(negedge clk_tb);
        rst_tb = 1;
        if((cipher_text_512_tb != 0) || done_tb != 0) begin 
            $display("fail reset");
        end
        else begin 
            $display("reset pass");
        end 

        iv_tb = 128'h000102030405060708090A0B0C0D0E0F;

        // key_input_tb = 128'h2B7E151628AED2A6ABF7158809CF4F3C; //AES128
        // key_input_tb = 192'h8E73B0F7DA0E6452C810F32B809079E562F8EAD2522C6B7B; //AES192
        key_input_tb = 256'h603DEB1015CA71BE2B73AEF0857D7781_1F352C073B6108D72D9810A30914DFF4; //AES256
        
        plain_text_512_tb = 512'h6BC1BEE22E409F96E93D7E117393172A_AE2D8A571E03AC9C9EB76FAC45AF8E51_30C81C46A35CE411E5FBC1191A0A52EF_F69F2445DF4F9B17AD2B417BE66C3710;

        // expected_cipher_text_512 = 512'h7649ABAC8119B246CEE98E9B12E9197D_5086CB9B507219EE95DB113A917678B2_73BED6B8E3C1743B7116E69E22229516_3FF1CAA1681FAC09120ECA307586E1A7; //AES128
        // expected_cipher_text_512 = 512'h4F021DB243BC633D7178183A9FA071E8_B4D9ADA9AD7DEDF4E5E738763F69145A_571B242012FB7AE07FA9BAAC3DF102E0_08B0E27988598881D920A9E64F5615CD; //AES192
        expected_cipher_text_512 = 512'hF58C4C04D6E5F1BA779EABFB5F7BFBD6_9CFC4E967EDB808D679F777BC6702C7D_39F23369A9D9BACFA530E26304231461_B2EB05E2C39BE9FCDA6C19078C6A9D1B; //AES256
          
        start_tb = 1;
        @(negedge clk_tb);
        start_tb = 0;

        wait(done_tb == 1'b1);
        if(cipher_text_512_tb != expected_cipher_text_512) begin 
            $display("fail cipher_text");
        end 
        else begin 
            $display("cipher_text pass");
        end 
         
        $display("Full Ciphertext = %h", cipher_text_512_tb);

        @(negedge clk_tb);
        @(negedge clk_tb);
        $stop;
    end
endmodule