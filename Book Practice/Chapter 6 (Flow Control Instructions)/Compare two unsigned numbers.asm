.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

x db 170
y db 10

equalMessage db "Equal$"
lesserMessage db "Lesser$"
greaterMessage db "Greater$"

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;load x and y 
    mov ah,x
    mov al,y
    
    
    ;interpreting as unsigned, compare x and y
    cmp ah,al
    mov ah,9
    ja load_greater
    je load_equal
    jb load_lesser
    
    load_greater:
        lea dx,greaterMessage
        jmp print
    load_equal:
        lea dx,equalMessage
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
