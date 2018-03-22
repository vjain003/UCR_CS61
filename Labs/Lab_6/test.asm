.orig x3000

RESET ; if invalid input sent back
	LEA R0, INTRO
	PUTS
	LD R0, LINE
	OUT
	LD R3, SENT
	LD R1, ZERO ; sets up 0 in R1
	LD R5, ZERO ; sets up 0 in R5
	GETC
	OUT
	LD R4, SYMN
	ADD R2, R0, R4; checks -
	BRz NEG
	LD R4, SYMP
	ADD R2, R0, R4;checks +
	BRz MAIN
	LEA R6, EPROMPT
	JMP R6

NEG ; set sentinal for negative
	ADD R5, R1, #-1
	
MAIN ; the processing of the numbers;
	GETC
	OUT
	LD R4, SYM9
	ADD R2, R0, R4 ;checks for symbole after 9
	BRp EPROMPT
	LD R4, SYMZ
	ADD R2, R0, R4 ;checks for symbol before 0
	BRn EPROMPT
	LEA R6, MULTI
	JMP R6

RETURN ;gets back from MULTI10
	LD R4, SYMZ
	ADD R2, R0, R4
	ADD R1, R1, R2
	ADD R3, R3, #-1; check sentinal 
	BRp MAIN 
	ADD R5, R5, #0 ; check for negative sign sentinal
	BRn CONVERT
END
	ADD R1, R1, #1
	LD R0, LINE
	OUT
	LD R6, PRINT
	JSRR R6
	HALT

CONVERT
	NOT R1, R1
	ADD R1, R1, #1
	BR END
	
EPROMPT; gives the error message and starts over
	LD R0, LINE
	OUT
	LEA R0, ERR
	PUTS
	LD R0, LINE
	OUT
	LEA R6, RESET
	JMP R6

MULTI; multiples number by 10
	LD R4, MSENT
	ADD R2, R1, #0
AGAIN ; for loop to iterate
	ADD R1, R1, R2
	ADD R4, R4, #-1
	BRz RETURN
	BR AGAIN
	

;data
INTRO .STRINGZ "Welcome, please give a 5 digit decimal number preceded by (+/-), followed by enter:"
ERR .STRINGZ " input error resetting ";
SENT .fill #5
MSENT .fill #9
LINE .fill xA
; symboles value subtraction ready values
ZERO .fill #0
SYMN .fill #-45 ; negative conversion
SYMP .fill #-43 ; positive coversion
SYMZ .fill #-48 ; zero sym conversion
SYM9 .fill #-57 ; 9 sym conversion
PRINT .fill x3400

.orig x3400
;subroutine :print
;Input: R1 contains value wished to be printed as decimal 
;Postcondition: printed out decimal to console
;STORE:
	ST R7, R7_BACKUP
	ST R1, R1_BACKUP
;LOGIC
	ADD R1, R1 , #0
	BRzp POSPP
NEGP 
	LD R0, SYMNN
	OUT
	NOT R1, R1
	ADD R1, R1, #1

POSPP
	LD R3, VAL1
	LD R6, PTRC
	JSRR R6
	
	LD R3, VAL2
	JSRR R6

	LD R3, VAL3
	JSRR R6

	LD R3, VAL4
	JSRR R6

	LD R3, VAL5
	JSRR R6

	LD R1, R1_BACKUP
	

	HALT

;data
SENTP .fill #5
PTRC .FILL x3600
SYMNN .fill x2D
VAL1 .FILL #-10000
VAL2 .FILL #-1000
VAL3 .FILL #-100
VAL4 .FILL #-10
VAL5 .FILL #-1
R7_BACKUP .blkw #1
R1_BACKUP .blkw #1

.ORIG x3600
;SUB COUNTER
;INPUT TAKES IN R2 VALUE AND R3 COMPARISION VALUE
;POST: DOES THE ACTUALY ARITHMATIC 

	ST R7, R7_BACKUP_36

ZEROP ;RESETS R0
	LD R0, Z36
LOOPP ; LOOP TO DETERMINE DEGREE OF DECIMAL 
	ADD R1 , R1 , R3
	BRzp POSP
	BRn NEXTP

POSP
	ADD R0, R0, #1
	BR LOOPP

NEXTP
	NOT R3, R3
	ADD R3, R3, #1
	ADD R1, R1, R3 ; UNDO NEG
	LD R5, CONVDEC
	ADD R0, R0, R5 ; ASCII VAL
	OUT

	LD R7, R7_BACKUP_36
	RET

;DATA 
R7_BACKUP_36 .BLKW #1
Z36 .FILL #0
CONVDEC .fill #48

.end