.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;PRINT CHARACTER IF 'Y' or 'y'
    
    ;TAKE INPUT
    MOV AH,1
    INT 21H
    
    CMP AL,'Y'
    JE DO
    CMP AL,'y'
    JE DO
    JMP ENDIF
    
    DO:
        MOV DL,AL
        MOV AH,2
        INT 21H
    
    ENDIF:      
       
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
