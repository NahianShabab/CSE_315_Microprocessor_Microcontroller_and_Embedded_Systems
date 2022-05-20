.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

M1 DB 'ENTER THREE INITIALS$'
X DB ?
Y DB ?
Z DB ?
NEWLINE DB CR,LF,'$'

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,9
    LEA DX,M1
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV X,AL
    
    INT 21H
    MOV Y,AL
    
    INT 21H
    MOV Z,AL
    
    MOV AH,9
    LEA DX,newline
    INT 21H
    
    
    MOV ah,2
    MOV DL,X
    INT 21h
    
    MOV AH,9
    LEA DX,newline
    INT 21H
    
    
    MOV ah,2
    MOV DL,y
    INT 21h
    
    
    
    MOV AH,9
    LEA DX,newline
    INT 21H
    
    
    MOV ah,2
    MOV DL,z
    INT 21h
    
    
    
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
