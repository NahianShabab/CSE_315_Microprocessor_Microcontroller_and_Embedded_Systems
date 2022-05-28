.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

a db ?
b db ?

message db '?$'



.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    mov ah,9
    lea dx,message
    int 21h
    
    mov ah,1
    int 21h
    mov a,al
    
    int 21h
    mov b,al
    
    mov ah,2
    mov dl,cr
    int 21h  
    mov dl,lf
    int 21h
    
    mov ah,2
    
    mov al,b
    cmp a,al
    jb else
    mov dl,b
    int 21h
    mov dl,a
    int 21h
    jmp endif
    
    
    else:
        mov dl,a
        int 21h
        mov dl,b
        int 21h
    endif:    
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
