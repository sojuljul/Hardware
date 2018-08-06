*-----------------------------------------------------------
* Title      : Disassembler - CSS 422
* Written by : Kien Chin & Juliano Nguyen
* Date       : 5/23/17
* Description: Disassembler Main Program
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

********************
* Input / Output
********************
    LEA     MESSAGE,A1  ; welcome msg
    MOVE.B  #14,D0
    TRAP    #15

NEW_START    LEA     PROMPT_START,A1     ; prompt for start location
             MOVE.B  #14,D0
             TRAP    #15
             MOVE.L      #$00000000,A1
    
    MOVE.B  #2,D0               ; read string
    TRAP    #15                 ; store in (A1), length in D1
        
    CMPI.B  #$8,D1
    BLT     LOW_CHAR
    
    CMPI.B  #$8,D1
    BGT     HIGH_CHAR
    
    JSR     ASCTOHEX            ; D3 contains string
    
    CMP.L   #$00007000,D3       ; check if < $00007000
    BLT     LOW_ADDR
    
    JSR     CHECK_ODD           ; check if odd addr
    
    MOVE.L  D3,D4               ; D4 <- D3
    
    CLR.L   D3                  ; clear D3

    LEA     PROMPT_END,A1       ; prompt for end location
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.L  #$00000000,A1

    MOVE.B  #2,D0               ; read string
    TRAP    #15                 ; store in (A1), length in D1
    
    CMPI.B  #$8,D1
    BLT     LOW_CHAR
    
    CMPI.B  #$8,D1
    BGT     HIGH_CHAR
    
    JSR     ASCTOHEX            ; D3 contains string
    
    JSR     CHECK_ODD           ; check if odd addr
    
    MOVE.L  D3,D5               ; D5 <- D3
    
    CMP.L   D5,D4               ; D4 >= D5 ?
    BGE     HIGH_ADDR
    
    MOVE.L  D4,A2               ; A2 <- start
    MOVE.L  D5,A3               ; A3 <- end
    MOVE.B  #$A,D3
    ; D4, A2 start
    ; D5, A3 end

********************
* ADDRESS LOOP
* Display memory address and opcode/EA
********************    
ADDR_LOOP   
            CMP.B   #$0,D3          ;CHECK COUNTER
            BEQ     PAUSE
            SUB.B   #$1,D3
            
            LEA     NEW_LINE,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            CMP.L   A2,A3            ; compare if addr are complete
            BEQ     END_STAGE
            
            MOVE.L  A2,D4
            MOVE.L  #$8,D1

            
             JSR     HEXTOASC

            MOVE.L  (A1)+,(A4)+
            MOVE.L  (A1)+,(A4)+
            MOVE.L  #$00000000,A4
            MOVEA.L  A4,A1            
            MOVE.B  #14,D0
            TRAP    #15
            
*            MOVE.B  #15,D0           ; display unsigned # in D1.L
*            MOVE.B  #16,D2           ; convert to base 16
*            MOVE.L  A2,D1            ; print address
*            TRAP    #15
    
            MOVE.W  (A2)+,D6         ; D6 <- (A2) first 4 char
            BRA     TABLE
    
            ; D6 = 4 hex digit value
 
PAUSE  
        LEA     PAUSE_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #5,D0
        TRAP    #15
        
        MOVE.B  #$A,D3
        
        CMP.B   #13,D1
        BEQ     ADDR_LOOP
        
        BRA     END_STAGE

********************
* Table of Opcodes
* Each opcode category is separated by their own section
* Branches to that section if equal
********************
    
*            FIRST 4:	    F000 = OPCODE
*            NEXT 3:		0E00 = DEST REG
*            NEXT 3:		01C0 = DEST MODE
*            NEXT 3:		0038 = SOURCE MODE
*            NEXT 3:		0007 = SOURCE REG
TABLE
    ;CMP.B   #%0100,D6
    ;BEQ     OC_0100         ; if equal to '4'
    
    MOVE.W  D6,D7
    AND.W   #$F000,D7
    
    CMP		#$0000,D7
    BEQ		OC_0000

    CMP 	#$1000,D7		;MOVE.B
    BEQ		OC_0001

    CMP 	#$2000,D7		;MOVE.L
    BEQ		OC_0010

    CMP 	#$3000,D7		;MOVE.W
    BEQ		OC_0011

    CMP 	#$4000,D7		;MISC (NOP, RTS)
    BEQ		OC_0100

    CMP 	#$5000,D7		;ADDQ/SUBQ/SCC/DBCC
    BEQ		OC_0101

    CMP 	#$6000,D7		;BSR/BRA/BCC
    BEQ		OC_0110

    CMP 	#$7000,D7		;MOVEQ
    BEQ		OC_0111

    CMP 	#$8000,D7		;OR/DIV/SBCD    
    BEQ		OC_1000

    CMP 	#$9000,D7		;SUB/SUBX
    BEQ		OC_1001
    
    CMP 	#$A000,D7		;NA
    BEQ		OC_1010

    CMP 	#$B000,D7		;CMP/EOR
    BEQ		OC_1011

    CMP 	#$C000,D7		;AND/ADDA/ADDX
    BEQ		OC_1100

    CMP 	#$D000,D7		;ADD/ADDA/ADDX
    BEQ		OC_1101

    CMP 	#$E000,D7		;SHIFT/ROTATE
    BEQ		OC_1110

    CMP 	#$F000,D7		;SPECIAL/RESERVED
    BEQ		OC_1111
    
