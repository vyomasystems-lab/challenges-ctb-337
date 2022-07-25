# challenges-ctb-337
challenges-ctb-337 created by GitHub Classroom

*Verification Environment:*
The cocoTb based python test is developed and tests for verification of bug and making the code bug free. 




*LEVEL_1_DESIGN_1*
The designn 1 consists of Mux with 31 inputs and 5 select bits and 2 output bits to choose and represent the output respectively.

*Test Scenario 1:*
Test inputs: 5'b11110
Expected output : out = inp30;
Observed Output:  out = 0;
Output mismatches for the above inputs proving that there is a design bug.

*Test Scenario 2:*
Test inputs: 5'b01101
Expected output : out = inp13 
Observed Output:  out = ip12 , inp13 or one might override other or throws an error.
Output mismatches for the above inputs proving that there is a design bug.

*Test Scenario 3:*
Test inputs: 5'b01100
Expected output : out = inp12
Observed Output:  out = 0;
Output mismatches for the above inputs proving that there is a design bug.


*DESIGN BUG*
The designn 2 consists of a sequence detector 1011 with inputs as inp_bit,reset,clk and the output as seq_seen with overlap.


*Test Scenario 1:*
Test Inputs: assign seq_seen = current_state == SEQ_1011 ? 1 : 0;
Expected Output : out = 1 if sequence comes out to be same and 0 if not
Observed Output:  out = error due to assigning value of seq_seen to current_state
Output mismatches for the above inputs proving that there is a design bug.

*Test Scenario 2:*
Test inputs : (inp_bit == 1); after SEQ_1011:
Expected Output : next_state = SEQ_10 ;
Observer Outut : IDLE ;


*DESIGN BUG*
Based on above test input and analysis the design, we see the following:

1) assign seq_seen = current_state == SEQ_1011 ? 1 : 0;  -------> BUG 1

For the comparing equation, the to statements which we are comparing must be in bracets so to distinguish it from the variable in which we assign its value after the evaluation, as it gives the unreliable outputs every time.
And hence, the statement should be :
assign seq_seen = (current_state == SEQ_1011) ? 1 : 0; 


2)  SEQ_1011:
      begin
        next_state = IDLE;
      end



The code must add an if else consition so that it works as an overlapping sequence detector instead of a series sequence detector which skips the overlapped sequences.

 SEQ_1011:
      begin
      if(inp_bit == 1)
             next_state = SEQ_1;
       else      
        next_state = IDLE;
      end

