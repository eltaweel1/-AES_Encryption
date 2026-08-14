//`define AES_128
//`define AES_192
`define AES_256

`ifdef AES_128 
    `define Nr 10
    `define Nk 4
    `define KEY_BITS 128
`elsif AES_192
    `define Nr 12
    `define Nk 6
    `define KEY_BITS 192
`else 
    `define Nr 14
    `define Nk 8
    `define KEY_BITS 256
`endif 

`define DATA_WIDTH 128

//Electronic Codebook (ECB) 
//Cipher Block Chaining (CBC)
//Cipher FeedBack (CFB)
//Output FeedBack (OFB)
//Counter (CTR) 