********************
* ADDI,SUBI
********************
OC_0000
    JSR     Opcode0000
    BRA     ADDR_LOOP
    
Opcode0000
    MOVE.W  D6,D7
    AND.W   #$0600,D7
    
    CMP.W   #$0600,D7
    BEQ     ADDI_STUFF
    
    CMP.W   #$0400,D7
    BEQ     SUBI_STUFF
    
    ;otherwise
    JSR     BAD_DATA
    RTS
    
ADDI_STUFF
    LEA     STR_ADDI,A1
    MOVE.B  #14,D0
    TRAP    #15
    BRA     Opcode0000_SIZE
    
SUBI_STUFF
    LEA     STR_SUBI,A1
    MOVE.B  #14,D0
    TRAP    #15    

Opcode0000_SIZE
    JSR     GET_SIZE    
    
    JSR     HASHTAG
    
    MOVE.W  D6,D7
    AND.W   #$00C0,D7

    CMP.W   #$0000,D7
    BEQ     OC0000_WORD
    
    CMP.W   #$0040,D7
    BEQ     OC0000_WORD
    
    CMP.W   #$0080,D7
    BEQ     OC0000_LONG
    
Opcode0000_CONT    
    JSR     COMMA
    JSR     MOVE_OPERANDS
    
    RTS
    
OC0000_WORD
    JSR     SHTW
    BRA     Opcode0000_CONT

OC0000_LONG
    JSR     SHTL
    BRA     Opcode0000_CONT
    
    

********************
* MOVE.B
********************
OC_0001
        
        LEA     STR_MOVE,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        JSR     PRT_SIZE_B
        
        JSR     MOVE_OPERANDS
        JSR     COMMA
        JSR     MOVE_CONT
        
        BRA     ADDR_LOOP

        
********************
* MOVE.L
********************        
OC_0010
        MOVE.W  D6,D7
        AND.W   #$01C0,D7
        
        CMP.W   #$0040,D7
        BEQ     PRT_MOVEAL
        
        LEA     STR_MOVE,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     MOVEL_CONT
        
PRT_MOVEAL
        LEA     STR_MOVEA,A1
        MOVE.B  #14,D0
        TRAP    #15       
        
MOVEL_CONT         
        
        JSR     PRT_SIZE_L
        
        JSR     MOVE_OPERANDS
        JSR     COMMA
        JSR     MOVE_CONT
        
        BRA     ADDR_LOOP

********************
* MOVE.W
********************
OC_0011
        
        MOVE.W  D6,D7
        AND.W   #$01C0,D7
        
        CMP.W   #$0040,D7
        BEQ     PRT_MOVEAW
        
        LEA     STR_MOVE,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     MOVEW_CONT
        
PRT_MOVEAW
        LEA     STR_MOVEA,A1
        MOVE.B  #14,D0
        TRAP    #15       
        
MOVEW_CONT        
        JSR     PRT_SIZE_W
        
        JSR     MOVE_OPERANDS
        JSR     COMMA
        JSR     MOVE_CONT
        
        BRA     ADDR_LOOP

********************
* NOP, RTS
********************
OC_0100
    *NOP
    MOVE.W  D6,D5
    CMP.W   #$4E71,D5
    BEQ     OC_NOP
    
    *RTS
    MOVE.W  D6,D5    
    CMP.W   #$4E75,D5
    BEQ     OC_RTS
    
    ;LEA
    MOVE.W  D6,D5
    AND.W   #$01C0,D5
    CMP.W   #$01C0,D5
    BEQ     PRT_LEA
    
    ;JSR
    MOVE.W  D6,D5
    AND.W   #$0F00,D5
    CMP.W   #$0E00,D5
    BEQ     PRT_JSR
    
    ;CLR
    MOVE.W  D6,D5
    AND.W   #$0200,D5
    CMP.W   #$0200,D5
    BEQ     PRT_CLR
    
    MOVE.W  D6,D5
    AND.W   #$0380,D5
    
    CMP.W   #$0080,D5
    BEQ     OP0100_MOVEM
    
    JSR     BAD_DATA
    BRA     ADDR_LOOP
    
