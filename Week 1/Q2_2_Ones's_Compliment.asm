
.MODEL SMALL
.STACK 100H

.DATA
char db ?


lf equ 0ah
cr equ 0dh

newline db lf,cr,'$'
    
.CODE

MAIN PROC
    
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS,AX
    
    ;input char
    mov ah,1
    int 21h
    
    mov char,al
    
    ;process char
    neg char
    sub char,1
    
    
    ;print mew line
    mov ah,9
    lea dx,newline
    int 21h
      
    
    ;print 1's compliment
    mov ah,2
    mov dl,char
    int 21h
                
    ;EXIT
    MOV AH,04CH
    INT 21H
     
MAIN ENDP
END MAIN




