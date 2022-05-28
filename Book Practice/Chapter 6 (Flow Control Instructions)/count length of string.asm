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
    
    mov dx,0
     
    mov ah,1
     
    WHILE:
        int 21h
        cmp al,CR
        je END_WHILE
        INC DX
        jmp WHILE
        
    END_WHILE:
    
    ;length is stored in DX
          
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
