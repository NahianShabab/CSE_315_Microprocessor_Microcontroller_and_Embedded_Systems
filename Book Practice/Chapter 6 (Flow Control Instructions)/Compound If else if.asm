.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

message1 db 'heavy buy!$'
message2 db 'didnt buy much!$'
message3 db 'No comment!$'

COUNT DB 3
PRICE DB 180

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ; IF PRICE>=180 AND COUNT>=10
    ;   print message1
    ; else if price<50 or count<=2
    ;   print message2
    ; else
    ;   print message3
    
    CMP PRICE,180
    JB ELSE_IF_1
    CMP COUNT,10
    JB ELSE_IF_1
    lea dx,message1
    jmp DISPLAY
    
    ELSE_IF_1:
        CMP PRICE,50
        JBE THEN_1
        CMP COUNT,2
        JBE THEN_1
        JMP ELSE_1
    THEN_1:
        lea DX,message2
        JMP DISPLAY
    ELSE_1:
        lea DX, message3
        JMP DISPLAY
    DISPLAY:
        MOV AH,9
        INT 21H
    
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
