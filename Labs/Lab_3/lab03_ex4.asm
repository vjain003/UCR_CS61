

.orig x3000

;--------
;Instructions
;--------

LD R0, HEX_61 	;R0 <-- X61 == DEC 97
LD R1, HEX_1A	;R1 <-- HEX1A == DEC 26

;in do while loop, add r0 and 1 to r0, and r1-1 to r1
;kind of like the assn 1 and do the dowhile if r1 >0 and end dowhile
;fill both labels with their corresponding hexs

DO_WHILE_LOOP
	OUT
  ADD R0, R0, #1 	; R0 = R0+1
  ADD R1, R1, #-1	; R1 = R1-1
  BRp DO_WHILE_LOOP	;IF R1 > 0, REDO DO WHILE
END_DO_WHILE_LOOP

HALT

;------------
;LOCAL DATA
;------------

HEX_61	.FILL x61
HEX_1A	.FILL x1A

.end