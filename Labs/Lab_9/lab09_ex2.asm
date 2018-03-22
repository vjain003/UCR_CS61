
.ORIG x3000

LD R4, BASE
LD R5, MAX
LD R6, TOS

JSR SUB_STACK_POP
JSR SUB_STACK_PUSH

LOOPP
 LD R3, PUSH_SUB
 JSRR R3
ADD R2, R2, #0
BRn DONE
 BRzp LOOPP

DONE
  HALT
;==============
;local data
;==============

ASK_FOR_PUSH	.STRINGZ	"PLEASE ENTER UPTO 5 CHARS TO PUSH ONTO STACK: \n"
R7_BACKUP	.FILL	x0000
BASE		.FILL	xA000
MAX		.FILL	xA005
TOS		.FILL	xA000
PUSH_SUB	.FILL	x3200


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

.ORIG x3200
;STORE NECESSARY REGS OTHER THAN R4, R5, R6
SUB_STACK_PUSH:
ST R0, R0_BACKUP_3200
ST R1, R1_BACKUP_3200
;ST R2, R2_BACKUP_3200
ST R3, R3_BACKUP_3200
ST R7, R7_BACKUP_3200

NOT R1, R6
ADD R1, R1, #1
ADD R2, R5, R1
BRnz PRINT_OVERFLOW_MSG

GETC
OUT
STR R0, R6, #0
ADD R6, R6, #1
BRnzp DONE_3200	

PRINT_OVERFLOW_MSG
AND R2, R2, #0
ADD R2, R2, #-1
  LEA R0, OVERFLOW_MSG
  PUTS

;LD NECESSARY VARS OTHER THAN R4, R5, R6

DONE_3200
LD R0, R0_BACKUP_3200
LD R1, R1_BACKUP_3200
;LD R2, R2_BACKUP_3200
LD R3, R3_BACKUP_3200
LD R7, R7_BACKUP_3200

RET

;==========
;SUB DATA
;==========
R0_BACKUP_3200	.FILL x0000
R1_BACKUP_3200	.FILL x0000
R2_BACKUP_3200	.FILL x0000
R3_BACKUP_3200	.FILL x0000
R7_BACKUP_3200	.FILL x0000
OVERFLOW_MSG	.STRINGZ	"\nSTACK IS ALREADY FULL! \n"



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
ST R1, R1_BACKUP_3400
ST R2, R2_BACKUP_3400
ST R3, R3_BACKUP_3400
ST R7, R7_BACKUP_3400

NOT R1, R6
ADD R1, R1, #1
ADD R2, R4, #1
BRz PRINT_UNDERFLOW

LDR R0, R6, #0
TRAP x21
ADD R6, R6, #-1

PRINT_UNDERFLOW
  LEA R0, UNDERFLOW_MSG
  PUTS

LD R1, R1_BACKUP_3400
LD R2, R2_BACKUP_3400
LD R3, R3_BACKUP_3400
LD R7, R7_BACKUP_3400

RET

;==========
;SUB DATA
;==========
R1_BACKUP_3400	.BLKW #1
R2_BACKUP_3400	.BLKW #1
R3_BACKUP_3400	.BLKW #1
R7_BACKUP_3400	.BLKW #1
UNDERFLOW_MSG	.STRINGZ	"\nSTACK IS ALREADY EMPTY! \n"