OP0100_MOVEM    
    ;MOVEM
    LEA     STR_MOVEM,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    ;get size
    CLR.L   D5
    MOVE.W  (A2)+,D5
    MOVE.W  D6,D7
    AND.W   #$0040,D7
    
    CMP.W   #$0040,D7
    BEQ     OP0100_LONG
    
    BRA     OP0100_WORD
    
OP0100_LONG
    JSR     PRT_SIZE_L
    BRA     OP0100_CONT
OP0100_WORD
    JSR     PRT_SIZE_W
    BRA     OP0100_CONT
    
OP0100_CONT

    MOVE.W  D6,D7
    AND.W   #$0400,D7
    
    CMP.W   #$0400,D7
    BEQ     OP0100_POSTI      ;POSTINCREMENT
    
    BRA     OP0100_PRED      ;PREDECREMENT

OP0100_PRED
    JSR     Opcode0100
    JSR     COMMA
    JSR     MOVE_OPERANDS
    BRA     ADDR_LOOP
    
OP0100_POSTI
    JSR     MOVE_OPERANDS
    JSR     COMMA
    JSR     Opcode0100
    BRA     ADDR_LOOP
    
OC_NOP  
    LEA     STR_NOP,A1          ; print string
    MOVE.B  #14,D0
    TRAP    #15
    BRA     ADDR_LOOP
    
OC_RTS
    LEA     STR_RTS,A1          ; print string
    MOVE.B  #14,D0
    TRAP    #15
    BRA     ADDR_LOOP
    
PRT_LEA
    LEA     STR_LEA,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    MOVE.B  #$20,D1     ; PRINT SPACE
    MOVE.B  #6,D0
    TRAP    #15    
    
    JSR     MOVE_OPERANDS
    ;JSR     MOVE_CONT
    JSR     COMMA
    ;OUTPUT A
    MOVE.B  #$41,D1     ;A
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     DNUM
    
    ; print dest
    BRA     ADDR_LOOP
    
PRT_JSR
    LEA     STR_JSR,A1
    MOVE.B  #14,D0
    TRAP    #15

    MOVE.B  #$20,D1     ; PRINT SPACE
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     MOVE_OPERANDS
    
    BRA     ADDR_LOOP
    
PRT_CLR
    LEA    STR_CLR,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     GET_SIZE
    
    JSR     MOVE_OPERANDS
    
    BRA     ADDR_LOOP

********************
* ADDQ/SUBQ/SCC/DBCC
********************
OC_0101

    JSR     Opcode0101
    BRA     ADDR_LOOP
    
Opcode0101
    MOVE.W  D6,D7
    AND.W   #$0100,D7
    
    CMP.W   #$0000,D7
    BEQ     ADDQ_STUFF

    CMP.W   #$0100,D7
    BEQ     SUBQ_STUFF
    
    JSR     BAD_DATA
    RTS
    
ADDQ_STUFF
    LEA     STR_ADDQ,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    
Opcode0101_CONT
    JSR GET_SIZE

    JSR HASHTAG
    JSR DNUM
    JSR COMMA
    JSR MOVE_OPERANDS
    
    RTS

SUBQ_STUFF
    LEA     STR_SUBQ,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    BRA     Opcode0101_CONT
    
    

********************
* BSR/BRA/BCC
********************
OC_0110

    JSR     Opcode0110
    BRA     ADDR_LOOP

Opcode0110
    MOVE.W  D6,D7
    AND.W   #$0F00,D7

*    CMP.W   #$0100,D7
*    BEQ     BSR_STUFF

    CMP.W   #$0000,D7
    BEQ     BRA_STUFF

    BRA     BCOMP_STUFF

BRANCH_CONT
    MOVE.W  D6,D7
    AND.W   #$00FF,D7
    
    CMP.W   #$0000,D7
    BEQ     SIXTEEN_DISP

    CMP.W   #$00FF,D7
    BEQ     THIRTYTWO_DISP

    JSR     PRT_SIZE_B

    MOVE.L  D7,D4
    
    JSR     MONEY
    
    MOVE.B  #$8,D1
    JSR     HEXTOASC
    MOVE.B  #$8,D1
    MOVE.B  #1,D0
    TRAP    #15

    RTS

*BSR_STUFF
*    ;OUTPUT BSR
*    BRA     BRANCH_CONT


BRA_STUFF
    ;OUTPUT BRA
    LEA     STR_BRA,A1
    MOVE.B  #14,D0
    TRAP    #15
    BRA     BRANCH_CONT


BCOMP_STUFF
    MOVE.W  D6,D7
    AND.W   #$0F00,D7

    CMP.W   #$0400,D7
    BEQ     BCC_STUFF

    CMP.W   #$0C00,D7
    BEQ     BGE_STUFF

    CMP.W   #$0D00,D7
    BEQ     BLT_STUFF

    ;BAD DATA
    JSR     BAD_DATA
    RTS

BCC_STUFF
    ;OUTPUT BCC
    LEA     STR_BCC,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    BRA     BRANCH_CONT
    
