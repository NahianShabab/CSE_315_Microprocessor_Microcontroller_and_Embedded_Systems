.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH


message db 'Your grade is: $'
A_PLUS db 'A+$'
A db 'A$'
A_MINUS DB 'A-$'
B DB 'B$'
C DB 'C$'
D DB 'D$'
F DB 'F$'

GRADE db 23

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    
    MOV AH,9
    LEA DX,MESSAGE
    INT 21H
    
    CMP GRADE,80
    JGE CASE_A_PLUS
    CMP GRADE,70
    JGE CASE_A
    CMP GRADE,60
    JGE CASE_A_MINUS
    CMP GRADE,50
    JGE CASE_B
    CMP GRADE,40
    JGE CASE_C
    CMP GRADE,33
    JGE CASE_D
    JMP CASE_F
    
    
    
    
    CASE_A_PLUS:
        LEA DX,A_PLUS
        JMP DISPLAY
    
    CASE_A:
        LEA DX,A
        JMP DISPLAY
    
    CASE_A_MINUS:
        LEA DX,A_MINUS
        JMP DISPLAY
    
    CASE_B:
        LEA DX,B
        JMP DISPLAY
    
    CASE_C:
        LEA DX,C
        JMP DISPLAY
    
    CASE_D:
        LEA DX,D
        JMP DISPLAY
    
    CASE_F:
        LEA DX,F 
    
    DISPLAY:
       MOV AH,9
        INT 21H 
    END_CASE:
         
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
