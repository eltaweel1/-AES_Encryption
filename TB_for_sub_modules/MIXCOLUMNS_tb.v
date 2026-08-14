module MIXCOLUMNS_tb();
    reg [127 : 0] data_in_tb;
    wire [127 : 0] data_out_after_mixing_tb;

    MIXCOLUMNS u1(
        .data_in(data_in_tb),
        .data_out_after_mixing(data_out_after_mixing_tb)
    );

    initial begin 
        data_in_tb = 128'hd4bf5d30e0b452aeb84111f11e2798e5;
        #10;
        if(data_out_after_mixing_tb != 128'h046681e5e0cb199a48f8d37a2806264c) begin 
            $display("fail in mixing");
        end 
        else begin 
            $display("mixing pass");
        end 

        $stop;
    end 

endmodule 