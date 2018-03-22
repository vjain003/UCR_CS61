;=================================================
; Name: Vidhi Jain
; Email: vjain003@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 26
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
START_MENU
LD R7, MENU
JSRR R7
				    ;BRANCHES TO ALL THE OPTIONS
  ADD R1, R1, #-1
  BRz OPTION_ONE_FUNC

  ADD R1, R1, #1
  ADD R1, R1, #-2
  BRz OPTION_TWO_FUNC
  
  ADD R1, R1, #2
  ADD R1, R1, #-3
  BRz OPTION_THREE_FUNC

  ADD R1, R1, #3
  ADD R1, R1, #-4
  BRz OPTION_FOUR_FUNC

  ADD R1, R1, #4
  ADD R1, R1, #-5
  BRz OPTION_FIVE_FUNC

  ADD R1, R1, #5
  ADD R1, R1, #-6
  BRz OPTION_SIX_FUNC

  ADD R1, R1, #6
  ADD R1, R1, #-7
  BRz OPTION_SEVEN_FUNC

BRnzp START_MENU

OPTION_ONE_FUNC			    ;WAHT TO DO FOR ALL THE OPTIONS
  LD R7, ALL_MACHINES_BUSY
  JSRR R7

  ADD R2, R2, #0
  BRz IS_NOT_BUSY			;IF IT IS ZERO, THEN THAT MEANS IT ISNT BUSY
  BRp IS_BUSY			;IF ONE IT IS BUSY

  IS_NOT_BUSY			;IF FREE, PUT OUT A NEW LINE AND THEN OUTPUT THE MSG ALL BUSY
    LD R0, ENTER
    OUT
    LEA R0, ALLNOTBUSY
    PUTS
    BRnzp START_MENU

  IS_BUSY				;IF BUSY, PUT OUT A NEW LINE AND THEN OUTPUT THE MSG ALL NOT BUSY
    LD R0, ENTER
    OUT
    LEA R0, ALLBUSY
    PUTS
    BRnzp START_MENU

OPTION_TWO_FUNC		;WHEN R2 IS SHIFTED, IF IT IS POS PUT OUT FREE MSG AND IF NEG PUT NOTFREE
LD R7, ALL_MACHINES_FREE
JSRR R7

  ADD R2, R2, #0
  BRp ALL_FREE
  BRz NOT_FREE

  ALL_FREE
      LD R0, ENTER
      OUT
      LEA R0, FREE
      PUTS
      BRnzp START_MENU

  NOT_FREE
      LD R0, ENTER
      OUT
      LEA R0, NOTFREE
      PUTS
      BRnzp START_MENU

OPTION_THREE_FUNC		;FORMAT: THERE ARE "NUMBER" BUSY MACHINES

  LD R0, ENTER
  OUT
  LEA R0, BUSYMACHINE1
  PUTS

  LD R7, NUM_BUSY_MACHINES
  JSRR R7

  LEA R0, BUSYMACHINE2
  PUTS
  BRnzp START_MENU

OPTION_FOUR_FUNC		;FORMAT: HTER ARE "NUMBER" FREE MACHS
  LD R0, ENTER
  OUT
  LEA R0, FREEMACHINE1
  PUTS

  LD R7, NUM_FREE_MACHINES
  JSRR R7

  LEA R0, FREEMACHINE2
  PUTS
  BRnzp START_MENU

OPTION_FIVE_FUNC
  LD R0, ENTER
  OUT
  LD R7, Get_input
  JSRR R7

  LD R0, ENTER
  OUT
  LEA R0, STATUS1
  PUTS

  LD R7, MACHINE_STATUS
  JSRR R7

  ADD R2, R2, #0
  BRzp IT_IS_BUSY
  BRn  IT_IS_FREE

  IT_IS_BUSY
    LEA R0, STATUS2
    PUTS
    BRnzp START_MENU

  IT_IS_FREE
    LEA R0, STATUS3
    PUTS
BRnzp START_MENU

