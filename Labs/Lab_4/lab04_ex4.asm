
.ORIG x3000

LD	R5, ARRAY_PTR		;r5 starts with 4000
LD 	R6, LOOP_COUNTER	;times to store in array

LEA R0, LABEL
PUTS

LOOPP
  TRAP x20	;LOAD INPUT TO R0
  STR R0, R5, #0	;STORE R0 VALUE IN [X4000+0]
  ADD R5, R5, x0001	;R5 BECOMES X4001
;  ADD R6, R6, #-1	;REDUCING LOOP COUNTER BY 1
  ADD R0, R0, #-10

  BRp LOOPP
END_LOOPP



;write another loop to print it out
;in one loop take input, in  another write out the output
;taking in is done above, do writing out here
;LOAD THE ARRAY AGAINA ND PRINT OUT
; PRINT NEW LINE AFTER EACH CHARS
LD R5, ARRAY_PTR
LD R6, LOOP_COUNTER
LOOPP_PRINT
  LDR R0, R5, #0
  TRAP x21
  ;PRINT NEW LINE
  LD R0, NEW_LINE

  TRAP x21
  ADD R5, R5, x0001
  ADD R0, R0, #-10
  ADD R6, R6, #-1

  BRp LOOPP_PRINT
END_LOOPP_PRINT

HALT


;DATA
ARRAY_PTR 	.FILL x4000
LOOP_COUNTER	.FILL #10
NEW_LINE	.FILL x0A
LABEL .STRINGZ "Enter 10 characters"
LEA R0, LABEL

;INTIAL_VALUE	.FILL #0

.ORIG x4000
;ARRAY .BLKW	#10
