
.ORIG x3000

;Instructions:

LD R5, DATA_PTR;

LDR R3, R5, #0
LDR R4, R5, #1

ADD R3, R3, #1	;r3 = r3+1
ADD R4, R4, #1	;r4 = r4+1

STR R3, R5, #0	;store indirectly r3 into mem DEC_65
STR R4, R5, #0	;store indirectly r4 into mem HEX_41

HALT
;====

DATA_PTR	.FILL	x4000

.ORIG x4000

NEW_DEC_65	.FILL	#65
NEW_HEX_41	.FILL	x41


.end