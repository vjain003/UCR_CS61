.ORIG x3000

;Instructions:

LDI R3, DEC_65
LDI R4, HEX_41

ADD R3, R3, #1	;r3 = r3+1
ADD R4, R4, #1	;r4 = r4+1

STI R3, DEC_65	;store indirectly r3 into mem DEC_65
STI R4, HEX_41	;store indirectly r4 into mem HEX_41

HALT
;====

;FIRST DATA

DEC_65	.FILL	x4000
HEX_41	.FILL	x4001

.ORIG x4000

NEW_DEC_65	.FILL	#65

NEW_HEX_41	.FILL	x41

S
.end