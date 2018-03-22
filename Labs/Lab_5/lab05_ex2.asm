

.ORIG x3000

LD R2, DEC_48		; LOAD DEC 48 INTO R4
LD R1, ARRAY_PTR	;LOAD ARRAY PTR INTO R1
LD R3, COUNTER		;LOAD COUNTER LABEL INTO R3

LOOP
  STR R2, R1, #0	;STORES RELATIVELY SOURCE R1 AND OFFSET 0 INTO DEST R2
  ADD R2, R2, #1	;ADD 1 TO R2 ;DELETE FOR R2
  ADD R1, R1, #1	;ADD 1 TO R1
  ADD R3, R3, #-1	;DECREMENT R3 BY 1
  BRp LOOP

LD R1, ARRAY_PTR
LD R3, COUNTER
LDR R2, R1, #0

ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #15
ADD R2, R2, #3

TWO_LOOP
ADD R0, R2, #0
TRAP x21
ADD R2, R2, #1
ADD R3, R3 #-1
BRp TWO_LOOP

HALT

;DATA;

DEC_48		.FILL	#48
ARRAY_PTR	.FILL 	x4000
COUNTER		.FILL	#10 ; CHANGE TO #16 FOR EX 4
NUM_ZERO	.FILL	#0

.ORIG x4000

ARRAY_1		.BLKW	#10	;CHANGE TO #16 FOR EX 4