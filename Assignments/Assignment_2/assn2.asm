

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;outputs prompt
;----------------------------------------------	
LEA R0, intro			; 
PUTS				; Invokes BIOS routine to output string

;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
GETC
OUT
ADD R1, R0, #0		;R0 <- R1 + #0

;SECOND TIME
LEA R0, NEWLINE		;LOAD EFFECTIVE ADDRESS. PUT NEWLINE INTO R0 AGAIN
PUTS			;INVOKES BIOS ROUTINE TO OUTPUT STRING

GETC
OUT
ADD R2, R0, #0		;R0 <- R1 + #0


LEA R0, NEWLINE	
PUTS

ADD R0, R1, #0		;R0<-R1+#0
OUT			;OUTPUT STUFF IN R TO CONSOLE


LEA R0, MINUS		;PRINT OUT MINUS
PUTS

ADD R0, R2, #0		;PRINT R0 <- R2 + 0
OUT

LEA R0, EQUAL 		;PRINT EQUAL
PUTS

;2'S COMPLEMENT STUFF
;NEED TO MAKE THE SECOND NEGATIVE BECAUSE
;COMPILIER WON'T GROUP THE MINUS AND NUMBER TOGETHER
;IT WILL READ MINUS, NUMBER NOT -NUMBER;



ADD R1, R1, #-12	;ADD 48 TO TURN R1 TO ASCII
ADD R1, R1, #-12	;CAN ALSO DO .FILL #48 TO REGISTER AND ADD TO THIS
ADD R1, R1, #-12
ADD R1, R1, #-12

ADD R2, R2, #-12	;ADD 48 TO TURN R2 TO ASCII
ADD R2, R2, #-12	;CAN ALSO DO .FILL #48 TO REGISTER AND ADD TO THIS
ADD R2, R2, #-12
ADD R2, R2, #-12
	
NOT R2, R2		;2'S COMPLEMENT
ADD R2, R2, #1

ADD R3, R1, R2		;STORE IN R3 AND MAKE SURE
ADD R3, R3, #0


;2'S COMPLEMENT FLIP BITS ADD 1
;NOT R3, R3
;ADD R3, R3, #0
;ADD R3, R3, #1
;ADD R4, R1, R3			;ADD THE ASCII AND 2'S COMPLEMENT TO R4. PUT THE VALUE IN R4

;BRANCH TO NEG OR POS DEPENDING ON WHAT IT IS

BRn NEGATIVE_NUMBER

ADD R3, R3, #0
BRzp POSITIVE_NUMBER

NEGATIVE_NUMBER
  NOT R3, R3			;CHANGE TO 2'S COMPLEMENT
  ADD R3, R3, #1

  ADD R3, R3, #12		;CHANGE 
  ADD R3, R3, #12			
  ADD R3, R3, #12	
  ADD R3, R3, #12	

 LD R0, NEGATIVE		;LOAD EFFECTIVE ADDRESS NEGATIVE TO R0
    OUT	;PRINT

ADD R0, R3, #0			;PRINT AND PUT R4 INTO R0
    OUT				


BRzp END_FUNC

POSITIVE_NUMBER
  
  ADD R3, R3, #12		;CHANGE 
  ADD R3, R3, #12	
  ADD R3, R3, #12	
  ADD R3, R3, #12	
  ADD R0, R3, #0		;STORE IN R0
  OUT


END_FUNC
  LEA R0, NEWLINE	;ENDL
    PUTS		;PRINT
    HALT				; Stop execution of program





;------	
;Data
;------
; String to explain what to input 
intro .STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 
NEWLINE .STRINGZ "\n"	; String that holds the newline character
NEGATIVE .STRINGZ "-"
POSITIVE .STRINGZ "+"
EQUAL .STRINGZ " = "
MINUS .STRINGZ " - "


;---------------	
;END of PROGRAM
;---------------	
.END