BGE_STUFF
    ;OUTPUT BGE
    LEA     STR_BGE,A1
    MOVE.B  #14,D0
    TRAP    #15    
    BRA     BRANCH_CONT

BLT_STUFF
    ;OUTPUT BLT
    LEA     STR_BLT,A1
    MOVE.B  #14,D0
    TRAP    #15    
    BRA     BRANCH_CONT

SIXTEEN_DISP
    CLR     D5
    CLR     D4
    MOVE.W  (A2)+,D4
    
    JSR     PRT_SIZE_W
    
    JSR     MONEY
    
    MOVE.B  #$8,D1
    JSR     HEXTOASC
    MOVE.B  #$8,D1
    MOVE.B  #1,D0
    TRAP    #15
    
    RTS

THIRTYTWO_DISP
    CLR     D5
    CLR     D4
    MOVE.L  (A2)+,D4
    
    JSR     PRT_SIZE_L

    JSR     MONEY
    
    MOVE.B  #$8,D1
    JSR     HEXTOASC
    MOVE.B  #$8,D1
    MOVE.B  #1,D0
    TRAP    #15
    
    RTS

********************
* MOVEQ
********************
OC_0111

    LEA     STR_MOVEQ,A1
    MOVE.B  #14,D0
    TRAP    #15

    ;JSR     PRT_SIZE_L
    MOVE.B  #$20,D1     ;A
    MOVE.B  #6,D0
    TRAP    #15

    MOVE.W  D6,D7
    AND.W   #$00FF,D7

    JSR     HASHTAG
    JSR     MONEY                       *HERE
    MOVE.W  D7,D4       ; D4 for hextoasc
    MOVE.B  #8,D1

    JSR     HEXTOASC

    CLR     D1
    MOVE.B  #$8,D1
    MOVE.B  #1,D0
    TRAP    #15

    JSR     COMMA
    ;JSR     DDR
    MOVE.B  #$44,D1     ;A
    MOVE.B  #6,D0
    TRAP    #15

    JSR     DNUM
    BRA     ADDR_LOOP

********************
* OR/DIV/SBCD    
********************
OC_1000
    JSR     Opcode1000
    BRA     ADDR_LOOP
    
Opcode1000
    MOVE.W  D6,D7
    AND.W   #$01C0,D7
    
    CMP.W   #$00C0,D7
    BEQ     DIVU_STUFF
    
    MOVE.W  D6,D5       ;sbcd
    AND.W   #$01F0,D5
    
    CMP.W   #$0100,D5
    BEQ     INVALID_DATA
 
    MOVE.W  D6,D5       ;divs
    AND.W   #$01C0,D5
    
    CMP.W   #$01C0,D5
    BEQ     INVALID_DATA
 
    BRA     OR_STUFF

INVALID_DATA
    JSR     BAD_DATA
    RTS    
    
DIVU_STUFF    
    LEA     STR_DIVU,A1
    MOVE.B  #14,D0
    TRAP    #15    
    
    JSR     PRT_SIZE_W
    
    ;BRA     DATA_DEST
    JSR     MANUAL_HEX
    RTS
    
MANUAL_HEX
*    MOVE.W  (A2)+,D4
*    MOVE.B  #$8,D1
*    JSR     HEXTOASC
*    MOVE.B  #$8,D1
*    MOVE.B  #1,D0
*    TRAP    #15
    
    JSR     MOVE_OPERANDS
    
    JSR     COMMA
    
    MOVE.B  #$44,D1
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     DNUM
    
    RTS    

    
OR_STUFF
    LEA     STR_OR,A1
    MOVE.B  #14,D0
    TRAP    #15    

    JSR     GET_SIZE

    MOVE.W  D6,D7
    AND.W   #$0100,D7
    
    CMP.W   #$0100,D7
    BEQ     DATA_SOURCE   
    
    CMP.W   #$0000,D7
    BEQ     DATA_DEST
    RTS    

********************
* SUB/SUBX
********************
OC_1001
    JSR Opcode1001
    BRA ADDR_LOOP
    
Opcode1001
    MOVE.W  D6,D7
    AND.W   #$00C0,D7
    
    CMP.W   #$00C0,D7
    BEQ     SUBA_STUFF
    
    BRA     SUB_STUFF
    
SUB_STUFF
    LEA     STR_SUB,A1
    MOVE.B  #14,D0
    TRAP    #15    

    JSR     GET_SIZE

    MOVE.W  D6,D7
    AND.W   #$0100,D7
    
    CMP.W   #$0100,D7
    BEQ     DATA_SOURCE   
    
    CMP.W   #$0000,D7
    BEQ     DATA_DEST
    RTS
    
SUBA_STUFF
    LEA     STR_BAD,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    RTS


********************
* NA
********************
OC_1010
    JSR     BAD_DATA
    BRA     ADDR_LOOP

