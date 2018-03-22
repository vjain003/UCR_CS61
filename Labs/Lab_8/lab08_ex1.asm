;=================================================
; Name: Vidhi Jain
; Email:  vjain003
; 
; Lab: lab 8
; Lab section: 26
; TA: Dipan Shaw
;=================================================
.orig x3000

;=============
;Instructions;
;=============

JSR SUB_PALINDROME	;jump to the subroutine palindrome

HALT

;============
;REMOTE DATA;
;============
;NOTHINGGGG

;===========
;SUBROUTINE;
;===========

.ORIG x3200
SUB_PALINDROME:

ST R7, BACKUP_R7
LEA R0, INTRO_MESSAGE
PUTS

LD R1, ARRAY_PTR

CIN_INPUT
  GETC			;GET THE INPUT
  OUT
STR R0,R1, #0
ADD R1, R1, #1
ADD R5, R5, #1
ADD R0, R0, #-10	;CHECK IF ENTER KEY
BRp CIN_INPUT		;LOOP BACK
ADD R5, R5, #-1
END_CIN_INPUT		;ELSE END IT


LD R7, BACKUP_R7

RET

;========
;DATA;
;========
INTRO_MESSAGE	.STRINGZ "Please input a string. Press ENTER to terminate: "
ARRAY_PTR .FILL x4000 
BACKUP_R7 .FILL x0000	;nothing because we need ot back it up






