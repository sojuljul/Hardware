**-----------------------------------------------------------
** Title      : Disassembler - CSS 422
** Written by : Kien Chin & Juliano Nguyen
** Date       : 5/23/17
** Description: 0100 Opcode Section
**-----------------------------------------------------------
*

Opcode0100
    
    ROL.W   #8,D5
    ;CLR.L   D5      ;IDK
    CLR.L   D4      ;TEMP COMPARISON HOLDER
    ;CLR.L   D3      ;COUNT
    
    
    
    ;CHECK THE DIRECTION
    MOVE.W  D6,D7
    AND.W   #$0400,D7
    
    CMP.W   #$0400,D7
    BEQ     OP0100_MEMREG      ;POSTINCREMENT
    
    BRA     OP0100_REGMEM      ;PREDECREMENT

OP0100_MEMREG
    MOVE.B  #0,D4
    ;ROL.W   #2,D5
    ROR.W   #1,D5
    BRA     OP0100_MEMREG_LOOP1
    ;BRA     OP0100_NEXT

OP0100_REGMEM
    ;if -(An) rol 1
    MOVE.W  D6,D7
    AND.W   #$0038,D7
    ;ROR.W  #1,D5
    ;ROL.W   #2,D5
    CMP.W   #$0020,D7
    BEQ     OP0100_MINI_ROLL
OP0100_REGMEM_CONT

    MOVE.B  #0,D4
    ;ROL.W   #8,D5
    ;ROL.W   #7,D5       ;EQUAL
    ROR.W   #1,D5
    BRA     OP0100_REGMEM_LOOP2
    ;BRA     OP0100_NEXT

OP0100_MINI_ROLL
    ;ROR.W   #7,D5       AND OPPOSITE
    ROL.W   #1,D5
    BRA     OP0100_REGMEM_CONT

OP0100_MEMREG_LOOP1
    

****************************************
OP0100_REGMEM_LOOP2
    CMP.B   #8,D4
    BEQ     OP0100_REGMEM_1

    
    MOVE.W  D5,D7
    AND.W   #$8000,D7
    
    CMP.W   #$8000,D7
    BEQ     OP0100_REGMEM_A_HELPER2
    
OP0100_REGMEM_LOOP_CONT2
    
    ADDI.B  #1,D4
    ROL.W   #1,D5
    BRA     OP0100_REGMEM_LOOP2
    
OP0100_REGMEM_1
    MOVE.B  #0,D4
    BRA     OP0100_REGMEM_LOOP1
    ;BRA     OP0100_NEXT
    
OP0100_REGMEM_LOOP1
    CMP.B   #8,D4
    BEQ     OP0100_NEXT
    
    MOVE.W  D5,D7
    AND.W   #$8000,D7
    
    CMP.W   #$8000,D7
    BEQ     OP0100_REGMEM_D_HELPER_1
    
OP0100_REGMEM_LOOP_CONT_1
    
    ADDI.B  #1,D4
    ROL.W   #1,D5
    BRA     OP0100_REGMEM_LOOP1
    
    
OP0100_REGMEM_D_HELPER2
    JSR     OP0100_PRINT_D_NUM
    CMP.W   #7,D7
    BNE     SLASH_HELP_D2
OP0100_REGMEM_D_HELPER_CONT2
    BRA     OP0100_REGMEM_LOOP_CONT2

OP0100_REGMEM_A_HELPER2
    JSR     OP0100_PRINT_A_NUM
    CMP.W   #7,D7
    BNE     SLASH_HELP_A2
OP0100_REGMEM_A_HELPER_CONT2  
    BRA     OP0100_REGMEM_LOOP_CONT2
    
OP0100_REGMEM_D_HELPER_1
    JSR     OP0100_PRINT_D_NUM
    CMP.W   #7,D7
    BNE     SLASH_HELP_D_1
OP0100_REGMEM_D_HELPER_CONT_1
    BRA     OP0100_REGMEM_LOOP_CONT_1

OP0100_REGMEM_A_HELPER_1
    JSR     OP0100_PRINT_A_NUM
    CMP.W   #7,D7
    BNE     SLASH_HELP_A_1
OP0100_REGMEM_A_HELPER_CONT_1
    BRA     OP0100_REGMEM_LOOP_CONT_1

OP0100_PRINT_D_NUM
    ;OUTPUT D
    MOVE.B  #$44,D1     ; PRINT SPACE
    MOVE.B  #6,D0
    TRAP    #15
    ;OUTPUT D4
    MOVE.B  D4,D1
    MOVE.B  #3,D0
    TRAP    #15
    
    RTS
OP0100_PRINT_A_NUM
    ;OUTPUT A
    MOVE.B  #$41,D1     ; PRINT SPACE
    MOVE.B  #6,D0
    TRAP    #15
    ;OUTPUT D4
    MOVE.B  D4,D1
    MOVE.B  #3,D0
    TRAP    #15

    RTS
OP0100_NEXT
    ;JSR     MOVE_OPERANDS
    RTS
    
SLASH_HELP_A2
    JSR     SLASH
    BRA     OP0100_REGMEM_A_HELPER_CONT2

SLASH_HELP_D2
    JSR     SLASH
    BRA     OP0100_REGMEM_D_HELPER_CONT2

SLASH_HELP_A_1
    JSR     SLASH
    BRA     OP0100_REGMEM_A_HELPER_CONT_1
SLASH_HELP_D_1
    JSR     SLASH
    BRA     OP0100_REGMEM_D_HELPER_CONT_1
    
SLASH
    MOVE.B  #$2F,D1     ; PRINT SPACE
    MOVE.B  #6,D0
    TRAP    #15
    RTS
    


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