********************
* CMP/EOR
********************
OC_1011
    JSR     BAD_DATA
    BRA     ADDR_LOOP
    
********************
* MULS/AND
********************
OC_1100
    JSR     Opcode1100
    BRA     ADDR_LOOP
    
Opcode1100
    MOVE.W  D6,D7
    AND.W   #$01C0,D7
    
    CMP.W   #$01C0,D7
    BEQ     MULS_STUFF
    
    CMP.W   #$00C0,D7
    BEQ     INVALID_DATA
    
    BRA     AND_STUFF
    
    
MULS_STUFF    
    LEA     STR_MULS,A1
    MOVE.B  #14,D0
    TRAP    #15    
    
    JSR     PRT_SIZE_W
    
    JSR     MANUAL_HEX
    
    RTS
    
AND_STUFF
    LEA     STR_AND,A1
    MOVE.B  #14,D0
    TRAP    #15    

    JSR     GET_SIZE

    MOVE.W  D6,D7
    AND.W   #$0100,D7
    
    CMP.W   #$0100,D7
    BEQ     DATA_SOURCE   
    
    CMP.W   #$0000,D7
    BEQ     DATA_DEST
    RTS


********************
* ADD/ADDA/ADDX
********************
OC_1101
    JSR Opcode1101
    BRA ADDR_LOOP
    
Opcode1101
    MOVE.W  D6,D7
    AND.W   #$00C0,D7
    
    
    CMP.W   #$00C0,D7
    BEQ     ADDA_STUFF
    
    BRA     ADD_STUFF
    
ADD_STUFF
    LEA     STR_ADD,A1
    MOVE.B  #14,D0
    TRAP    #15    

    JSR     GET_SIZE

    MOVE.W  D6,D7
    AND.W   #$0100,D7
    
    CMP.W   #$0100,D7
    BEQ     DATA_SOURCE   
    
    CMP.W   #$0000,D7
    BEQ     DATA_DEST
    RTS
    
DATA_DEST
    JSR     MOVE_OPERANDS
    JSR     COMMA
    
    MOVE.B  #$44,D1     ;D
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     DNUM
    RTS

DATA_SOURCE       
    MOVE.B  #$44,D1     ;D
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     DNUM
    JSR     COMMA
    JSR     MOVE_OPERANDS
    RTS
    
ADDA_STUFF
    LEA     STR_ADDA,A1
    MOVE.B  #14,D0
    TRAP    #15
    
*    MOVE.W  D6,D7
*    AND.W   #$00C0,D7
*    
*    CMP.W   #$00C0,D7
*    BEQ     ADDA_STUFF
    
    MOVE.W  D6,D7
    AND.W   #$0100,D7
       
    CMP.W   #$0000,D7
    BEQ     ADDA_WORD
    
    CMP.W   #$0100,D7
    BEQ     ADDA_LONG
    
    
ADDA_WORD
    JSR     PRT_SIZE_W
    JSR     MOVE_OPERANDS
    ;JSR     SHTW
    BRA     ADDA_REGISTERS

ADDA_LONG
    JSR     PRT_SIZE_L
    JSR     MOVE_OPERANDS
    ;JSR     SHTL    
    
    
ADDA_REGISTERS    
    JSR     COMMA
    
    MOVE.B  #$41,D1     ;A
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     DNUM
    
    RTS

********************
* SHIFT/ROTATE
********************
OC_1110
    JSR     Opcode1110
    BRA     ADDR_LOOP

Opcode1110
   
*    MOVE.W  D6,D7
*    AND.W   #$0018,D7
*    CMP.W   #$0010,D7
*    BEQ     INVALID_DATA

    MOVE.W  D6,D7
    AND.W   #$00C0,D7
    
    CMP.W   #$00C0,D7   ;CHECK FOR ROTATION (REGISTER)
    BEQ     OP1110_REG
    
    *CMP.W   #$0000,D7
    *BEQ     OP1110_IM   ;CHECK FOR ROTATION (IMMEDIATE)
    BRA     OP1110_IM
    
    
OP1110_IM_CONT
    
    JSR     GET_SIZE
    
    MOVE.W  D6,D7
    AND.W   #$0020,D7
    
    CMP.W   #$0020,D7
    BEQ     OP1110_IM_DR
    
    BRA     OP1110_IM_V
    
OP1110_IM_NEXT
    JSR COMMA
    
    MOVE.B  #$44,D1     ;D
    MOVE.B  #6,D0
    TRAP    #15
    JSR     SNUM
    RTS
    
OP1110_CONT_REG
    JSR     PRT_SIZE_W
    JSR     MOVE_OPERANDS
    RTS
 
