module fsm_tb();
    reg clk;
    reg rst;
    reg start;
    wire [3:0] round;
    wire start_state;
    wire final_round;
    wire done;

    fsm u(
        .clk(clk),
        .rst(rst),
        .start(start),
        .round(round),
        .start_state(start_state),
        .final_round(final_round),
        .done(done)
    );
    
    initial begin 
        clk = 0;
        forever begin 
            #5 clk = ~clk;
        end 
    end 

    initial begin
        rst   = 1;
        start = 0;

        //test reset
        rst = 0;
        @(negedge clk);
        rst = 1;


        start = 1;
        @(negedge clk);
        start = 0;

        repeat(14) @(negedge clk);

        @(negedge clk);
        @(negedge clk);


        start = 1;
        @(negedge clk);
        start = 0;

        repeat(14) @(negedge clk);

        $finish;
    end
endmodule