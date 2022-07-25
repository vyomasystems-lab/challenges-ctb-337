# challenges-ctb-337
challenges-ctb-337 created by GitHub Classroom

### *Verification Environment:*
The cocoTb based python test is developed and tests for verification of bug and making the code bug free. 


## *LEVEL_1_DESIGN_1*
The design 1 consists of Mux with 31 inputs and 5 select bits and 2 output bits to choose and represent the output respectively.

# *Test Scenario 1:*
Test inputs: 5'b11110

Expected output : out = inp30;

Observed Output:  out = 0;

Output mismatches for the above inputs proving that there is a design bug.

# *Test Scenario 2:*
Test inputs: 5'b01101

Expected output : out = inp13 

Observed Output:  out = ip12 , inp13 or one might override other or throws an error.

Output mismatches for the above inputs proving that there is a design bug.


# *Test Scenario 3:*
Test inputs: 5'b01100

Expected output : out = inp12

Observed Output:  out = 0;

Output mismatches for the above inputs proving that there is a design bug.

# *DESIGN BUG*

Based on above test input and analysis the design, we see the following:

1)  5'b11101: out = inp29;

 // missing condition -----> BUG 1
 default: out = 0; 
 
 Here, the consition for input 30 is missing and hence when input 30 is required the output comes out to be 0 instead of out = inp30;
 
 
 2) 5'b01101: out = inp12; ---------> BUG 2
 
 5'b01101: out = inp13; 
 
 It creates confusion which output to show with same command as 5'b01101, might be the data gets overwrite or give uncertain output everytime.
 
 
 3) 5'b01101: out = inp12; ---------> BUG 3
 
 5'b01101: out = inp13; 
 
 he binary value of 12 is incorrect and same as that of binary value of 13. Whereas the value of 12 must be 5'b01100.
 
 
## *LEVEL_1_DESIGN_2*

The designn 2 consists of a sequence detector 1011 with inputs as inp_bit,reset,clk and the output as seq_seen with overlap.


# *Test Scenario 1:*
Test Inputs: assign seq_seen = current_state == SEQ_1011 ? 1 : 0;

Expected Output : out = 1 if sequence comes out to be same and 0 if not

Observed Output:  out = error due to assigning value of seq_seen to current_state

Output mismatches for the above inputs proving that there is a design bug.

# *Test Scenario 2:*
Test inputs : after SEQ_1011: (inp_bit == 1); 

Expected Output : next_state = SEQ_10 ;

Observer Outut : IDLE ;


# *DESIGN BUG*

Based on above test input and analysis the design, we see the following:

1) assign seq_seen = current_state == SEQ_1011 ? 1 : 0;  -------> BUG 1

For the comparing equation, the to statements which we are comparing must be in bracets so to distinguish it from the variable in which we assign its value after the evaluation, as it gives the unreliable outputs every time.
And hence, the statement should be:

assign seq_seen = (current_state == SEQ_1011) ? 1 : 0; 


2)  SEQ_1011:                                             --------> BUG 2
      
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

## *LEVEL 3*
The design 3 consists of a sequential logic finite state machine pattern recognition
 
 # *Test Scenario 1:*
Test Inputs: S00110 must get detected

Expected Output : The input sequence must be identified.

Observed Output:  The input sequential series required is not detected.

Output mismatches for the above inputs proving that there is a design bug.


# *DESIGN BUG*

Based on above test input and analysis the design, we see the following:

1)  S0110: begin
            if (in) next_state <= S00110;   -----------------------> BUG 1
            
            else   
            
            next_state <= S0;
       
       In this block, the inut signal is given 1 instead of 0 and hence hte output is not as per we required as the sequence is not detected.
        
     Therefore the correct block is: 
         
         S0110: begin
            
            if (!in) next_state <= S00110;
            
            else    next_state <= S0;
        
        end
        
        Now, the output comes as required.
