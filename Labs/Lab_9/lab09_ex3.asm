

.orig x3000
	LD R1, STACK
	NOT R1, R1		;2's complement
	ADD R1, R1, #1

	LD R2, STACK
	LD R3, CAPACITY

	LEA R0, FIRST_NUM
	PUTS
	JSR SUB_STACK_PUSH

	LEA R0, SECOND_NUM
	PUTS
	JSR SUB_STACK_PUSH

	LEA R0, GET_SIGN
	PUTS
	JSR SUB_STACK_PUSH

	LD R7, RPN_MULTIPLY
	JSRR R7

	LD R7, MULTIPLY
	JSRR R7

    LD R1, STACK
    STR R0, R1, #0

	LD R7, PRINT
	JSRR R7

	HALT

;===========
;Local data
;===========

	STACK   		.FILL x4000
	CAPACITY		.FILL #20
	FIRST_NUM		.STRINGZ "\nPLEASE ENTER A NUMBER: "
	SECOND_NUM		.STRINGZ "\nPLEASE ENTER ANOTHER NUMBER: "
	GET_SIGN		.STRINGZ "\nPLEASE ENTER A MULTIPLICATION SIGN (*):  "	
	RPN_MULTIPLY		.FILL x3600
	MULTIPLY		.FILL x3800
	PRINT			.FILL x3A00

	

;------------------------------------------------------------------------------------------
;Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (​one less than​ the lowest available
;	address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
; If the stack was already full (TOS = MAX), the subroutine has printed an
; overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------

.orig x3200

SUB_STACK_PUSH:

ST R7, R7_BACKUP_3200
ADD R3, R3, #0
BRnz STACK_FULL
BRp STACK_NOT_FULL

STACK_FULL:
  LEA R0, OVERFLOW_MSG
  PUTS
  BR FINISH_PUSH

STACK_NOT_FULL:
  GETC
  OUT
  STR R0, R2, #0
  ADD R2, R2, #1
  ADD R3, R3, #-1
  BR FINISH_PUSH

FINISH_PUSH:
  LD R7, R7_BACKUP_3200
  RET

;===========
;Local data
;===========

R7_BACKUP_3200		.FILL x0000
OVERFLOW_MSG		.STRINGZ "\nSTACK IS FULL!.\n"



;------------------------------------------------------------------------------------------;
;Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (​one less than​ the lowest available
;	address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​current top of the stack
; Postcondition: The subroutine has popped MEM[top] off of the stack.
;If the stack was already empty (TOS = BASE), the subroutine has printed
;	an underflow error message and terminated.
; Return Value: R0 ← value popped off of the stack
;R6 ← updated TOS
;------------------------------------------------------------------------------------------

.orig x3400

SUB_STACK_POP:
ST R7, R7_BACKUP_3400
ADD R4, R1, R2
BRnz STACK_EMPTY
BRp STACK_NOT_EMPTY

STACK_EMPTY:
LEA R0, UNDERFLOW_MSG
PUTS
BR FINISH_POP

STACK_NOT_EMPTY:
LEA R0, POP_STACK_MSG
PUTS

ADD R2, R2, #-1
ADD R3, R3, #1
LDR R0, R2, #0
OUT
BR FINISH_POP

FINISH_POP:	
LD R7, R7_BACKUP_3400

RET

;==========
;LOCAL DATA
;==========
R7_BACKUP_3400		.FILL x0000
UNDERFLOW_MSG		.STRINGZ "\nSTACK IS EMPTY!\n"
POP_STACK_MSG		.STRINGZ "\nStack's top is: "

	


;MULTIPLY SUBROUTINE

.orig x3600

SUB_RPN_MULTIPLY:
ST R7, R7_BACKUP_3600
JSR SUB_STACK_POP
JSR SUB_STACK_POP

ADD R1, R0, #0
ADD R1, R1, #-15
ADD R1, R1, #-15
ADD R1, R1, #-15
ADD R1, R1, #-3
ST R1, FIRST_DIGIT

JSR SUB_STACK_POP		;get the second digit, store it in R2
ADD R1, R0, #0
ADD R1, R1, #-15
ADD R1, R1, #-15
ADD R1, R1, #-15
ADD R1, R1, #-3
ST R1, SECOND_DIGIT

LD R1, FIRST_DIGIT
LD R2, SECOND_DIGIT		
LD R7, R7_BACKUP_3600

RET

	
;==========
;LOCAL DATA
;==========

R7_BACKUP_3600	.FILL 	x0000
FIRST_DIGIT		.FILL	#0
SECOND_DIGIT	.FILL	#0


;

.orig x3800

SUB_RPN_MULTIPLY_2:
ST R7, R7_BACKUP_3800	
LD R0, DEC_0_3800
ADD R2, R2, #0
BRz ANS_ZERO

DO_MULTIPLY
ADD R0, R1, R0
ADD R2, R2, #-1
BRp DO_MULTIPLY
END_DO_MULTIPLY


ANS_ZERO:
LD R7, R7_BACKUP_3800
RET

	
;==========
;LOCAL DATA
;==========
R7_BACKUP_3800		.FILL x0000
DEC_0_3800		.FILL #0

	

	
;DECIMAL SUBROUTINE
.orig x3A00
SUB_PRINT_DECIMAL:
  ST R7, R7_BACKUP_3A00	
  LD R1, NDEC_10
  LD R2, NDEC_1

GET_TENTH
  ADD R2, R2, #1
  ADD R0, R0, R1
  BRzp GET_TENTH
  END_GET_TENTH

ADD R1, R0, #10
LEA R0, ANSWER_MSG
PUTS	

ADD R2, R2, #0
BRz NO_FIRST_DIGIT
BRp PRINT_FIRST_DIGIT

PRINT_FIRST_DIGIT:
  ADD R0, R2, #15
  ADD R0, R0, #15
  ADD R0, R0, #15
  ADD R0, R0, #3
  OUT

NO_FIRST_DIGIT:
  LD R2, NDEC_1

GET_ONETH
  ADD R2, R2, #1
  ADD R1, R1, #-1
  BRzp GET_ONETH
  END_GET_ONETH

	
ADD R0, R2, #15
ADD R0, R0, #15
ADD R0, R0, #15
ADD R0, R0, #3
OUT

LD R7, R7_BACKUP_3A00
RET

	
;==========
;LOCAL DATA
;==========
R7_BACKUP_3A00		.FILL x0000
NDEC_10			.FILL #-10
NDEC_1			.FILL #-1
ANSWER_MSG		.STRINGZ "\nTHE ANSWER IS: "