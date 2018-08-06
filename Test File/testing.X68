*-----------------------------------------------------------
* Title      : Disassembler Project
* Written by : Kien Chin & Juliano Nguyen
* Date       : 4/21/17
* Description: Testing file for Disassembler
*-----------------------------------------------------------
    ORG    $7000
START:                  ; first instruction of program

    * NOP
    * MOVE, MOVEA, MOVEQ, MOVEM
    * ADD, ADDA, ADDI, ADDQ
    * SUB, SUBI    
    * MULS, DIVU
    * LEA
    * AND, OR
    * LSL, LSR, ASL, ASR
    * ROL, ROR
    * Bcc (BCC, BLT, BGE)
    * JSR, RTS
    * BRA
    
*----- ADD -----
* s + Dn = Dn
    ADD.B   D0,D1       ; Dn
    ADD.W   D1,D2
    ADD.L   D2,D3
    
    ADD.W   A2,D2       ; An
    ADD.L   A3,D3
    
    ADD.B   (A1),D1     ; (An)
    ADD.W   (A2),D2
    ADD.L   (A3),D3
    
    ADD.B   (A1)+,D1    ; (An)+
    ADD.W   (A2)+,D2
    ADD.L   (A3)+,D3
    
    ADD.B   -(A1),D1    ; -(An)
    ADD.W   -(A2),D2
    ADD.L   -(A3),D3
    
    ADD.B   WORD_VAR,D1 ; xxx.W
    ADD.W   WORD_VAR,D2
    ADD.L   WORD_VAR,D3
    
    ADD.B   LONG_VAR,D1 ; xxx.L
    ADD.W   LONG_VAR,D2
    ADD.L   LONG_VAR,D3
    
    ADD.B   #10,D1          ; #n
    ADD.W   #WORD_VAR,D2
    ADD.L   #LONG_VAR,D3
    
*----- ADDA ------
* s + An = An
    ADDA.W  D0,A0       ; Dn
    ADDA.L  D1,A1
    
    ADDA.W  A1,A2       ; An
    ADDA.L  A2,A3
    
    ADDA.W  (A1),A2     ; (An)
    ADDA.L  (A2),A3
    
    ADDA.W  (A2)+,A2    ; (An)+
    ADDA.L  (A3)+,A3
    
    ADDA.W  WORD_VAR,A4 ; xxx.W
    ADDA.L  WORD_VAR,A5
    
    ADDA.W  LONG_VAR,A4 ; xxx.L
    ADDA.L  LONG_VAR,A5
            
    ADDA.W   #WORD_VAR,A2   ; #n
    ADDA.L   #LONG_VAR,A3
    
*----- ADDI -----
* #n + d = d
    ADDI.B  #10,D0      ; Dn
    ADDI.W  #1234,D1
    ADDI.L  #12345678,D2
    
    ADDI.B  #10,(A1)      ; (An)
    ADDI.W  #1234,(A2)
    ADDI.L  #12345678,(A3)
    
    ADDI.B  #10,(A1)+      ; (An)+
    ADDI.W  #1234,(A2)+
    ADDI.L  #12345678,(A3)+
    
    ADDI.B  #10,-(A1)      ; -(An)
    ADDI.W  #1234,-(A2)
    ADDI.L  #12345678,-(A3)
    
    ADDI.B  #10,WORD_VAR      ; xxx.W
    ADDI.W  #1234,WORD_VAR
    ADDI.L  #12345678,WORD_VAR
    
    ADDI.B  #10,LONG_VAR      ; xxx.L
    ADDI.W  #1234,LONG_VAR
    ADDI.L  #12345678,LONG_VAR
    
*----- ADDQ -----
    ADDQ.B  #1,D1      ; Dn
    ADDQ.W  #2,D2
    ADDQ.L  #3,D3
    
    ADDQ.W  #2,A2       ; An
    ADDQ.L  #3,A3
    
    ADDQ.B  #1,(A1)      ; (An)
    ADDQ.W  #2,(A2)
    ADDQ.L  #3,(A3)
    
    ADDQ.B  #1,(A1)+      ; (An)+
    ADDQ.W  #2,(A2)+
    ADDQ.L  #3,(A3)+
    
    ADDQ.B  #1,-(A1)      ; -(An)
    ADDQ.W  #2,-(A2)
    ADDQ.L  #3,-(A3)
    
    ADDQ.B  #1,WORD_VAR      ; xxx.W
    ADDQ.W  #2,WORD_VAR
    ADDQ.L  #3,WORD_VAR
    
    ADDQ.B  #1,LONG_VAR      ; xxx.L
    ADDQ.W  #2,LONG_VAR
    ADDQ.L  #3,LONG_VAR
    
