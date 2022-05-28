.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

FIRST DB 0ffh
LAST DB 0

prompt db 'Type a line of text: ',cr,lf,'$'
result1 db 'First capital = $'
result2 db ' Last Capital = $'


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    mov ah,9
    lea dx,prompt
    int 21h
    
    mov ah,1
    
    WHILE:
        ; take input
        int 21h
        
        ; is enter pressed? then go to end_while
        cmp al,cr
        je end_while
        
        ; is input uppercase?  then proceed, else continue
        cmp al,'A'
        jb while
        cmp al,'Z'
        ja while
        
        ; is input less than FIRST? then replace first
        cmp al,FIRST
        jae end_first
        mov FIRST,al
        
        end_first:
        
        ; is input greater than LAST? then replace last
        cmp al,LAST
        jbe end_last
        mov LAST,al
        
        end_last:
        ; go to top of the loop
        jmp while
        
    
    
    END_WHILE:
    
    ;if any capital letter pressed?
    ; then print them
    cmp LAST,0
    je exit
    mov ah,9
    lea dx,result1
    int 21h
    mov ah,2
    mov dl,FIRST
    int 21h
    
    mov ah,9
    lea dx,result2
    int 21h
    
    mov ah,2
    mov dl,LAST
    int 21h
    
    
    exit:
          
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
