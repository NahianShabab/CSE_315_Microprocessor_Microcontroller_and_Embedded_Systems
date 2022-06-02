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
    
    mov al,-2
    cbw
    mov bl,2
    
    idiv bl
    
    
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
