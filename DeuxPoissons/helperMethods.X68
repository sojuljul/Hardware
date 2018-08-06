*-----------------------------------------------------------
* Title      : Disassembler - CSS 422
* Written by : Kien Chin & Juliano Nguyen
* Date       : 5/23/17
* Description: Helper Methods - EA Section
*-----------------------------------------------------------

********************
* Helper Methods EA
********************        

BAD_DATA
    LEA     STR_BAD,A1
    MOVE.B  #14,D0
    TRAP    #15
    
    RTS
        
SDR
        
        MOVE.B  #$44,D1         ;OUTPUT 'D'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     SNUM            ;OUTPUT THE NUMBER
       
        
        RTS
        
SAR
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     SNUM
        
        
        
        RTS
        
SARP ; SOURCE ADDRESS () REGISTER
        
        ;CHANGE TO (A
        MOVE.B  #$28,D1         ;OUTPUT '('
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     SNUM
        
        ;CHANGE TO )
        MOVE.B  #$29,D1         ;OUTPUT ')'
        MOVE.B  #6,D0
        TRAP    #15
        
        
        
        RTS
        
SARPI
        ;CHANGE TO (A
        MOVE.B  #$28,D1         ;OUTPUT '('
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     SNUM
        
        ;CHANGE TO )+
        MOVE.B  #$29,D1         ;OUTPUT ')'
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$2B,D1         ;OUTPUT '+'
        MOVE.B  #6,D0
        TRAP    #15
        
        
        
        RTS
        
SARPD
        ;CHANGE TO -(A
        MOVE.B  #$2D,D1         ;OUTPUT '-'
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$28,D1         ;OUTPUT '('
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     SNUM
        
        ;CHANGE TO )
        MOVE.B  #$29,D1         ;OUTPUT ')'
        MOVE.B  #6,D0
        TRAP    #15
        
        
        
        RTS
        
SVW
        JSR     MONEY

        CLR.L     D4
        MOVE.W  (A2)+,D4
        
        CLR.L     D5
        
        MOVE.B  #$8,D1
        
        JSR     HEXTOASC
        
        MOVE.B  #$8,D1
        MOVE.B  #1,D0
        TRAP    #15   
        RTS     
SVL

        JSR     MONEY
        
        CLR.L     D4
        MOVE.L (A2)+,D4   
            
        CLR.L     D5
        
        MOVE.B  #$8,D1
        
        JSR     HEXTOASC
        
        MOVE.B  #$8,D1
        MOVE.B  #1,D0
        TRAP    #15
        RTS

SHTW
        CLR.L     D4
        MOVE.W  (A2)+,D4
        
        CLR.L     D1
        MOVE.W  D4,D1
        
        JSR     MONEY
        MOVE.B  #$8,D1
        JSR     HEXTOASC
        MOVE.B  #$8,D1
        MOVE.B  #1,D0
        TRAP    #15
        
        
        
        RTS
        
SHTL   
        CLR.L     D4
        MOVE.L  (A2)+,D4
        
        CLR.L     D1
        MOVE.L  D4,D1
        
        JSR     MONEY
        MOVE.B  #$8,D1
        JSR     HEXTOASC
        MOVE.B  #$8,D1
        MOVE.B  #1,D0
        TRAP    #15
        
        
        
        RTS

SNUM
        MOVE.L  D6,D7       
        AND.W   #$0007,D7       ;GET SOURCE REG => D7
        
        CLR.L   D1
        MOVE.B  D7,D1           ;MOVE LAST BYTE INTO D1
        
        MOVE.B  #3,D0           ;OUTPUT SOURCE REG
        TRAP    #15
        
        
        
        RTS
        

        
DDR

        MOVE.B  #$44,D1         ;OUTPUT 'D'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     DNUM
        
        RTS      

DARP
        ;CHANGE TO (A
        MOVE.B  #$28,D1         ;OUTPUT '('
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     DNUM
        
        ;CHANGE TO )
        MOVE.B  #$29,D1         ;OUTPUT ')'
        MOVE.B  #6,D0
        TRAP    #15
        
        RTS
        
DARPI
        ;CHANGE TO (A
        MOVE.B  #$28,D1         ;OUTPUT '('
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     DNUM
        
        ;CHANGE TO )+
        MOVE.B  #$29,D1         ;OUTPUT ')'
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$2B,D1         ;OUTPUT '+'
        MOVE.B  #6,D0
        TRAP    #15
        
        RTS
        
DARPD
        ;CHANGE TO -(A
        MOVE.B  #$2D,D1         ;OUTPUT '-'
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$28,D1         ;OUTPUT '('
        MOVE.B  #6,D0
        TRAP    #15
        
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15
        
        JSR     DNUM
        
        ;CHANGE TO )
        MOVE.B  #$29,D1         ;OUTPUT ')'
        MOVE.B  #6,D0
        TRAP    #15
        
        RTS

DAR
        MOVE.B  #$41,D1         ;OUTPUT 'A'
        MOVE.B  #6,D0
        TRAP    #15 

        JSR     DNUM
        RTS    

DNUM
        
        MOVE.L  D6,D7           ;GET DEST REG  
        AND.W   #$0E00,D7
        
        CLR.L   D5              
        
        MOVE.B  #9,D5
        ROR.L   D5,D7
        CLR.L   D1
        MOVE.B  D7,D1
        
        MOVE.B  #3,D0
        TRAP    #15
        
        RTS

STR_BAD         DC.B    '       DATA',0










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
