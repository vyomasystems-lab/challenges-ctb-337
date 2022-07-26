# challenges-ctb-337
challenges-ctb-337 created by GitHub Classroom


![Screenshot (2302)](https://user-images.githubusercontent.com/109905598/181747265-5f39bcc9-6929-4734-9d53-5a8ff63932f7.png)


### *Verification Environment:*
The cocoTb based python test is developed and tests for verification of bug and making the code bug free.The codes are running but there are some cases for which the output is not coming as expected.





## *LEVEL_1_DESIGN_1*
Design 1 consists of Mux with 31 inputs and 5 select bits and 2 output bits to choose and represent the output respectively.

# *Test Scenario 1:*
Test inputs: 5'b11110

Expected output : out = inp30;

Observed Output:  out = 0;

Output mismatches for the above inputs prove that there is a design bug.

# *Test Scenario 2:*
Test inputs: 5'b01101

Expected output : out = inp13 

Observed Output:  out = ip12, inp13, or one might override the other or throws an error.

Output mismatches for the above inputs prove that there is a design bug.


# *Test Scenario 3:*
Test inputs: 5'b01100

Expected output : out = inp12

Observed Output:  out = 0;

Output mismatches for the above inputs prove that there is a design bug.

# *DESIGN BUG*

Based on the above test input and analysis of the design, we see the following:

1)  5'b11101: out = inp29;

 // missing condition -----> BUG 1
 default: out = 0; 
 
 Here, the condition for input 30 is missing, and hence when input 30 is required the output comes out to be 0 instead of out = inp30;
 
 
 2) 5'b01101: out = inp12; ---------> BUG 2
 
 5'b01101: out = inp13; 
 
 It creates confusion about which output to show with the same command as 5'b01101, and might be the data gets overwritten or gives uncertain output every time.
 
 
 3) 5'b01101: out = inp12; ---------> BUG 3
 
 5'b01101: out = inp13; 
 
 The binary value of 12 is incorrect and the same as that of the binary value of 13. Whereas the value of 12 must be 5'b01100.
 
 
## *LEVEL_1_DESIGN_2*

Design 2 consists of a sequence detector 1011 with inputs as inp_bit, reset,clk, and the output as seq_seen with overlap.


# *Test Scenario 1:*
Test Inputs     : assign seq_seen = current_state == SEQ_1011 ? 1 : 0;

Expected Output: out = 1 if the sequence comes out to be the same and 0 if not

Observed Output:  out = error due to assigning value of seq_seen to current_state

Output mismatches for the above inputs prove that there is a design bug.

# *Test Scenario 2:*
Test inputs : after SEQ_1011: (inp_bit == 1); 

Expected Output : next_state = SEQ_10 ;

Observer Output: IDLE ;

Output mismatches for the above inputs prove that there is a design bug.


# *DESIGN BUG*

Based on the above test input and analysis of the design, we see the following:

1) assign seq_seen = current_state == SEQ_1011 ? 1 : 0;  -------> BUG 1

For the comparing equation, the statements which we are comparing must be in brackets to distinguish them from the variable in which we assign its value after the evaluation, as it gives unreliable outputs every time.
And hence, the statement should be:

assign seq_seen = (current_state == SEQ_1011) ? 1 : 0; 


2)  SEQ_1011:                   --------> BUG 2
                                        
             begin

                         next_state = IDLE;
        
              end



The code must add an if-else condition so that it works as an overlapping sequence detector instead of a series sequence detector that skips the overlapped sequences.

 SEQ_1011:
 
      begin
      
      if(inp_bit == 1)
      
             next_state = SEQ_1;
             
       else    
       
        next_state = IDLE;
        
      end

## *LEVEL 3*
Design 3 consists of a sequential logic finite state machine pattern recognition
 
 # *Test Scenario 1:*
Test Inputs: S1101 must get detected

Expected Output: The input sequence must be identified.

Observed Output:  The input sequential series required is not detected.

Output mismatches for the above inputs prove that there is a design bug.


# *DESIGN BUG*

Based on the above test input and analysis of the design, we see the following:

     S4: if(din==1)
                next_state<=S1;    ------> BUG 1
             else
                next_state<=S0;
            
           
   In this block, the input signal is already at 1 and it goes to the next state if the input detects 1, but here it detects the same state again on which it is now, and hence the output is not as per what we required as the sequence is not detected.
        
   Therefore the correct block is: 
       
       S4: if(din==1)
                next_state<=S2;
             else
                next_state<=S0;
        
   Now, the output comes as required.
