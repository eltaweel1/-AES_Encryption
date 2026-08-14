module SHIFTROWS_tb();
    reg [127 : 0] data_in_tb;
    wire [127 : 0] data_out_after_shifting_tb;

    SHIFTROWS u1(
        .data_in(data_in_tb),
        .data_out_after_shifting(data_out_after_shifting_tb)
    );

    initial begin 
        data_in_tb = 128'hd42711aee0bf98f1b8b45de51e415230;
        #10;
        if(data_out_after_shifting_tb != 128'hd4bf5d30e0b452aeb84111f11e2798e5) begin 
            $display("fail in shifting");
        end 
        else begin 
            $display("shifting pass");
        end 

        $stop;
    end 

endmodule 