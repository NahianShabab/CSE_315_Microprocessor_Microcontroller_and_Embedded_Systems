.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH


M DW 51
N DW 17
RESULT DW 0

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
     
    ; STORES M/N TO DX
    
    
    WHILE:
        MOV AX,N
        CMP M,AX
        JB END_WHILE
        MOV AX,N
        SUB M,AX
        INC RESULT
        JMP WHILE
    END_WHILE:
        MOV DX,RESULT 
        
    
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
