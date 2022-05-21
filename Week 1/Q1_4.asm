.MODEL SMALL

.STACK 100H

.DATA
CR EQU 0DH
LF EQU 0AH

messagex db 'enter x: ',cr,lf,'$'
messagey db cr,lf,'enter y: ',cr,lf,'$'
result db cr,lf,'z is $'
x db ?
y db ?
z db ?

.CODE

MAIN PROC
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA 
    MOV DS,AX
    
    ;print message x
    lea dx,messagex
    mov ah,9
    int 21h
    
    ;input x
    mov ah,1
    int 21h
    mov x,al
    
    ;print messagey
    lea dx,messagey
    mov ah,9
    int 21h
    
    ;input y
    mov ah,1
    int 21h
    mov y,al
    
    ;process x & y
    sub x,30h
    sub y,30h
    
    
    
    ;process z=y-x+1
    mov al,y
    sub al,x
    add al,1
    
    mov z,al
    add z,30h
    
    ;print result
    mov ah,9
    lea dx,result
    int 21h
    
    ;print z
    mov ah,2
    mov dl,z
    int 21h
    
    
    
    ;DOS EXIT
    MOV AH,4CH
    INT 21H
        
MAIN ENDP
END MAIN