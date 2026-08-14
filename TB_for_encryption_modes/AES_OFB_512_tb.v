`include "config.vh"
// Output FeedBack (OFB) 

module AES_OFB_512_tb;
    reg clk_tb; 
    reg rst_tb;
    reg start_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg [127 : 0] iv_tb;
    reg [511 : 0] plain_text_512_tb;
    wire [511 : 0] cipher_text_512_tb;
    wire done_tb;

    reg [511 : 0] expected_cipher_text_512;

    AES_OFB_512 u0 (
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

        // expected_cipher_text_512 = 512'h3B3FD92EB72DAD20333449F8E83CFB4A_7789508D16918F03F53C52DAC54ED825_9740051E9C5FECF64344F7A82260EDCC_304C6528F659C77866A510D9C1D6AE5E; //AES128 
        // expected_cipher_text_512 = 512'hCDC80D6FDDF18CAB34C25909C99A4174_FCC28B8D4C63837C09E81700C1100401_8D9A9AEAC0F6596F559C6D4DAF59A5F2_6D9F200857CA6C3E9CAC524BD9ACC92A; //AES192
        expected_cipher_text_512 = 512'hDC7E84BFDA79164B7ECD8486985D3860_4FEBDC6740D20B3AC88F6AD82A4FB08D_71AB47A086E86EEDF39D1C5BBA97C408_0126141D67F37BE8538F5A8BE740E484; //AES256
            
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