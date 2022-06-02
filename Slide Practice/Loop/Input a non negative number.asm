.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

NEWLINE DB CR,LF,'$'

char db ?


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    mov ah,1
    xor bx,bx
    
    
    while:
        int 21h
        cmp al,cr
        je end_while
        
        mov char,al
        sub char,'0'
        
        
        xor ax,ax
        mov al,10
        mul bx
        
        mov bx,ax
        
        xor ax,ax
        mov al,char
        add bx,ax
        
        mov ah,1
        
        jmp while
    
    end_while: 
        
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
