.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

a db ?
b db ?
c db ?


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    mov ah,1
    
    int 21h
    mov a,al
    
    int 21h
    mov b,al
    
    int 21h
    mov c,al
    
    
    mov al,b
    cmp a,al
    jge else_if
    mov al,c
    cmp a,al
    jge else_if
    mov dl,a
    jmp display
    
    else_if:
        mov al,a
        cmp b,al
        jge else
        mov al,c
        cmp b,al
        jge else
        mov dl,b
        jmp display
    else:
        mov dl,c
    display:
        mov ah,2
        int 21h
    end_if:
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