OP1110_REG
*    MOVE.W  D6,D7
*    AND.W   #$0EC0,D7
*    CMP.W   #$04C0,D7
*    BEQ     INVALID_DATA

    MOVE.W  D6,D7
    AND.W   #$0600,D7   ;GET BITS 
    
    CMP.W   #$0000,D7   ;CHECK FOR ASD
    BEQ     ASD_STUFF_REG
    
    CMP.W   #$0200,D7   ;CHECK FOR LSD ;)
    BEQ     LSD_STUFF_REG
    
    CMP.W   #$0600,D7   ;CHECK FOR ROD
    BEQ     ROD_STUFF_REG
    
OP1110_IM
    MOVE.W  D6,D7
    AND.W   #$0018,D7   ;GET BITS 
    
    CMP.W   #$0000,D7   ;CHECK FOR ASD
    BEQ     ASD_STUFF
    
    CMP.W   #$0008,D7   ;CHECK FOR LSD ;)
    BEQ     LSD_STUFF
    
    CMP.W   #$0018,D7   ;CHECK FOR ROD
    BEQ     ROD_STUFF
   
ASD_STUFF
    ;OUTPUT AS
    
    LEA     STR_AS,A1
    MOVE.B  #14,D0
    TRAP    #15
    

    JSR     DIRECTION
    BRA     OP1110_IM_CONT

LSD_STUFF
    ;OUTPUT LS
    
    LEA     STR_LS,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    

    JSR     DIRECTION
    BRA     OP1110_IM_CONT
    
ROD_STUFF
    ;OUTPUT RO
    
    LEA     STR_RO,A1
    MOVE.B  #14,D0
    TRAP    #15
    

    JSR     DIRECTION
    BRA     OP1110_IM_CONT
    
DIRECTION
    MOVE.W  D6,D7
    AND.W   #$0100,D7
    
    CMP.W   #$0000,D7
    BEQ     D_RIGHT
    
    ;OUTPUT L
    MOVE.B  #$4C,D1     ;L
    MOVE.B  #6,D0
    TRAP    #15
    RTS
D_RIGHT
    ;OUTPUT R
    MOVE.B  #$52,D1     ;R
    MOVE.B  #6,D0
    TRAP    #15
    RTS
    
    
ASD_STUFF_REG
    ;OUTPUT AS
    
    LEA     STR_AS,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    
    
    JSR     DIRECTION
    BRA     OP1110_CONT_REG

LSD_STUFF_REG
    ;OUTPUT LS
    
    LEA     STR_LS,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     DIRECTION
    BRA     OP1110_CONT_REG
    
ROD_STUFF_REG
    ;OUTPUT RO
    
    LEA     STR_RO,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    JSR     DIRECTION
    BRA     OP1110_CONT_REG
    
OP1110_IM_DR
    ;OUTPUT D
    MOVE.B  #$44,D1     ;D
    MOVE.B  #6,D0
    TRAP    #15
    
    JSR     DNUM
    BRA     OP1110_IM_NEXT
OP1110_IM_V
    ;OUTPUT #
    JSR     HASHTAG
    
    JSR     DNUM
    BRA     OP1110_IM_NEXT
    
********************
* SPECIAL/RESERVED
********************
OC_1111
    JSR     BAD_DATA
    BRA     ADDR_LOOP

********************
* Print 'DATA' if no code matches from above
********************
DATA    LEA     DATA_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        BRA     ADDR_LOOP

*BAD_DATA
*    LEA     STR_BAD,A1
*    MOVE.B  #14,D0
*    TRAP    #15
*    
*    BRA     ADDR_LOOP

********************
* End of Program
********************      
END_STAGE   LEA     END_MSG,A1      ; print end message
            MOVE.B  #14,D0
            TRAP    #15

            MOVE.B  #5,D0           ; read in char
            TRAP    #15
        
            CMP.B   #$51,D1         ; if 'Q'
            BEQ     FINISH          ; branch to finish
            BRA     RESTART         ; else, go back to start
        
FINISH  LEA     TY_MSG,A1   ; thank you message
        MOVE.B  #14,D0
        TRAP    #15
        
        MOVE.B  #9,D0       ; end program
        TRAP    #15
********************

********************
* Clears all registers
* Branch back to the start
********************    
RESTART
    MOVE.L      #$00000000,A1
    MOVE.L      #$00000000,A2
    MOVE.L      #$00000000,A3
    MOVE.L      #$00000000,A4
    MOVE.L      #$00000000,A5
    MOVE.L      #$00000000,A6
    CLR.L       D1    
    CLR.L       D2 
    CLR.L       D3 
    CLR.L       D4 
    CLR.L       D5 
    CLR.L       D6 
    BRA         NEW_START     

********************
* PRINT SIZE
********************

GET_SIZE
        MOVE.W  D6,D7
        AND.W   #$00C0,D7
        
        CMP.W   #$0000,D7
        BEQ     SIZE_B_JMP
        
        CMP.W   #$0040,D7
        BEQ     SIZE_W_JMP
        
        CMP.W   #$0080,D7
        BEQ     SIZE_L_JMP
        
