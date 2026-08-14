`include "config.vh"
//  Cipher FeedBack (CFB)

module AES_CFB_512_tb;
    reg clk_tb; 
    reg rst_tb;
    reg start_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg [127 : 0] iv_tb;
    reg [511 : 0] plain_text_512_tb;
    wire [511 : 0] cipher_text_512_tb;
    wire done_tb;

    reg [511 : 0] expected_cipher_text_512;

    AES_CFB_512 u0 (
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

        // expected_cipher_text_512 = 512'h3B3FD92EB72DAD20333449F8E83CFB4A_C8A64537A0B3A93FCDE3CDAD9F1CE58B_26751F67A3CBB140B1808CF187A4F4DF_C04B05357C5D1C0EEAC4C66F9FF7F2E6; //AES128 
        // expected_cipher_text_512 = 512'hCDC80D6FDDF18CAB34C25909C99A4174_67CE7F7F81173621961A2B70171D3D7A_2E1E8A1DD59B88B1C8E60FED1EFAC4C9_C05F9F9CA9834FA042AE8FBA584B09FF; //AES192
        expected_cipher_text_512 = 512'hDC7E84BFDA79164B7ECD8486985D3860_39FFED143B28B1C832113C6331E5407B_DF10132415E54B92A13ED0A8267AE2F9_75A385741AB9CEF82031623D55B1E471; //AES256
           
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