OPTION_SIX_FUNC
  LD R0, ENTER
  OUT
  LD R7, FIRST_FREE
  JSRR R7

  ADD R6, R2, #-16
  BRz CHECK_0

  LEA R0, FIRSTFREE
  PUTS

  ADD R6, R4, #-1
  BRz IF_TWO_DIGITS

  ADD R0, R2, R5
  OUT
  LD R0, ENTER
  OUT
  BRnzp START_MENU

  IF_TWO_DIGITS
    ADD R0, R4, R5
    OUT
    ADD R0, R3, R5
    OUT
    LD R0, ENTER
    OUT
    BRnzp START_MENU

  CHECK_0
    LEA R0, FIRSTFREE3
    PUTS
    BRnzp START_MENU

OPTION_SEVEN_FUNC
LD R0, ENTER
OUT
LEA R0, Goodbye
PUTS

HALT
;---------------	
;Data
;---------------
;Add address for subroutines
MENU			.FILL	x3500
ALL_MACHINES_BUSY	.FILL	x3700
ALL_MACHINES_FREE 	.FILL x3900
NUM_BUSY_MACHINES 	.FILL x4100
NUM_FREE_MACHINES 	.FILL x4300
MACHINE_STATUS		.FILL x4500
FIRST_FREE 		.FILL x4700
Get_input		.FILL x4900
ENTER 		.FILL x0A
;Other data 

;Strings for options
Goodbye .Stringz "Goodbye!\n"
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
FREE .STRINGZ "All machines are free\n"
NOTFREE .STRINGZ "Not all machines are free\n"
BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"
FIRSTFREE .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.orig x3500
;HINT back up 
ST R0, BACKUP_R0_x3500
ST R1, BACKUP_R1_x3500
ST R2, BACKUP_R2_x3500
ST R3, BACKUP_R3_x3500
ST R4, BACKUP_R4_x3500
ST R5, BACKUP_R5_x3500
ST R6, BACKUP_R6_x3500
ST R7, BACKUP_R7_x3500

IF_ERROR
LD R0, Menu_string_addr
PUTS
LD R4, NEGHEX_38
LD R5, NEGHEX_30
GETC
OUT
ADD R1, R0, #-10
;BRz USER_INVALID_INPUT
BRn USER_INVALID_INPUT
ADD R1, R0, R5
BRnz USER_INVALID_INPUT
;BRp USER_INVALID_INPUT

LD R3, NEGHEX_30
ADD R1, R0, R3

LD R0, BACKUP_R0_x3500
;LD R1, BACKUP_R1_x3500
LD R2, BACKUP_R2_x3500
LD R3, BACKUP_R3_x3500
LD R4, BACKUP_R4_x3500
LD R5, BACKUP_R5_x3500
LD R6, BACKUP_R6_x3500
LD R7, BACKUP_R7_x3500
RET

USER_INVALID_INPUT
LD R0, NEW_LINE
OUT
LEA R0, Error_message_1
PUTS

BRnzp IF_ERROR
;HINT Restore
	AND R0, R0, #0
	AND R2, R2, #0
	LD R7, R7_STORE
RET
BACKUP_R0_x3500 .BLKW #1
BACKUP_R1_x3500 .BLKW #1
BACKUP_R2_x3500 .BLKW #1
BACKUP_R3_x3500 .BLKW #1
BACKUP_R4_x3500 .BLKW #1
BACKUP_R5_x3500 .BLKW #1
BACKUP_R6_x3500 .BLKW #1
BACKUP_R7_x3500 .BLKW #1

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_message_1 .STRINGZ "INVALID INPUT\n"
Menu_string_addr .FILL x6000
R7_STORE	.FILL	x0
NEGHEX_30 	.FILL -x30
NEGHEX_38 	.FILL -x38
NEW_LINE 	.FILL x0A

 

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3700
;HINT back up 
ST R0, BACKUP_R0_x3700
ST R1, BACKUP_R1_x3700
ST R2, BACKUP_R2_x3700
ST R3, BACKUP_R3_x3700
ST R4, BACKUP_R4_x3700
ST R5, BACKUP_R5_x3700
ST R6, BACKUP_R6_x3700
ST R7, BACKUP_R7_x3700

