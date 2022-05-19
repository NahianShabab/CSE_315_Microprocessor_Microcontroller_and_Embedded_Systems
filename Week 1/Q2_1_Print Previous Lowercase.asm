
.MODEL SMALL
.STACK 100H

.DATA
messageX db "Enter x:$"
messageY db "Enter y:$"
result db "2x-3y is= $" 

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
    
    
    
    
    ;print result message
    mov ah,9
    lea dx,result
    int 21h
    
    
    ;z=2x-3y
    sub x,30h
    sub y,30h
    
    mov al,y
    add al,y
    add al,y
    neg al
    
    
    add al,x
    add al,x  
    
    add al,30h
    
    mov z,al
            
    
    ;print z=2x-3y         
    mov ah,2
    mov dl,z
    int 21h
                
    ;EXIT
    MOV AH,04CH
    INT 21H
     
MAIN ENDP
END MAIN