*----- AND -----
    AND.B   D1,D2       ; x,Dn
    AND.W   D2,D3
    AND.L   D3,D4
    
    AND.B   (A1),D1
    AND.W   (A2),D2
    AND.L   (A3),D3
    
    AND.B   (A1)+,D1
    AND.W   (A2)+,D2
    AND.L   (A3)+,D3
    
    AND.B   -(A1),D1
    AND.W   -(A2),D2
    AND.L   -(A3),D3

    AND.B   WORD_VAR,D1
    AND.W   WORD_VAR,D2
    AND.L   WORD_VAR,D3

    AND.B   LONG_VAR,D1
    AND.W   LONG_VAR,D2
    AND.L   LONG_VAR,D3

    AND.B   #10,D1
    AND.W   #WORD_VAR,D2
    AND.L   #LONG_VAR,D3    
    
    AND.B   D1,(A1)         ; Dn,x
    AND.W   D2,(A2)
    AND.L   D3,(A3)
    
    AND.B   D1,(A1)+
    AND.W   D2,(A2)+
    AND.L   D3,(A3)+
    
    AND.B   D1,-(A1)
    AND.W   D2,-(A2)
    AND.L   D3,-(A3)

    AND.B   D1,WORD_VAR
    AND.W   D2,WORD_VAR
    AND.L   D3,WORD_VAR

    AND.B   D1,LONG_VAR
    AND.W   D2,LONG_VAR
    AND.L   D3,LONG_VAR
    
*----- ASL -----
    ASL.B   D1,D2       ; Dn,Dn
    ASL.W   D2,D3
    ASL.L   D3,D4
    
    ASL.B   #2,D1       ; #,Dn
    ASL.W   #4,D2
    ASL.L   #6,D3
    
    ASL.W   (A1)        ; destination
    ASL.W   (A2)+
    ASL.W   -(A3)
    ASL.W   WORD_VAR
    ASL.W   LONG_VAR
    
*----- ASR -----
    ASR.B   D1,D2       ; Dn,Dn
    ASR.W   D2,D3
    ASR.L   D3,D4
    
    ASR.B   #2,D1       ; #,Dn
    ASR.W   #4,D2
    ASR.L   #6,D3
    
    ASR.W   (A1)        ; destination
    ASR.W   (A2)+
    ASR.W   -(A3)
    ASR.W   WORD_VAR
    ASR.W   LONG_VAR   

*----- BRA -----
*----- Bcc (BCC, BLT, BGE) -----
            CMPI.W   #1234,D1
            BCC     CLEAR_YES       ; BCC
            BRA     NEXT
            
CLEAR_YES   ADD.B   #25,D1
NEXT        CMPI.W  #$8100,D2
            BLT     LESS_YES        ; BLT
            BRA     NEXT_TWO
            
LESS_YES    ADD.B   #25,D3
NEXT_TWO    CMPI.W  #$5000,D3
            BGE     GREAT_YES       ; BGE          
            
GREAT_YES   ADD.B   #25,D4
  
*----- DIVU -----
    DIVU.W  D0,D1       ; Dn
    DIVU.W  (A2),D2     ; (An)
    DIVU.W  (A3)+,D3    ; (An)+
    DIVU.W  -(A4),D4    ; -(An)
    DIVU.W  WORD_VAR,D5 ; xxx.W
    DIVU.W  LONG_VAR,D6 ; xxx.L
    DIVU.W  #2,D2
    
*----- JSR -----
    JSR FIRST_JUMP
    JSR (A1)            ; (An)
    JSR WORD_VAR        ; xxx.W
    JSR LONG_VAR        ; xxx.L
    
