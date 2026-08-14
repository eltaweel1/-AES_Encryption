`include "config.vh"

module fsm (
    input clk,
    input rst,
    input start,
    
    output reg [3 : 0] round,
    output reg start_state,
    output reg final_round,
    output reg state_enable,
    output reg done
);

    localparam IDLE    = 2'b00;
    localparam INITIAL = 2'b01;
    localparam ROUNDS  = 2'b10;
    localparam DONE    = 2'b11;

    reg [1 : 0] cs, ns;
    reg [3:0] round_counter;

    //state memory
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            cs <= IDLE;
        end 
        else begin
            cs <= ns;
        end
    end

    //next state logic
    always @(*) begin
        case (cs)
            IDLE    : begin
                if(start) begin 
                    ns = INITIAL;
                end 
                else begin 
                    ns = IDLE;
                end 
            end
            INITIAL : begin
                ns = ROUNDS;
            end
            ROUNDS  : begin
                if (round == `Nr) begin
                    ns = DONE;
                end
                else begin
                    ns = ROUNDS;
                end 
            end
            DONE    : begin 
                ns = IDLE;
            end 
            default : begin
                ns = IDLE;
            end
        endcase
    end

    // // //output
    // always @(posedge clk or negedge rst) begin
    //     if (~rst) begin
    //         round       <= 4'd0;
    //         start_state <= 1'b0;
    //         final_round <= 1'b0;
    //         done        <= 1'b0;
    //     end 
    //     else begin
    //         case (ns)
    //             IDLE: begin
    //                 round       <= 4'd0;
    //                 start_state <= 1'b0;
    //                 final_round <= 1'b0;
    //                 done        <= 1'b0;
    //             end
    //             INITIAL: begin
    //                 round       <= 4'd0;
    //                 start_state <= 1'b1;
    //                 final_round <= 1'b0;
    //                 done        <= 1'b0;
    //             end
    //             ROUNDS: begin
    //                 round       <= round + 1'b1;
    //                 start_state <= 1'b0;
    //                 done        <= 1'b0;
    //                 if (round == (`Nr - 1)) begin
    //                     final_round <= 1'b1;
    //                 end 
    //                 else begin
    //                     final_round <= 1'b0;
    //                 end
    //             end
    //             DONE: begin
    //                 round       <= 4'd0;
    //                 start_state <= 1'b0;
    //                 final_round <= 1'b0;
    //                 done        <= 1'b1;
    //             end
    //             default: begin
    //                 round       <= 4'd0;
    //                 start_state <= 1'b0;
    //                 final_round <= 1'b0;
    //                 done        <= 1'b0;
    //             end
    //         endcase
    //     end
    // end

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            round_counter <= 4'd0;
        end
        else begin
            case (cs)
                IDLE: begin
                    round_counter <= 4'd0;
                end
                INITIAL: begin
                    round_counter <= 4'd1;
                end
                ROUNDS: begin
                    if (round_counter < `Nr) begin 
                        round_counter <= round_counter + 1'b1;
                    end 
                end
                DONE: begin
                    round_counter <= 4'd0;
                end
                default: begin
                    round_counter <= 4'd0;
                end
            endcase
        end
    end 

    always @(*) begin
        case (cs)
            IDLE: begin
                round       = 4'd0;
                start_state = 1'b0;
                final_round = 1'b0;
                done        = 1'b0;
                state_enable = 1'b0;
            end
            INITIAL: begin
                round       = 4'd0;
                start_state = 1'b1;
                final_round = 1'b0;
                done        = 1'b0;
                state_enable = 1'b0;
            end
            ROUNDS: begin
                round       = round_counter;
                start_state = 1'b0;
                done        = 1'b0;
                state_enable = 1'b1;

                if (round_counter == `Nr) begin
                    final_round = 1'b1;
                end 
                else begin
                    final_round = 1'b0;
                end      
            end
            DONE: begin
                round       = 4'd0;
                start_state = 1'b0;
                final_round = 1'b0;
                done        = 1'b1;
                state_enable = 1'b0;
            end
            default: begin
                round       = 4'd0;
                start_state = 1'b0;
                final_round = 1'b0;
                done        = 1'b0;
                state_enable = 1'b0;
            end
        endcase
    end

endmodule