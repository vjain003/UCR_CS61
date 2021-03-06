.ORIG x3000



	LD R1,HARD_CODE
	LD R2,ARRAY_POINTER
	LD R5,DEC_NUM

FIRST_LOOP
	STR R1,R2,#0		;PUT R2 INTO R1
	ADD R2,R2,#1		;INCREMENT R2
	ADD R1,R1,R1 		;SHIFT LEFT R1
	ADD R3,R1,R5
	BRnp FIRST_LOOP		;KEEP DOING UNTIL NEW R HAS THE HARDCODE AND MAX DEC NUM

	LD R4, ARRAY_POINTER	;PUT THE PNTR INTO NEW R
	ADD R4,R4,#6

	LDR R2,R4,#0

TWO_LOOPP	
	LD R3,ARRAY_POINTER
	LD R5,ASCII_NUM
	LD R4,COUNTER2
	

FINISHING_FUNC
	LD R6,COUNTER1
	LDR R1,R3,#0
	LD R7,SUB_ADDR		;JUST LOADING THE X5000 INTO R7
	JSRR R7			;WHAT THE TA TOLD US
		
	ADD R3,R3,#1
	ADD R4,R4,#-1
	BRp FINISHING_FUNC
	BRnzp END		;NO MATTER WHAT JUST END THE THING
	
END
	HALT
;=====
;DATA
;=====
	HARD_CODE	.FILL	x1
	ARRAY_POINTER	.FILL	ARRAY
	DEC_NUM		.FILL	#-1024 	;2^10

	COUNTER1	.FILL	#16
	COUNTER2	.FILL	#10

	ASCII_NUM	.FILL	#48
	SUB_ADDR	.FILL	x5000

.ORIG x4000
	ARRAY	.BLKW	#10		;INITIALIZING EMPTY ARR

.ORIG x5000		;STARTS AT A DIFFERENT MEM LOC SINC 3 AND 4 ARE TAKEN UP
;==========
;SUB INSTR
;-=========
PRINT_SUBROUTINE

BACKUP_INIT
	ST R3,R3_BACKUP		;LIKE WHAT TA SHOWED
	ST R4,R4_BACKUP		;JUST BACK UP ALL EXCEPT THAT ONE
	ST R7,R7_BACKUP

PRINT_BRANCH	
	ADD R1,R1,#0		;PRINTING IT
	BRzp ZERO_PRINT	
	ADD R1,R1,#0
	BRn ONE_PRINT
	
NEXT_CHAR
  ;TRY TO PRINT OUT THE SPACES WITHOUT A LOOP
	ADD R1,R1,R1		;SHIFT LEFT
	ADD R6,R6,#-1		;DECREASE R6

	LD R7,SPACE4
	ADD R7,R6,R7		;LOAD THE STUFF IN R6 AND THE SPACE INTO R7 AND PRINT THE SPACE
	BRz SPACE_PRINT

	LD R7,SPACE8
	ADD R7,R6,R7		;''			''			''	
	BRz SPACE_PRINT

	LD R7,SPACE12
	ADD R7,R6,R7		;''			''			''
	BRz SPACE_PRINT

PENULTIMATE_LOOPP
	ADD R6,R6,#0	
	BRp PRINT_BRANCH
	LD R0,NEW_LINE
	OUT
	BRnzp END_SUBROUTINE

ZERO_PRINT
	AND R0,R0,#0
	ADD R0,R0,R5
	OUT
	BRnzp NEXT_CHAR

ONE_PRINT	
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R0,R0,R5
	OUT
	BRnzp NEXT_CHAR

SPACE_PRINT
	LD R0,NEW_SPACE
	OUT
	BRnzp PENULTIMATE_LOOPP

END_SUBROUTINE
	LD R3,R3_BACKUP
	LD R4,R4_BACKUP
	LD R7,R7_BACKUP

	RET

;============
;REMOTE DATA
;============
	SPACE4 		.FILL	#-12	;THE SPACE TRIPLETS
	SPACE8		.FILL	#-8
	SPACE12		.FILL	#-4

	NEW_LINE	.FILL	#10	;THE SP CHAR TWINS
	NEW_SPACE	.FILL	#32	;DO I NEED THIS? TRY TO REPLACE THIS WITH ONLY TRIPLETS

	R3_BACKUP	.FILL	x0	;THE BACKUP SINGERS
	R4_BACKUP	.FILL	x0
	R7_BACKUP	.FILL	x0
.END