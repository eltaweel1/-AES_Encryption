`include "config.vh"
//Electronic Codebook (ECB) 

module AES_ECB_512_tb;
    reg clk_tb; 
    reg rst_tb;
    reg start_tb;
    reg [`KEY_BITS - 1 : 0] key_input_tb;
    reg [511 : 0] plain_text_512_tb;
    wire [511 : 0] cipher_text_512_tb;
    wire done_tb;

    reg [511 : 0] expected_cipher_text_512;

    AES_ECB_512 u0 (
        .clk(clk_tb),
        .rst(rst_tb),
        .start(start_tb),
        .key_input(key_input_tb),
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


        // key_input_tb = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c; //AES128
        // key_input_tb = 192'h8E73B0F7DA0E6452C810F32B809079E562F8EAD2522C6B7B; //AES192
        key_input_tb = 256'h603DEB1015CA71BE2B73AEF0857D7781_1F352C073B6108D72D9810A30914DFF4; //AES256
        
         
        plain_text_512_tb = 512'h6BC1BEE22E409F96E93D7E117393172A_AE2D8A571E03AC9C9EB76FAC45AF8E51_30C81C46A35CE411E5FBC1191A0A52EF_F69F2445DF4F9B17AD2B417BE66C3710;

        // expected_cipher_text_512 = 512'h3AD77BB40D7A3660A89ECAF32466EF97_F5D3D58503B9699DE785895A96FDBAAF_43B1CD7F598ECE23881B00E3ED030688_7B0C785E27E8AD3F8223207104725DD4; //AES128
        // expected_cipher_text_512 = 512'hBD334F1D6E45F25FF712A214571FA5CC_974104846D0AD3AD7734ECB3ECEE4EEF_EF7AFD2270E2E60ADCE0BA2FACE6444E_9A4B41BA738D6C72FB16691603C18E0E; //AES192
        expected_cipher_text_512 = 512'hF3EED1BDB5D2A03C064B5A7E3DB181F8_591CCB10D410ED26DC5BA74A31362870_B6ED21B99CA6F4F9F153E7B1BEAFED1D_23304B7A39F9F3FF067D8D8F9E24ECC7; //AES256
          
         
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