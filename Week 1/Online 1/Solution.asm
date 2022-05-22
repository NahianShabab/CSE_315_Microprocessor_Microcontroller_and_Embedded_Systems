.model small
.stack 100h

 .data
 
 .code
 cr equ 0dh
 lf equ 0ah
 newline db cr,lf,'$'
 prompt db 'enter initials: $'
 initial db 'abc$'
 sevenStar db '*******$'
 twoStar db '**$'
 threeStar db '***$'
 
 MAIN PROC
    ;INIT DATA
    MOV AX,@DATA
    MOV DS,AX
    
    ;prompt for input
    mov ah,9
    lea dx,prompt
    int 21h
    lea dx,newline
    int 21h
    
    ;input initials
    mov ah,1
    int 21h
    mov initial,al
    
    ;input initials
    mov ah,1
    int 21h
    mov initial+1,al
    
    ;input initials
    mov ah,1
    int 21h
    mov initial+2,al
    
    mov ah,9
    lea dx,newline
    int 21h
    
    
    ;print initial
    mov ah,9
    
    lea dx,sevenStar
    int 21h
    
    lea dx,newline
    int 21h
    
    lea dx,sevenStar
    int 21h
    
    lea dx,newline
    int 21h
    
    lea dx,threeStar
    int 21h
    
    mov ah,2
    mov dl,initial
    int 21h
    
    mov ah,9
    lea dx,threeStar
    int 21h
    
    lea dx,newline
    int 21h
    
    lea dx,twoStar
    int 21h
    
    lea dx,initial
    int 21h
    
    lea dx,twoStar
    int 21h
    
    lea dx,newline
    int 21h
    
    lea dx,threeStar
    int 21h
    
    mov ah,2
    mov dl,initial+2
    int 21h
    
    mov ah,9
    lea dx,threeStar
    int 21h
    
    lea dx,newline
    int 21h
    
    lea dx,sevenStar
    int 21h
    
    lea dx,newline
    int 21h
    
    lea dx,sevenStar
    int 21h
    
    lea dx,newline
    int 21h
    
    
    ;END PROGRAM
    MOV AH,4CH
    INT 21H
 
 MAIN ENDP
 END MAIN

