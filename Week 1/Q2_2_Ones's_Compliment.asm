
.MODEL SMALL
.STACK 100H

.DATA
char db ?


lf equ 0ah
cr equ 0dh
    
.CODE

MAIN PROC
    
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS,AX
    
    mov ah,1
    int 21h
    
    mov char,al
    
    neg char
    sub char,1
    
    ;print mew line
    mov ah,2
    mov dl,lf
    int 21h
    mov dl,cr
    int 21h
    
    ;print prev lowercase
    mov dl,char
    int 21h
                
    ;EXIT
    MOV AH,04CH
    INT 21H
     
MAIN ENDP
END MAIN