*----- LEA ------
    LEA (A0),A1
    LEA WORD_VAR,A2
    LEA LONG_VAR,A3
    LEA $1,A4
    
*----- LSL -----
    LSL.B   D1,D2       ; Dn,Dn
    LSL.W   D2,D3
    LSL.L   D3,D4
    
    LSL.B   #2,D1       ; #,Dn
    LSL.W   #4,D2
    LSL.L   #6,D3
    
    LSL.W   (A1)        ; destination
    LSL.W   (A2)+
    LSL.W   -(A3)
    LSL.W   WORD_VAR
    LSL.W   LONG_VAR
    
*----- LSR -----
    LSR.B   D1,D2       ; Dn,Dn
    LSR.W   D2,D3
    LSR.L   D3,D4
    
    LSR.B   #2,D1       ; #,Dn
    LSR.W   #4,D2
    LSR.L   #6,D3
    
    LSR.W   (A1)        ; destination
    LSR.W   (A2)+
    LSR.W   -(A3)
    LSR.W   WORD_VAR
    LSR.W   LONG_VAR
    
*----- MOVEQ ------
    MOVEQ.L   #10,D1
    MOVEQ.L   #$10,D2
    
*----- MOVEA ------
    MOVEA.W D1,A1       ; Dn
    MOVEA.L D2,A2
    
    MOVEA.W A1,A3       ; An
    MOVEA.L A2,A4
    
    MOVEA.W (A3),A1       ; (An)
    MOVEA.L (A4),A2
    
    MOVEA.W (A3)+,A1       ; (An)+
    MOVEA.L (A4)+,A2
    
    MOVEA.W -(A3),A1       ; -(An)
    MOVEA.L -(A4),A2
    
    MOVEA.W WORD_VAR,A1       ; xxx.W
    MOVEA.L WORD_VAR,A2
    
    MOVEA.W LONG_VAR,A1       ; xxx.L
    MOVEA.L LONG_VAR,A2
    
*----- MOVEM -----
    MOVEM.W D1-D3/A1-A3,(A1)        ; (An)
    MOVEM.W D1-D3/A1-A3,(A2)
    
    MOVEM.W D1-D3/A1-A3,-(A1)       ; -(An)
    MOVEM.W D1-D3/A1-A3,-(A2)
    
    MOVEM.W D1-D3/A1-A3,WORD_VAR    ; xxx.W
    MOVEM.W D1-D3/A1-A3,WORD_VAR

    MOVEM.W D1-D3/A1-A3,LONG_VAR    ; xxx.L
    MOVEM.W D1-D3/A1-A3,LONG_VAR
    
*----- MOVE -----
    MOVE.B  D0,D1
    MOVE.W  D1,D2
    MOVE.L  D2,D3
    
    MOVE.W  A2,D2
    MOVE.L  A3,D3
    
    MOVE.B  D1,(A1)
    MOVE.W  D2,(A2)
    MOVE.L  D3,(A3)
    
    MOVE.B  (A1),WORD_VAR
    MOVE.W  (A2),LONG_VAR
    MOVE.L  (A3),LONG_VAR
    
    MOVE.B  (A1)+,-(A2)
    MOVE.W  (A2)+,LONG_VAR
    MOVE.L  (A3)+,D3

    MOVE.B  -(A1),(A2)+
    MOVE.W  -(A2),D2
    MOVE.L  -(A3),LONG_VAR   

    MOVE.B  #10,D1
    MOVE.W  #WORD_VAR,D2
    MOVE.L  #LONG_VAR,D3
    
*----- MULS -----
    MULS.W    D1,D2       ; Dn
    MULS.W    (A1),D1     ; (An)
    MULS.W    (A2)+,D2    ; (An)+
    MULS.W    -(A3),D3    ; -(An)
    MULS.W    WORD_VAR,D4 ; xxx.W
    MULS.W    LONG_VAR,D5 ; xxx.L
    MULS.W    #2,D1
    
*----- NOP -----
    NOP
    
