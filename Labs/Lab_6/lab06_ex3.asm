

.orig x3000				;SAME AS LAB
	JSR START

INVALIDITY_LOOP				;CHECKING IF IT IS VALID
	LD R7,IS_B
	ADD R0,R0,R7
	BRz LOOP
	LD R0,NEW_LINE2
	OUT
	LEA R0,NOT_B_MSG			;IF YES PUT OUT ERROR MSG
	PUTS
	LD R0,NEW_LINE2
	OUT
	BRnzp START			;ELSE START THIS CODE

NOT_ZERO				;IF NOT 0, PUT OUT
	ADD R6,R6,#-1
	ADD R5,R0,R6
	BRz IS_VALID

NOT_ONE					;IF NOT 1, PUT OUT
	LD R6,ASCII
	ADD R5,R0,R6
	BRz IS_VALID

INVALID					;IF IT IS INVALID, MAKE INVALID_NUM
	LD R0,NEW_LINE2
	OUT
	LEA R0,INVALID_NUM_MSG
	PUTS

SPACE_ENTERED				;IS SPACE THERE? YES THEN GO TO THE LOOP
	ADD R1,R1,#1
	BRnzp LOOP


START
	LD R1,DEC_17			;17 BECAUSE WE NEED TO INCREASE THE THING BY 1.
	AND R4,R4,#0			;NOTES CHECK FOR THIS

LOOP					;CHECK IF INVALID, IF SPACE IS ENTERED, IF NOT 1/0
	GETC
	OUT	
  
	ADD R1,R1,#-1			;INVALID SUBLOOP
	ADD R2,R1,#-16
	ADD R2,R2,#0
	BRz INVALIDITY_LOOP

	LD R7,NEW_SPACE2		;SPACE SUBLOOP
	ADD R6,R0,R7
	BRz SPACE_ENTERED

	LD R6,ASCII
	ADD R5,R0,R6			;NOT ZERO SUBLOOP
	BRnp NOT_ZERO
	
	ADD R6,R6,#-1
	ADD R5,R0,R6			;NOT ONE SUBLOOP
	BRnp NOT_ONE

IS_VALID
	ADD R5,R0,R6			;
	ADD R3,R1,#0
	LD R2,ASCII
	ADD R0,R0,R2

TWO_LOOPP	
	ADD R3,R3,#0
	BRz AFTER_EVERYTHING
	ADD R0,R0,R0
	ADD R3,R3,#-1
	BRp TWO_LOOPP

AFTER_EVERYTHING
	ADD	R4,R4,R0
	ADD	R1,R1,#0
	BRp	LOOP

	ADD	R2,R4,#0
	ADD 	R1,R2,#0
	LD	R5,toASCII
	LD	R3,SUB_ADDR
	LD	R0,NEW_LINE2
	OUT
	JSRR	R3
HALT
;===========
;DATA
;===========
	DEC_17		.FILL	#17
	ASCII		.FILL	#-48
	toASCII		.FILL	#48

	SUB_ADDR	.FILL	x5000

	NEW_LINE2	.FILL	#10
	NEW_SPACE2	.FILL	#-32

	IS_B		.FILL	#-98
	NOT_B_MSG	.stringz "first char not b\n"
	INVALID_NUM_MSG	.stringz "need 0 1 or space\n"

.orig x5000

;======================
; ROLLING OUR OWN SUBS
;======================
SUBROUTINE
;USE THE SAME WHATS_NEXT AS BEFORE

BACKUP_INIT
	ST	R7,R7_BACKUP

	LD 	R6,char16

PRINT_BRANCH	
	ADD	R1,R1,#0
	BRzp	ZERO_PRINT
	ADD	R1,R1,#0
	BRn	ONE_PRINT

WHATS_NEXT
	ADD	R1,R1,R1
	ADD	R6,R6,#-1

	LD	R7,SPACE4
	ADD	R7,R6,R7
	BRz	PRINT_SPACE

	LD	R7,SPACE8
	ADD	R7,R6,R7
	BRz	PRINT_SPACE

	LD	R7,SPACE12
	ADD	R7,R6,R7
	BRz	PRINT_SPACE

PENULTIMATE_LOOPP			;LOOP AFTER THE SPACE
	ADD	R6,R6,#0	
	BRp	PRINT_BRANCH
	LD	R0,NEW_LINE
	OUT
	BRnzp	END_SUBROUTINE

ZERO_PRINT				;DO 0 PRINT AS EX2
	AND	R0,R0,#0
	ADD	R0,R0,R5
	OUT
	BRnzp	WHATS_NEXT

ONE_PRINT				;DO 1 PRINT AS EX2
	AND	R0,R0,#0
	ADD	R0,R0,#1
	ADD	R0,R0,R5
	OUT
	BRnzp	WHATS_NEXT

PRINT_SPACE
	LD	R0,NEW_SPACE
	OUT
	BRnzp	PENULTIMATE_LOOPP	;NO MATTER WHAT, GO TO THE LOOP AFTER THE SPACE

END_SUBROUTINE
	LD	R7,R7_BACKUP

	RET

;===========
;REMOTE DATA
;===========
	char16		.FILL	#16
	SPACE4		.FILL	#-12
	SPACE8		.FILL	#-8
	SPACE12		.FILL	#-4

	NEW_LINE	.FILL	#10
	NEW_SPACE	.FILL	#32	

	R7_BACKUP	.FILL	x0


.end