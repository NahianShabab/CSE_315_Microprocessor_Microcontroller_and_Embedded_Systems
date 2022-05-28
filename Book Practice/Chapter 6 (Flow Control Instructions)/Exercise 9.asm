.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

CURRENT DB 80H


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,2
     
    WHILE_1:
        JB END_WHILE
        MOV CX,10
            WHILE_2:
                CMP CX,0
                JBE END_WHILE_2
                MOV DL,CURRENT
                INT 21H
                MOV DL,' '
                INT 21H
                INC CURRENT
                DEC CX
                CMP CURRENT,0
                JGE END_WHILE
                JMP WHILE_2       
          END_WHILE_2:
                MOV DL,CR
                INT 21H
                MOV DL,LF
                INT 21H
                JMP WHILE_1
    
    END_WHILE:    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