*----- OR -----
    OR.B    D1,D2       ; x,Dn
    OR.W    D2,D3
    OR.L    D3,D4
    
    OR.B    (A1),D1
    OR.W    (A2),D2
    OR.L    (A3),D3
    
    OR.B    (A1)+,D1
    OR.W    (A2)+,D2
    OR.L    (A3)+,D3
    
    OR.B    -(A1),D1
    OR.W    -(A2),D2
    OR.L    -(A3),D3

    OR.B    WORD_VAR,D1
    OR.W    WORD_VAR,D2
    OR.L    WORD_VAR,D3

    OR.B    LONG_VAR,D1
    OR.W    LONG_VAR,D2
    OR.L    LONG_VAR,D3

    OR.B    #10,D1
    OR.W    #WORD_VAR,D2
    OR.L    #LONG_VAR,D3    
    
    OR.B    D1,(A1)         ; Dn,x
    OR.W    D2,(A2)
    OR.L    D3,(A3)
    
    OR.B    D1,(A1)+
    OR.W    D2,(A2)+
    OR.L    D3,(A3)+

    OR.B    D1,-(A1)
    OR.W    D2,-(A2)
    OR.L    D3,-(A3)

    OR.B    D1,WORD_VAR
    OR.W    D2,WORD_VAR
    OR.L    D3,WORD_VAR

    OR.B    D1,LONG_VAR
    OR.W    D2,LONG_VAR
    OR.L    D3,LONG_VAR
    
*----- ROL -----
    ROL.B   D1,D2       ; Dn,Dn
    ROL.W   D2,D3
    ROL.L   D3,D4
    
    ROL.B   #2,D1       ; #,Dn
    ROL.W   #4,D2
    ROL.L   #6,D3
    
    ROL.W   (A1)        ; destination
    ROL.W   (A2)+
    ROL.W   -(A3)
    ROL.W   WORD_VAR
    ROL.W   LONG_VAR
    
*----- ROR -----
    ROR.B   D1,D2       ; Dn,Dn
    ROR.W   D2,D3
    ROR.L   D3,D4
    
    ROR.B   #2,D1       ; #,Dn
    ROR.W   #4,D2
    ROR.L   #6,D3
    
    ROR.W   (A1)        ; destination
    ROR.W   (A2)+
    ROR.W   -(A3)
    ROR.W   WORD_VAR
    ROR.W   LONG_VAR
    
*----- RTS -----
FIRST_JUMP  RTS
    
*----- SUB -----
    SUB.B   D0,D1      ; x, Dn
    SUB.W   D1,D2
    SUB.L   D2,D3
    
    SUB.W   A2,D2
    SUB.L   A3,D3
    
    SUB.B   (A1),D1
    SUB.W   (A2),D2
    SUB.L   (A3),D3
    
    SUB.B   (A1)+,D1
    SUB.W   (A2)+,D2
    SUB.L   (A3)+,D3

    SUB.B   -(A1),D1
    SUB.W   -(A2),D2
    SUB.L   -(A3),D3

    SUB.W   WORD_VAR,D2
    SUB.L   LONG_VAR,D3   

    SUB.W   D0,A1       ; Dn, x
    SUB.L   D1,A2 
    
    SUB.B   D1,(A1)
    SUB.W   D2,(A2)
    SUB.L   D3,(A3)
    
    SUB.B   D1,(A1)+
    SUB.W   D2,(A2)+
    SUB.L   D3,(A3)+

    SUB.B   D1,-(A1)
    SUB.W   D2,-(A2)
    SUB.L   D3,-(A3)  

    SUB.W   D2,WORD_VAR
    SUB.L   D3,LONG_VAR

*----- SUBI ------
    SUBI.B  #1,D1
    SUBI.W  #2,D2
    SUBI.L  #3,D3       
    
    SUBI.B  #1,(A1)
    SUBI.W  #2,(A2)
    SUBI.L  #3,(A3) 
    
    SUBI.B  #1,(A1)+
    SUBI.W  #2,(A2)+
    SUBI.L  #3,(A3)+  

    SUBI.B  #1,-(A1)
    SUBI.W  #2,-(A2)
    SUBI.L  #3,-(A3)

    SUBI.B  #1,WORD_VAR
    SUBI.W  #2,LONG_VAR
    
*----- INVALID Instructions -----


* Put variables and constants here
BYTE_VAR    EQU $AB
WORD_VAR    EQU $1234
LONG_VAR    EQU $FFFF1234

    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
