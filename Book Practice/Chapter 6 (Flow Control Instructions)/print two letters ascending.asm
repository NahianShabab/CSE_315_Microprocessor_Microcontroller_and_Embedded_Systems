.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

.CODE
;IF BH COMES BEFORE BL
;   PRINT BH
;   PRINT BL
;ELSE
;   PRINT BL
;   PRINT BH


MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;BL = 'b'
    MOV BH,98
    
    ;BH = 'N'
    MOV BL,04Eh
    
    ;Should print 'Nb'
    
    MOV AH,2
    
    CMP BH,BL
    JA ELSE
    MOV DL,BH
    INT 21H
    MOV DL,BL
    INT 21H
    JMP ENDIF
    
    ELSE:
        MOV DL,BL
        INT 21H
        MOV DL,BH
        INT 21H
        JMP ENDIF
    ENDIF: 
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
