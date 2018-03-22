;=================================================
; Lab: lab 3
; Lab section: 26
; TA: Dipan Shaw
;=================================================

.ORIG x3000

;Instructions:

LD R3, DEC_65	;Load Register 1 with decimal #65
LD R4, HEX_41	;Load register 2 with hex 41

HALT

;Data

DEC_65	.FILL	#65
HEX_41	.FILL	x41

.end