SIZE_B_JMP
        BRA     PRT_SIZE_B
        
SIZE_W_JMP
        BRA     PRT_SIZE_W
        
SIZE_L_JMP
        BRA     PRT_SIZE_L
        
PRT_SIZE_B  
            MOVE.B  #$2E,D1     ; PRINT DECIMAL
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #$42,D1     ; PRINT B
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #$20,D1     ; PRINT SPACE
            MOVE.B  #6,D0
            TRAP    #15
            
            RTS
            
PRT_SIZE_L
            MOVE.B  #$2E,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #$4C,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #$20,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            RTS
            
PRT_SIZE_W  
            MOVE.B  #$2E,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #$57,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            MOVE.B  #$20,D1
            MOVE.B  #6,D0
            TRAP    #15
            
            RTS
            
COMMA
        MOVE.B  #$2C,D1         ;OUTPUT COMMA
        MOVE.B  #6,D0
        TRAP    #15
        
        RTS
        
MONEY   
        MOVE.B  #$24,D1         ; OUTPUT $
        MOVE.B  #6,D0
        TRAP    #15 
        
        RTS
        
HASHTAG
        MOVE.B  #$23,D1         ; OUTPUT #
        MOVE.B  #6,D0
        TRAP    #15
        
        RTS

GEN_ERROR
        LEA     ERROR_MSG,A1
        MOVE.B  #14,D0
        TRAP    #15
        
        BRA     ADDR_LOOP

*******************
* Display error for input being too short/too long
*******************
LOW_CHAR
    LEA     ERROR_CHARLOW,A1
    MOVE.B  #14,D0
    TRAP    #15
    BRA     NEW_START

HIGH_CHAR
    LEA     ERROR_CHARHIGH,A1
    MOVE.B  #14,D0
    TRAP    #15
    BRA     NEW_START
            
********************
* Display error for address being too low
********************            
LOW_ADDR
           LEA  ERROR_LOW_MSG,A1
           MOVE #14,D0
           TRAP #15
           
           CLR.L    D3
           
           BRA  NEW_START

********************
* Display error for address being too high (end > start)
********************           
HIGH_ADDR
            LEA     ERROR_HIGH_MSG,A1
            MOVE    #14,D0
            TRAP    #15
            
            CLR.L   D3
            BRA     NEW_START

********************
* Check for Odd address input
********************
CHECK_ODD  
            MOVE.L  D3,D5
            DIVU    #$2,D5
            SWAP    D5
            MOVE.B  D5,D6
            CMP.B   #1,D6
            BEQ     ODD_ERROR
            RTS
            
ODD_ERROR
            LEA     ERROR_ODD_MSG,A1
            MOVE.B  #14,D0
            TRAP    #15
            BRA     RESTART
********************


********************
* ASCII to HEX
* D1 = length; (A1) = string
* each character stored in stack is in HEX
********************
ASCTOHEX    CMPI.B  #$0,D1      ; is length = 0?
            BEQ     DONE        ; branch if equal
            MOVE.B  (A1)+,D2    ; D2 <- (A1) of one character
            CMPI.B  #$39,D2     ; is digit less than 9?
            BLE     NUM         ; branch if <=
    
* else its a letter
LETTER      SUBI.B  #$37,D2     ; D2 = D2 - $37
            BRA     UPDATE     ; branch to update
    
NUM         SUBI.B  #$30,D2     ; D2 = D2 - $30
            BRA     UPDATE     ; branch to update

UPDATE      SUBI.B  #$1,D1      ; D1 = D1 - 1, subtract 1 from length
            ADD.B   D2,D3       ; D3 = D3 + D2, Add letter to D3
            CMPI.B  #$0,D1      ; is length = 0?
            BEQ     DONE     ; branch if equal
    
* else, more characters to read from string
            ROL.L   #4,D3       ; rotate letter to left 4 bits
            BRA     ASCTOHEX     ; branch back to continue conversion

DONE        RTS ; return from ASCTOHEX
********************

;PASSED IN DATA IS IN D4
HEXTOASC
        *MOVEA.W A3,A1
        MOVEA.L A5,A4   ;4 POINTS TO A5'S STARTING POSITION
        MOVE.L      #$00000000,A1
        MOVE.L      #$00000000,A4
        MOVE.L      #$00000000,A5
HEXTOASC_CONT
        CMPI.B  #$0,D1
        BEQ     NEW_DONE

        ROL.L   #4,D4
        MOVE.W  #$000F,D5
        AND.W   D4,D5       ; D5 changed 000x
        CMPI.B  #$A,D5
        BLT     NEW_NUM

        ADDI.B  #$37,D5         ; letter
        MOVE.B  D5,(A5)+
        BRA NEW_UPDATE

NEW_NUM
        ADDI.B  #$30,D5
        MOVE.B  D5,(A5)+
        BRA NEW_UPDATE

