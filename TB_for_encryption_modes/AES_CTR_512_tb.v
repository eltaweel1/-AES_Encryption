`include "config.vh"
//  Counter (CTR)

module AES_CTR_512_tb;
    reg clk_tb; 
    reg rst_tb;
    reg start_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg [127 : 0] iv_tb;
    reg [511 : 0] plain_text_512_tb;
    wire [511 : 0] cipher_text_512_tb;
    wire done_tb;

    reg [511 : 0] expected_cipher_text_512;

    AES_CTR_512 u0 (
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

        iv_tb = 128'hF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF;
        

        // key_input_tb = 128'h2B7E151628AED2A6ABF7158809CF4F3C; //AES128
        // key_input_tb = 192'h8E73B0F7DA0E6452C810F32B809079E562F8EAD2522C6B7B; //AES192
        key_input_tb = 256'h603DEB1015CA71BE2B73AEF0857D7781_1F352C073B6108D72D9810A30914DFF4; //AES256
        
        plain_text_512_tb = 512'h6BC1BEE22E409F96E93D7E117393172A_AE2D8A571E03AC9C9EB76FAC45AF8E51_30C81C46A35CE411E5FBC1191A0A52EF_F69F2445DF4F9B17AD2B417BE66C3710;

        // expected_cipher_text_512 = 512'h874D6191B620E3261BEF6864990DB6CE_9806F66B7970FDFF8617187BB9FFFDFF_5AE4DF3EDBD5D35E5B4F09020DB03EAB_1E031DDA2FBE03D1792170A0F3009CEE; //AES128   
        // expected_cipher_text_512 = 512'h1ABC932417521CA24F2B0459FE7E6E0B_090339EC0AA6FAEFD5CCC2C6F4CE8E94_1E36B26BD1EBC670D1BD1D665620ABF7_4F78A7F6D29809585A97DAEC58C6B050; //AES192
        expected_cipher_text_512 = 512'h601EC313775789A5B7A7F504BBF3D228_F443E3CA4D62B59ACA84E990CACAF5C5_2B0930DAA23DE94CE87017BA2D84988D_DFC9C58DB67AADA613C2DD08457941A6; //AES256

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