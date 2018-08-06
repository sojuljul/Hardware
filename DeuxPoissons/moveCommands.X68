*-----------------------------------------------------------
* Title      : Disassembler - CSS 422
* Written by : Kien Chin & Juliano Nguyen
* Date       : 5/23/17
* Description: Move Opcode Section
*-----------------------------------------------------------

MOVE_OPERANDS  
        
        ;SOURCE SWITCH STATMENT
              
        MOVE.L  D6,D7
        AND.W   #$0038,D7
        
        CMP.W   #$0000,D7       ;CHECK FOR DATA REGISTER
        BEQ     MOVE_SDR
        
        CMP.W   #$0008,D7       ;CHECK FOR ADDRESS REGISTER
        BEQ     MOVE_SAR
        
        CMP.W   #$0010,D7       ;CHECK FOR ADDRESS REGISTER ()
        BEQ     MOVE_SARP
        
        CMP.W   #$0018,D7       ;CHECK FOR ADDRESS REGISTER POST INCREMENT
        BEQ     MOVE_SARPI
        
        CMP.W   #$0020,D7       ;CHECK FOR ADDRESS REGISTER PRE DECREMENT
        BEQ     MOVE_SARPD
        
        CMP.W   #$0038,D7       ;CHECK FOR VALUE (WORD,LONG,HASHTAG)
        BEQ     MOVE_SV
        
MOVE_CONT
        ;DESTINATION SWITCH STATEMENT
        ;D6 DATA
        ;D7 TEMP TO COMPARE
        MOVE.L  D6,D7
        AND.W   #$01C0,D7
        
        CMP.W   #$0000,D7       ;CHECK FOR DATA REGISTER
        BEQ     MOVE_DDR
        
        CMP.W   #$0080,D7       ;CHECK FOR ADDRESS REGISTER ()
        BEQ     MOVE_DARP
        
        CMP.W   #$00C0,D7       ;CHECK FOR ADDRESS REGISTER POST INCREMENT
        BEQ     MOVE_DARPI
        
        CMP.W   #$0100,D7       ;CHECK FOR ADDRESS REGISTER PRE DECREMENT
        BEQ     MOVE_DARPD
        
        CMP.W   #$01C0,D7       ; CHECK FOR VALUE
        BEQ     MOVE_DV
        
        CMP.W   #$0040,D7
        BEQ     MOVE_DAR
        
MOVE_DONE
        RTS
        
        
;GO BETWEEN METHODS THAT CAN CALL THE SPECIFIC METHOD THEN BRANCH TO THE NEXT SECTION
MOVE_SDR
        JSR     SDR
        BRA     MOVE_DONE
MOVE_SAR
        JSR     SAR
        BRA     MOVE_DONE
MOVE_SARP
        JSR     SARP
        BRA     MOVE_DONE
MOVE_SARPI
        JSR     SARPI
        BRA     MOVE_DONE
MOVE_SARPD
        JSR     SARPD
        BRA     MOVE_DONE
MOVE_SV
        ;JSR     HASHTAG
        MOVE.L  D6,D7
        AND.W   #$0007,D7
        
        CMP.W   #$0000,D7       ; reg
        BEQ     MOVE_SVW
        
        CMP.W   #$0001,D7
        BEQ     MOVE_SVL
        
        CMP.W   #$0004,D7
        BEQ     MOVE_SHT
        
        BRA     MOVE_DONE

MOVE_SVW
        ;JSR     HASHTAG
        JSR     SVW
        BRA     MOVE_DONE
MOVE_SVL   
        ;JSR     HASHTAG     
        JSR     SVL
        BRA     MOVE_DONE
        
MOVE_SHT
        JSR     HASHTAG
     
        MOVE.W  D6,D7
        AND.W   #$F0C0,D7
        
        CMP.W   #$D0C0,D7
        BEQ     ADDA_SPECIAL    

        MOVE.W  D6,D7
        AND.W   #$01C0,D7    
        
        CMP.W   #$00C0,D7
        BEQ     DIVU_SPECIAL
        
        CMP.W   #$01C0,D7
        BEQ     MULS_SPECIAL
        
        MOVE.L  D6,D5
        AND.W   #$3000,D5
        
        CMP.W   #$2000,D5
        BEQ     MOVE_SHTL
        
*        CMP.W   #$1000,D5   ; ADDA.W immediate
*        BEQ     MOVE_SHTW
        
        MOVE.W  D6,D5       ; SPECIAL CASE FOR SIZE ON BITS 8,9 (LIGHT PURPLE)
        AND.W   #$00C0,D5

        CMP.W   #$0000,D5
        BEQ     MOVE_SHTW

        CMP.W   #$0080,D5
        BEQ     MOVE_SHTL

        CMP.W   #$0040,D5
        BEQ     MOVE_SHTW
        
*        CMP.W   #$00C0,D5
*        BEQ     MOVE_SHTW

        BRA     MOVE_DONE

DIVU_SPECIAL
        JSR     SHTW
        RTS
        
MULS_SPECIAL
        JSR     SHTW
        RTS        

ADDA_SPECIAL
        MOVE.W  D6,D7
        AND.W   #$0100,D7
        
        CMP.W   #$0000,D7
        BEQ     SHTW_HELPER
        
        CMP.W   #$0100,D7
        BEQ     SHTL_HELPER
        
        BRA     MOVE_DONE
        
SHTW_HELPER
        JSR     SHTW
        BRA     MOVE_DONE
        
SHTL_HELPER        
        JSR     SHTL
        BRA     MOVE_DONE     
   
MOVE_SHTL
        JSR     SHTL
        BRA     MOVE_DONE
        
MOVE_SHTW
        JSR     SHTW
        BRA     MOVE_DONE        
        
MOVE_DDR
        JSR     DDR
        BRA     MOVE_DONE
MOVE_DARP
        JSR     DARP
        BRA     MOVE_DONE
MOVE_DARPI
        JSR     DARPI
        BRA     MOVE_DONE
MOVE_DARPD
        JSR     DARPD
        BRA     MOVE_DONE
MOVE_DV
        MOVE.L  D6,D7
        AND.W   #$0E00,D7
        
        CMP.W   #$0200,D7
        BEQ     MOVE_DVL
        
        CMP.W   #$0000,D7
        BEQ     MOVE_DVW

        
MOVE_DVW
        JSR     SVW
        BRA     MOVE_DONE
MOVE_DVL
        JSR     SVL
        BRA     MOVE_DONE
MOVE_DAR
        JSR     DAR
        BRA     MOVE_DONE        


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
