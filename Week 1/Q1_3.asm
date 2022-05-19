
.MODEL SMALL
.STACK 100H

.DATA
messageX db "Enter x:$"
messageY db "Enter y:$"
result db "Result is:$" 

x db ?
y db ?
z db ?


lf equ 0ah
cr equ 0dh
    
.CODE

MAIN PROC
    
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS,AX
    
    ;show messagex
    mov ah,9
    lea dx,messageX
    int 21h
    
    
    ;input x
    mov ah,1
    int 21h
    mov x,al
    
    ;print mew line
    mov ah,2
    mov dl,lf
    int 21h
    mov dl,cr
    int 21h
    
    ;show messagey
    mov ah,9
    lea dx,messageY
    int 21h
    
    ;input y
    mov ah,1
    int 21h
    mov y,al
    
    ;print mew line
    mov ah,2
    mov dl,lf
    int 21h
    mov dl,cr
    int 21h
    
    
    
    
    ;print result
    mov ah,9
    lea dx,result
    int 21h
    
    
    ;z=x+y
    mov al,x
    mov z,al
    mov al,y
    add z,al
    sub z,30h         
    
    ;print z=x+y         
    mov ah,2
    mov dl,z
    int 21h
                
    ;EXIT
    MOV AH,04CH
    INT 21H
     
MAIN ENDP
END MAIN




