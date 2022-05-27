.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

x db 23

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    
    ; absolute value will be shown inside AL
    
       
    mov al,x
    cmp al,0
    jge endif
    jl lesser
    
    lesser:
        neg al
        jmp endif
    
    endif:
         
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
