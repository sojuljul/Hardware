*-----------------------------------------------------------
* Title      : Disassembler Project
* Written by : Kien Chin & Juliano Nguyen
* Date       : 4/21/17
* Description: Testing file for Disassembler
*-----------------------------------------------------------
    ORG    $7000

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
    
    ADD.B   $1234,D1 ; xxx.W
    ADD.W   $1234,D2
    ADD.L   $1234,D3
    
    ADD.B   $12345678,D1 ; xxx.L
    ADD.W   $12345678,D2
    ADD.L   $12345678,D3
    
    ADD.B   #10,D1          ; #n
    ADD.W   #$1234,D2
    ADD.L   #$12345678,D3
    
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
    
    ADDA.W  $1234,A4 ; xxx.W
    ADDA.W  $12345678,A4
    
    ADDA.L  $12345678,A5     ; xxx.L
    ADDA.L  $1234,A5
            
    ADDA.W   #$1234,A2   ; #n
    ADDA.L   #$12345678,A3
    
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
    
    ADDI.B  #$10,-(A1)      ; -(An)
    ADDI.W  #$1234,-(A2)
    ADDI.L  #$12345678,-(A3)
    
    ADDI.B  #$10,$1234      ; xxx.W
    ADDI.W  #$1234,$1234
    ADDI.L  #$12345678,$1234
    
    ADDI.B  #$10,$12345678      ; xxx.L
    ADDI.W  #$1234,$12345678
    ADDI.L  #$12345678,$12345678
    
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
    
    ADDQ.B  #1,$1234      ; xxx.W
    ADDQ.W  #2,$1234
    ADDQ.L  #3,$1234
    
    ADDQ.B  #1,$12345678      ; xxx.L
    ADDQ.W  #2,$12345678
    ADDQ.L  #3,$12345678
    
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

    AND.B   $1234,D1
    AND.W   $1234,D2
    AND.L   $1234,D3

    AND.B   $12345678,D1
    AND.W   $12345678,D2
    AND.L   $12345678,D3

    AND.B   #10,D1
    AND.W   #$1234,D2
    AND.L   #$12345678,D3    
    
    AND.B   D1,(A1)         ; Dn,x
    AND.W   D2,(A2)
    AND.L   D3,(A3)
    
    AND.B   D1,(A1)+
    AND.W   D2,(A2)+
    AND.L   D3,(A3)+
    
    AND.B   D1,-(A1)
    AND.W   D2,-(A2)
    AND.L   D3,-(A3)

    AND.B   D1,$1234
    AND.W   D2,$1234
    AND.L   D3,$1234

    AND.B   D1,$12345678
    AND.W   D2,$12345678
    AND.L   D3,$12345678
    
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
    ASL.W   $1234
    ASL.W   $12345678
    
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
    ASR.W   $1234
    ASR.W   $12345678   

*----- BRA -----
*----- Bcc (BCC, BLT, BGE) -----

    BCC.B     label1       ; BCC
    BCC.W     label1       ; BCC
    BLT.B     label2        ; BLT
    BLT.W     label2        ; BLT
    BGE.B     label3       ; BGE  
    BGE.W     label3       ; BGE  
    BRA.W     label4
            
label1
    MOVE.B  D0,D1
    MOVE.W  D1,D2
    MOVE.L  D2,D3
    
label2
    ADD.B   D0,D1      
    ADD.W   D1,D2
    ADD.L   D2,D3
    
label3
    AND.B   D1,D2
    AND.W   D2,D3
    AND.L   D3,D4
    
label4
    OR.B    D1,D2   
    OR.W    D2,D3
    OR.L    D3,D4 

  
*----- DIVU -----
    DIVU.W  D0,D1           ; Dn
    DIVU.W  (A2),D2         ; (An)
    DIVU.W  (A3)+,D3        ; (An)+
    DIVU.W  -(A4),D4        ; -(An)
    DIVU.W  $1234,D5        ; xxx.W
    DIVU.W  $12345678,D6    ; xxx.L
    DIVU.W  #$1234,D2
    
*----- JSR -----
    ;JSR FIRST_JUMP
    JSR (A1)            ; (An)
    JSR $1234        ; xxx.W
    JSR $12345678        ; xxx.L
    
*----- LEA ------
    LEA (A0),A1
    LEA $1234,A2
    LEA $12345678,A3
    
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
    LSL.W   $1234
    LSL.W   $12345678
    
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
    LSR.W   $1234
    LSR.W   $12345678
    
*----- MOVEQ ------
    MOVEQ.L   #1,D1
    MOVEQ.L   #$1,D2
    
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
    
    MOVEA.W $1234,A1       ; xxx.W
    MOVEA.L $1234,A2
    
    MOVEA.W $12345678,A1       ; xxx.L
    MOVEA.L $12345678,A2
    
