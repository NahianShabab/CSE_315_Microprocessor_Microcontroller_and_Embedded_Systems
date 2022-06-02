.MODEL SMALL


.STACK 100h


.DATA
CR EQU 0DH
LF EQU 0AH

message1 db 'ENTER A STRING',cr,lf,'$'

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    
    lea dx,message1
    mov ah,9
    int 21h
    
    
    ;pushing '$' sign at the bottom of stack
    ;as a flag for emptiness
    
    mov ax,'$'
    push ax
    
    ;while character not 'enter',continue to
    ;push it to stack
    
    MOV AH,1
    
    WHILE_1:
        INT 21H
        cmp al,cr
        je END_WHILE_1
        PUSH AX
        JMP WHILE_1
    
    END_WHILE_1:
    
   ;new line
   mov ah,2
   mov dl,cr
   int 21h
   mov dl,lf
   int 21h
   
   
   ; keep popping and printing until '$' found
   
   WHILE_2:
        pop ax
        cmp al,'$'
        je END_WHILE_2
        mov ah,2
        mov dl,al
        int 21h
        JMP WHILE_2             
    
   END_WHILE_2:
   
   ;DOS EXIT
   MOV AH, 4CH
   INT 21H

MAIN ENDP
END MAIN
