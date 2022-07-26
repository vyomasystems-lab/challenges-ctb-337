//Sequential logic state machine pattern recognition

`timescale 1ns /1ps


module FSM_1101(
input clk,
input reset,
input din,
output reg dout,
output reg [2:0] present_state
);

// 4 state of the moore machine
parameter S0=3'b000;      // idle
parameter S1=3'b001;      // pattern detected 1
parameter S2=3'b010;      // pattern detected 11
parameter S3=3'b011;      // pattern detected 110
parameter S4=3'b100;      // pattern detected 1101

    
reg [2:0] next_state;

    // at every positive edge of clock , present state(present_state) is updated 
    always@(posedge clk or posedge reset)
     begin
       if(reset)
        present_state<=S0;
       else
        present_state<=next_state;
       end
	   
	 // Whenever a new input is taken, next state is updated  
	   always@(*)
       begin
        case(present_state)
        S0: if(din==1)
                next_state<=S1;
            else
                next_state<=S0;
         S1: if(din==1)
                next_state<=S2;
              else
                next_state<=S0;
         S2: if(din==0)
                next_state<=S3;
             else
                next_state<=S2;
         S3: if(din==1)
                next_state<=S4;
              else
                next_state<=S0;
         S4: if(din==1)
                next_state<=S1;
             else
                next_state<=S0;
        default:
            next_state<=S0;    
        endcase            
        end

always@(*)
begin
    if(reset)
        dout=0;
    else if(present_state==S4)
        dout=1;
    else
        dout=0;
end

endmodule