LD R1, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R3, R1, #0

LD R4, DEC_16	;GO 16 TIMES


FOR_LOOP		;main loop 
  ADD R3, R3, #0

  BRzp MACHINE_BUSY	;CHECK IF 0 ON LEFT
  BRn MACHINE_NOT_BUSY

  MACHINE_BUSY
    
    ADD R4, R4, #-1
    BRz FINISH_LOOP	;REACHED 0?

		;LEFT SHIFT
    ADD R3, R3, R3

    ADD R4, R4, #0	
BRp FOR_LOOP

FINISH_LOOP
  LD R2, DEC_1		;ALL MACHINES ARE BUSY
  BRnzp DO_FINISH

MACHINE_NOT_BUSY
  LD R2, DEC_0		;NOT ALL MACHINES ARE BUSY

DO_FINISH
LD R0, BACKUP_R0_x3700
LD R1, BACKUP_R1_x3700

LD R3, BACKUP_R3_x3700
LD R4, BACKUP_R4_x3700
LD R5, BACKUP_R5_x3700
LD R6, BACKUP_R6_x3700
LD R7, BACKUP_R7_x3700

RET

;HINT Restore
BACKUP_R0_x3700 .BLKW #1
BACKUP_R1_x3700 .BLKW #1
BACKUP_R2_x3700 .BLKW #1
BACKUP_R3_x3700 .BLKW #1
BACKUP_R4_x3700 .BLKW #1
BACKUP_R5_x3700 .BLKW #1
BACKUP_R6_x3700 .BLKW #1
BACKUP_R7_x3700 .BLKW #1

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000
DEC_0 				.FILL #0
DEC_1 				.FILL #1
DEC_16				.FILL #16


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x3900

;HINT back up 
ST R0, BACKUP_R0_x3900
ST R1, BACKUP_R1_x3900
ST R2, BACKUP_R2_x3900
ST R3, BACKUP_R3_x3900
ST R4, BACKUP_R4_x3900
ST R5, BACKUP_R5_x3900
ST R6, BACKUP_R6_x3900
ST R7, BACKUP_R7_x3900

LD R1, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R3, R1, #0

LD R4, DEC2_16		;TO GO 16 TIMES

FOR_LOOPP
  ADD R3, R3, #0
  BRn MACHINE_FREE
  BRzp MACHINE_NOT_FREE

MACHINE_FREE
  ADD R4, R4, #-1
  BRz FINISHING_FUNC

  ADD R3, R3, R3

  ADD R4,R4, #0

BRp FOR_LOOPP

FINISHING_FUNC
  LD R2, DEC2_1
  BRnzp GO_TO_FINISH

MACHINE_NOT_FREE
  LD R2, DEC2_0

GO_TO_FINISH
LD R0, BACKUP_R0_x3900
LD R1, BACKUP_R1_x3900
;ST R2, BACKUP_R2_x3900
LD R3, BACKUP_R3_x3900
LD R4, BACKUP_R4_x3900
LD R5, BACKUP_R5_x3900
LD R6, BACKUP_R6_x3900
LD R7, BACKUP_R7_x3900
RET

;HINT Restore
BACKUP_R0_x3900 .BLKW #1
BACKUP_R1_x3900 .BLKW #1
BACKUP_R2_x3900 .BLKW #1
BACKUP_R3_x3900 .BLKW #1
BACKUP_R4_x3900 .BLKW #1
BACKUP_R5_x3900 .BLKW #1
BACKUP_R6_x3900 .BLKW #1
BACKUP_R7_x3900 .BLKW #1
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000
DEC2_0 				.FILL #0
DEC2_1 				.FILL #1
DEC2_16 			.FILL #16

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x4100
;HINT back up 
ST R0, BACKUP_R0_x4100
ST R1, BACKUP_R1_x4100
ST R2, BACKUP_R2_x4100
ST R3, BACKUP_R3_x4100
ST R4, BACKUP_R4_x4100
ST R5, BACKUP_R5_x4100
ST R6, BACKUP_R6_x4100
ST R7, BACKUP_R7_x4100

