.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

message db 'I Love Assembly!',cr,lf,'$'

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    
    mov ah,9
    lea dx,message
    
    ;counter is 10
    mov cx,10
        
    PRINT_LOOP:
        int 21h
        dec cx
        jnz PRINT_LOOP
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
