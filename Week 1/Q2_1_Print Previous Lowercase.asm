
.MODEL SMALL
.STACK 100H

.DATA


lf equ 0ah
cr equ 0dh

message1 db 'enter a uppercase letter B-Z',lf,cr,'$'
message2 db lf,cr,'result is: $'
char db ?
    
.CODE

MAIN PROC
    
    ;DATA SEGMENT INITIALIZATION
    MOV AX,@DATA
    MOV DS,AX
    
    ; print message1
    lea dx,message1
    mov ah,9
    int 21h
    
    ;input char
    mov ah,1
    int 21h
    mov char,al
    
    ;process char
    add char,20h
    dec char
    
    ;print message2
    mov ah,9
    lea dx,message2
    int 21h
    
    ;show char
    mov ah,2
    mov dl,char
    int 21h
        
                
    ;EXIT
    MOV AH,04CH
    INT 21H
     
MAIN ENDP
END MAIN