LD R1, BUSYNESS_ADDR_NUM_BUSY_MACHINES

LDR R3, R1, #0
LD R5, HEX_30
LD R2, DEC3_0
LD R4, DEC3_16

FOR_LOOPP2
ADD R3,R3, #0
BRzp MACHINE_BUSY2
BRn MACHINE_NOT_BUSY2

MACHINE_BUSY2
ADD R2, R2, #1

MACHINE_NOT_BUSY2
ADD R4,R4, #-1
BRz FINISHING_FUNC2

ADD R3,R3, R3
ADD R4,R4, #0
BRp FOR_LOOPP2

FINISHING_FUNC2
ADD R3, R2, #0
LD R4, DEC3_0
ADD R3, R3, #-10
BRzp IF_PASSES
BRn ONE_DIGIT

IF_PASSES
ADD R4, R4, #1
ADD R0, R4, R5
OUT
ADD R0, R3, R5
OUT
BRnzp FINISHED

ONE_DIGIT
ADD R0, R2, R5
OUT


;HINT Restore
FINISHED
LD R0, BACKUP_R0_x4100
LD R1, BACKUP_R1_x4100
;LD R2, BACKUP_R2_x3500
LD R3, BACKUP_R3_x4100
LD R4, BACKUP_R4_x4100
LD R5, BACKUP_R5_x4100
LD R6, BACKUP_R6_x4100
LD R7, BACKUP_R7_x4100

RET

BACKUP_R0_x4100 .BLKW #1
BACKUP_R1_x4100 .BLKW #1
BACKUP_R2_x4100 .BLKW #1
BACKUP_R3_x4100 .BLKW #1
BACKUP_R4_x4100 .BLKW #1
BACKUP_R5_x4100 .BLKW #1
BACKUP_R6_x4100 .BLKW #1
BACKUP_R7_x4100 .BLKW #1

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000
DEC3_16 			.FILL #16
DEC3_0 				.FILL #0
HEX_30 				.FILL x30

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x4300
;HINT back up 

ST R0, BACKUP_R0_x4300
ST R1, BACKUP_R1_x4300
ST R2, BACKUP_R2_x4300
ST R3, BACKUP_R3_x4300
ST R4, BACKUP_R4_x4300
ST R5, BACKUP_R5_x4300
ST R6, BACKUP_R6_x4300
ST R7, BACKUP_R7_x4300

LD R1, BUSYNESS_ADDR_NUM_FREE_MACHINES

LDR R3, R1, #0
LD R5, HEX2_30
LD R2, DEC4_0
LD R4, DEC4_16

FOR_LOOPP3
  ADD R3, R3, #0
  BRn MACHINE_FREE2
  BRzp MACHINE_NOT_FREE2

MACHINE_FREE2
ADD R2, R2, #1

MACHINE_NOT_FREE2
ADD R4, R4, #-1

BRz FINISHING_FUNC3

ADD R3, R3, R3

ADD R4, R4, #0
BRp FOR_LOOPP3

FINISHING_FUNC3
  ADD R3, R2, #0
  LD R4, DEC4_0
  ADD R3, R3, #-10
  BRzp IF_PASSES2
  BRn ONE_DIGIT2

  IF_PASSES2
    ADD R4, R4, #1
    ADD R0, R4, R5
    OUT
    ADD R0, R3, R5
    OUT
  BRnzp FINISH

ONE_DIGIT2
  ADD R0, R2, R5
  OUT

FINISH
LD R0, BACKUP_R0_x4300
LD R1, BACKUP_R1_x4300
;LD R2, BACKUP_R2_x3500
LD R3, BACKUP_R3_x4300
LD R4, BACKUP_R4_x4300
LD R5, BACKUP_R5_x4300
LD R6, BACKUP_R6_x4300
LD R7, BACKUP_R7_x4300
RET

