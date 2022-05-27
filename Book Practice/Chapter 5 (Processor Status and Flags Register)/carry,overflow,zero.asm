.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    
    
    ;adding 1 with -1
    ; carry flag will change to 1 because there is a carry out  
    ; zero flag will change to 1 because addition result is zero
    ; oveflow flag will not change because
    ; if we consider 0ffh as signed (-1),
    ; then adding two numbers of different sign
    ; cannot overflow
    
    mov al,0ffh
    add al,1  ;ZERO FLAG=0->1,OVERFLOW=0,CARRY=0->1
    
    
    ; CARRY flag is not affected by inc or dec
    mov al,0ffh
    inc al
    
     
    ;adding 1 with 127
    ;this will cause overflow
    mov al,127
    add al,1
    
    ;resetting overflow flag
    mov al,10
    add al,1
    
    ;subtracting -1 from -128
    ;this will cause overflow
    mov al,-128
    sub al,1
    
    
   
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