NEW_UPDATE
        SUBI.B  #$1,D1          ; decrement count
        BRA HEXTOASC_CONT

NEW_DONE    
        MOVEA.L A4,A1
        RTS


    INCLUDE 'moveCommands.X68'
    INCLUDE 'helperMethods.X68'
    INCLUDE '0100opcode.X68'

    SIMHALT             ; halt simulator

********************
* VARIABLES
********************
CR  EQU $0D
LF  EQU $0A
DATA_MSG        DC.B    '       DATA',0
STR_NOP         DC.B    '       NOP',0
STR_RTS         DC.B    '       RTS',0
STR_MOVE        DC.B    '       MOVE',0 
STR_MOVEQ       DC.B    '       MOVEQ',0
STR_MOVEA       DC.B    '       MOVEA',0
STR_MOVEM       DC.B    '       MOVEM',0
STR_ADD         DC.B    '       ADD',0
STR_ADDA        DC.B    '       ADDA',0
STR_ADDI        DC.B    '       ADDI',0
STR_ADDQ        DC.B    '       ADDQ',0
STR_AND         DC.B    '       AND',0
STR_AS          DC.B    '       AS',0
;STR_ASR         DC.B    '       ASR',0
STR_BCC         DC.B    '       BCC',0
STR_BLT         DC.B    '       BLT',0
STR_BGE         DC.B    '       BGE',0
STR_DIVU        DC.B    '       DIVU',0
STR_JSR         DC.B    '       JSR',0
STR_LEA         DC.B    '       LEA',0
STR_LS          DC.B    '       LS',0
;STR_LSR         DC.B    '       LSR',0
STR_MULS        DC.B    '       MULS',0
STR_OR          DC.B    '       OR',0
STR_RO          DC.B    '       RO',0
;STR_ROR         DC.B    '       ROR',0
STR_SUB         DC.B    '       SUB',0
STR_SUBI        DC.B    '       SUBI',0
STR_BRA         DC.B    '       BRA',0
STR_SUBQ        DC.B    '       SUBQ',0
STR_SUBA        DC.B    '       SUBA',0
STR_CLR         DC.B    '       CLR',0


********************
* MESSAGES
********************
MESSAGE         DC.B    '                            ____      ____       ',CR,LF
                DC.B    '                           |    \    |  _ \      ',CR,LF
                DC.B    '    _///_        o         |  _  \   | | \ \     ',CR,LF
                DC.B    '   /o    \/     o          | | \  |  | |  | |    ',CR,LF
                DC.B    '   > ))_./\    o           | |  | |  | |_/ /     ',CR,LF
                DC.B    '      <       o _///_      | |  | |  |  __/      ',CR,LF
                DC.B    '               /o    \/    | |_/  |  | |         ',CR,LF
                DC.B    '               > ))_./\    |     /   | |         ',CR,LF
                DC.B    '                  <        |____/    |_|         ',CR,LF
                DC.B    '                                                 ',CR,LF
                DC.B    'Welcome to the Professor Chin and Dr. Nguyen Disassembler',CR,LF
                DC.B    'You must enter a start address at 00007000',0
PROMPT_START    DC.B    CR,LF,'Enter starting location: ',0
PROMPT_END      DC.B    'Enter ending location: ',0
END_MSG         DC.B    CR,LF,'Press "Q" to quit the program',CR,LF
                DC.B    'Otherwise, it will restart: ',0
TY_MSG          DC.B    CR,LF,CR,LF,'Thank you for using our program!'
                DC.B    CR,LF,'Have a lovely day! :)',0
NEW_LINE        DC.B    CR,LF,0

********************
* ERROR MESSAGES
********************
ERROR_LOW_MSG   DC.B    '********************',CR,LF
                DC.B    'Address is too low',CR,LF
                DC.B    '********************',CR,LF,0
                
ERROR_HIGH_MSG  DC.B    '********************',CR,LF
                DC.B    'Start address cannot be higher than or equal to End address',CR,LF
                DC.B    '********************',CR,LF,0
                
ERROR_ODD_MSG   DC.B    '********************',CR,LF
                DC.B    'Address cannot be an odd value',CR,LF
                DC.B    '********************',CR,LF,0
                
ERROR_MSG       DC.B    'INVALID DATA'

ERROR_CHARLOW   DC.B    '********************',CR,LF
                DC.B    'Input is too short. It must be 8 hexadecimals long',CR,LF
                DC.B    '********************',CR,LF,0
ERROR_CHARHIGH  DC.B   '********************',CR,LF
                DC.B    'Input is too large. It must be 8 hexadecimals long',CR,LF
                DC.B    '********************',CR,LF,0
                
PAUSE_MSG       DC.B    CR,LF,'PAUSED, PRESS ENTER TO CONTINUE',CR,LF
                DC.B    'ELSE THE PROGRAM WILL END',CR,LF,0
                             

    END    START        ; last line of source


















































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