;HINT Restore
BACKUP_R0_x4300 .BLKW #1
BACKUP_R1_x4300 .BLKW #1
BACKUP_R2_x4300 .BLKW #1
BACKUP_R3_x4300 .BLKW #1
BACKUP_R4_x4300 .BLKW #1
BACKUP_R5_x4300 .BLKW #1
BACKUP_R6_x4300 .BLKW #1
BACKUP_R7_x4300 .BLKW #1

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000
DEC4_16 .FILL #16
DEC4_0 .FILL #0
HEX2_30 .FILL x30

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x4500
;HINT back up 
ST R0, BACKUP_R0_x4500
ST R1, BACKUP_R1_x4500
ST R2, BACKUP_R2_x4500
ST R3, BACKUP_R3_x4500
ST R4, BACKUP_R4_x4500
ST R5, BACKUP_R5_x4500
ST R6, BACKUP_R6_x4500
ST R7, BACKUP_R7_x4500

LD R5, BUSYNESS_ADDR_MACHINE_STATUS
LDR R4, R5, #0

ADD R6, R1, #-10
BRzp OVER_9
ADD R0, R3, #0
OUT

FIND_ITS_PLACE
  ADD R1, R1, #-1
  BRn FOUND_IT
  ADD R4, R4, R4
  BRnzp FIND_ITS_PLACE

OVER_9
  ADD R0, R3, #0
  OUT
  ADD R0, R2, #0
  OUT
  
FIND_ITS_PLACE2
  ADD R1, R1, #-1
  BRn FOUND_IT
  ADD R4, R4, R4
  BRnzp FIND_ITS_PLACE2

FOUND_IT
  ADD R2, R4, #0

LD R0, BACKUP_R0_x4500
LD R1, BACKUP_R1_x4500
LD R3, BACKUP_R3_x4500
LD R4, BACKUP_R4_x4500
LD R5, BACKUP_R5_x4500
LD R6, BACKUP_R6_x4500
LD R7, BACKUP_R7_x4500

RET

;HINT Restore
BACKUP_R0_x4500 .BLKW #1
BACKUP_R1_x4500 .BLKW #1
BACKUP_R2_x4500 .BLKW #1
BACKUP_R3_x4500 .BLKW #1
BACKUP_R4_x4500 .BLKW #1
BACKUP_R5_x4500 .BLKW #1
BACKUP_R6_x4500 .BLKW #1
BACKUP_R7_x4500 .BLKW #1
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x4700
;HINT back up 
ST R0, BACKUP_R0_x4700
ST R1, BACKUP_R1_x4700
ST R2, BACKUP_R2_x4700
ST R3, BACKUP_R3_x4700
ST R4, BACKUP_R4_x4700
ST R5, BACKUP_R5_x4700
ST R6, BACKUP_R6_x4700
ST R7, BACKUP_R7_x4700

LD R1, BUSYNESS_ADDR_FIRST_FREE

LDR R3, R1, #0
LD R5, HEXF_30
LD R2, DECF_0
LD R4, DECF_16


FOR_LOOPP4	
  ADD R3, R3, #0
  BRn FIRST_FREEM

    ADD R2, R2, #1
    ADD R6, R2, #-16
    BRz NOT_FREE_M
    ADD R4, R4, #-1
    BRz FINISHING_FUNC_4	

    ADD R3, R3, R3
    ADD R4, R4, #0
BRp FOR_LOOPP4	

NOT_FREE_M
ADD R2, R2, #0
BRnzp DONE
			
FIRST_FREEM

FINISHING_FUNC_4
  ADD R3, R2, #0
  LD R4, DECF_0
  ADD R3, R3, #-10
  BRzp PASSED_9
  BRn ONEDIGIT

  PASSED_9
    ADD R4, R4, #1
  BRnzp DONE

