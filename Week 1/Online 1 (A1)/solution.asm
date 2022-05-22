.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH
newline db lf,cr,'$'
prompt db 'enter a octadecimal number between H-A:',lf,cr,'$'
result db 'in decimal: $'

num db ?


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;print prompt
    mov ah,9
    lea dx,prompt
    int 21h
    
    ;input num
    mov ah,1
    int 21h
    mov num,al
    
    ;print result string
    mov ah,9
    lea dx,result
    int 21h
    
    ;print 1
    mov ah,2
    mov dl,31h
    int 21h
    
    ;map num between 7-0; this is the last digit of
    ;the decimal
    sub num,41h
    neg num
    add num,7
    
    ;add 30h to num to convert to ascii
    add num,30h
    
    ;print num
    mov ah,2
    mov dl,num
    int 21h
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN