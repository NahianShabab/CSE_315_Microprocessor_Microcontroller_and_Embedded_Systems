.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

PROMPT DB 'ENTER BETWEEN A-F:',cr,lf,'$'
prompt2 db cr,lf,'Decimal is: $'          
INPUT Db ?

          
.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;print prompt1
    mov ah,9
    lea dx,prompt
    int 21h
    
    
    ;take input
    MOV AH,1
    INT 21H 
    MOV INPUT,AL
    
    
    ;store the acii last digit of decimal number value of the input
    ; i.e if INPUT is 'D'(13) then store '3'
    SUB INPUT,41H
    ADD INPUT,30H

    ;print prompt2
    mov ah,9
    lea dx,prompt2
    int 21h
    
    
   
    ;print '1'
    mov ah,2 
    MOV DL,31H
    INT 21H
    
    ;print the last digit
    MOV DL,INPUT
    INT 21H
    
    
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