ONEDIGIT
DONE


;HINT Restore
LD R0, BACKUP_R0_x4700
LD R1, BACKUP_R1_x4700
;LD R2, BACKUP_R2_x3500
;LD R3, BACKUP_R3_x4700
;LD R4, BACKUP_R4_x4700
;LD R5, BACKUP_R5_x4700
LD R6, BACKUP_R6_x4700
LD R7, BACKUP_R7_x4700

RET

;HINT Restore
BACKUP_R0_x4700 .BLKW #1
BACKUP_R1_x4700 .BLKW #1
BACKUP_R2_x4700 .BLKW #1
BACKUP_R3_x4700 .BLKW #1
BACKUP_R4_x4700 .BLKW #1
BACKUP_R5_x4700 .BLKW #1
BACKUP_R6_x4700 .BLKW #1
BACKUP_R7_x4700 .BLKW #1


;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xD000
DECF_16 .FILL #16
HEXF_30 .FILL x30
DECF_0  .FILL #0
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4900

ST R0, BACKUP_R0_x4900
ST R1, BACKUP_R1_x4900
ST R2, BACKUP_R2_x4900
ST R3, BACKUP_R3_x4900
ST R4, BACKUP_R4_x4900
ST R5, BACKUP_R5_x4900
ST R6, BACKUP_R6_x4900
ST R7, BACKUP_R7_x4900

LD R2, NEGHEX2_30
LD R4, NDEC_58
LD R5, NEGHEX2_2F

ERROR_RESET

LEA R0, prompt
PUTS

  GETC
    OUT
  ADD R1, R0, #-10	
  BRz ERROR

  ADD R1, R0, R4
  BRzp ERROR

  ADD R1, R0, R5
  BRnz ERROR

  ADD R3, R0, #0
  ADD R2, R3, R2

  LD R4, NHEX2_36
  
  GETC
    OUT
  ADD R1, R0, #-10	
  BRz ENTER_DONE
  
  ADD R1, R2, #-1
  BRnp ERROR

  ADD R1, R0, R4
  BRzp ERROR

  ADD R1, R0, R5
  BRnz ERROR

  ADD R2, R2, R2
  ADD R4, R2, R2
  ADD R4, R4, R4
  ADD R4, R4, R2

  LD R2, NEGHEX2_30
  ADD R5, R0, R2
  ADD R1, R4, R5
  ADD R2, R0, #0
LD R0, BACKUP_R0_x4900
LD R4, BACKUP_R4_x4900
LD R5, BACKUP_R5_x4900
LD R6, BACKUP_R6_x4900
LD R7, BACKUP_R7_x4900

RET

ENTER_DONE
  ADD R1, R2, #0


LD R0, BACKUP_R0_x4900
LD R4, BACKUP_R4_x4900
LD R5, BACKUP_R5_x4900
LD R6, BACKUP_R6_x4900
LD R7, BACKUP_R7_x4900

RET

ERROR
  LD R0, NEW_LINE2
  OUT
  LEA R0, Error_message_2
  PUTS
  BRnzp ERROR_RESET


;HINT Restore
BACKUP_R0_x4900 .BLKW #1
BACKUP_R1_x4900 .BLKW #1
BACKUP_R2_x4900 .BLKW #1
BACKUP_R3_x4900 .BLKW #1
BACKUP_R4_x4900 .BLKW #1
BACKUP_R5_x4900 .BLKW #1
BACKUP_R6_x4900 .BLKW #1
BACKUP_R7_x4900 .BLKW #1

;---------------	
;Data
;---------------
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "ERROR INVALID INPUT\n"
NDEC_58	.FILL	#-58
NEGHEX2_2F .FILL -x2F
NEGHEX2_30	.FILL	-x30
NHEX2_36 .FILL -x36
NEW_LINE2 .FILL x0A
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

;--------------------------------
;Data for subroutine print number
;--------------------------------



.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD000			; Remote data
BUSYNESS .FILL x0000		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END