.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

x db 126
y db 126

equalMessage db "Equal$"
lesserMessage db "Lesser$"
greaterMessage db "Greater$"

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    mov ah,x
    mov al,y
    cmp ah,al
    
    jmp set_print
    
    set_print:
        mov ah,9
        jz load_equal
        jg load_greater
        jl load_lesser
    
    
    load_equal:
        lea dx,equalMessage
        jmp print
    load_greater:
        lea dx,greaterMessage
        jmp print
    load_lesser:
        lea dx,lesserMessage
        jmp print
    
    print:
        int 21h      
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