*----- MOVEM -----
    MOVEM.W A1-A7,(A1)        ; (An)
    MOVEM.L D1-D7,(A2)
    
    MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
    MOVEM.W D1-D7,$1234    ; xxx.W
    MOVEM.L A1-A7,$1234
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)
    
        MOVEM.W A1/D7,-(A1)       ; -(An)
    MOVEM.L A1/D7,-(A2)

    MOVEM.W D1/D7,$12345678    ; xxx.L
    MOVEM.L A1/A7,$12345678
    
*----- MOVE -----
    MOVE.B  D0,D1
    MOVE.W  D1,D2
    MOVE.L  D2,D3
    
    MOVE.W  A2,D2
    MOVE.L  A3,D3
    
    MOVE.B  D1,(A1)
    MOVE.W  D2,(A2)
    MOVE.L  D3,(A3)
    
    MOVE.B  (A1),$1234
    MOVE.W  (A2),$1234
    MOVE.L  (A3),$1234
    
    MOVE.B  (A1)+,-(A2)
    MOVE.W  (A2)+,$1234
    MOVE.L  (A3)+,D3

    MOVE.B  -(A1),(A2)+
    MOVE.W  -(A2),D2
    MOVE.L  -(A3),$12345678

    MOVE.B  #10,D1
    MOVE.W  #$1234,D2
    MOVE.L  #$12345678,D3
    
*----- MULS -----
    MULS.W    D1,D2             ; Dn
    MULS.W    (A1),D1           ; (An)
    MULS.W    (A2)+,D2          ; (An)+
    MULS.W    -(A3),D3          ; -(An)
    MULS.W    $1234,D4          ; xxx.W
    MULS.W    $12345678,D5      ; xxx.L
    MULS.W    #$1234,D1
    
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

    OR.B    $1234,D1
    OR.W    $1234,D2
    OR.L    $1234,D3

    OR.B    $12345678,D1
    OR.W    $12345678,D2
    OR.L    $12345678,D3

    OR.B    #10,D1
    OR.W    #$1234,D2
    OR.L    #$12345678,D3    
    
    OR.B    D1,(A1)         ; Dn,x
    OR.W    D2,(A2)
    OR.L    D3,(A3)
    
    OR.B    D1,(A1)+
    OR.W    D2,(A2)+
    OR.L    D3,(A3)+

    OR.B    D1,-(A1)
    OR.W    D2,-(A2)
    OR.L    D3,-(A3)

    OR.B    D1,$1234
    OR.W    D2,$1234
    OR.L    D3,$1234

    OR.B    D1,$12345678
    OR.W    D2,$12345678
    OR.L    D3,$12345678
    
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
    ROL.W   $1234
    ROL.W   $12345678
    
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
    ROR.W   $1234
    ROR.W   $12345678
    
*----- RTS -----
    RTS
    
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

    SUB.W   $1234,D2
    SUB.L   $12345678,D3   
    
    SUB.B   D1,(A1)
    SUB.W   D2,(A2)
    SUB.L   D3,(A3)
    
    SUB.B   D1,(A1)+
    SUB.W   D2,(A2)+
    SUB.L   D3,(A3)+

    SUB.B   D1,-(A1)
    SUB.W   D2,-(A2)
    SUB.L   D3,-(A3)  

    SUB.W   D2,$1234
    SUB.L   D3,$12345678

*----- SUBI ------
    SUBI.B  #10,D0      ; Dn
    SUBI.W  #1234,D1
    SUBI.L  #12345678,D2
    
    SUBI.B  #10,(A1)      ; (An)
    SUBI.W  #1234,(A2)
    SUBI.L  #12345678,(A3)
    
    SUBI.B  #10,(A1)+      ; (An)+
    SUBI.W  #1234,(A2)+
    SUBI.L  #12345678,(A3)+
    
    SUBI.B  #$10,-(A1)      ; -(An)
    SUBI.W  #$1234,-(A2)
    SUBI.L  #$12345678,-(A3)
    
    SUBI.B  #$10,$1234      ; xxx.W
    SUBI.W  #$1234,$1234
    SUBI.L  #$12345678,$1234
    
    SUBI.B  #$10,$12345678      ; xxx.L
    SUBI.W  #$1234,$12345678
    SUBI.L  #$12345678,$12345678
    
    
*----- INVALID Instructions -----
    SUB.W   D1,A1
    BGT.W     label1
    BLE.W     label2
    MULU.W    D1,D2
    DIVS.W    D1,D2
    
    




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
