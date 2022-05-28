.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

newline db cr,lf,'$'
enterHex db 'Enter a hex digit: 0-9/A-F: $'
inDecimal db 'In decimal it is: $'
illegalCharacter db 'Illegal Character. Enter 0-9/A-F: $'
goAgain db 'Do you want to go again? Y/N?: $'

CHAR DB ?
.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    WHILE:
        MOV AH,9
        LEA DX,ENTERHEX
        INT 21H
        
        INPUT:
        
        MOV AH,1
        INT 21H
        MOV CHAR,AL
        
        CMP CHAR,'0'
        JL ELSEIF
        CMP CHAR,'9'
        JG ELSEIF
        
        ;PRINT THE DECIMAL
        MOV AH,9
        LEA DX,NEWLINE
        INT 21H
        
        LEA DX,INDECIMAL
        INT 21H
        
        MOV AH,2
        MOV DL,CHAR
        INT 21H
        JMP ENDIF
        
        ELSEIF:
        CMP CHAR,'A'
        JL ELSE
        CMP CHAR,'F'
        JG ELSE
        
        MOV AH,9
        LEA DX,NEWLINE
        INT 21H
        
        LEA DX,INDECIMAL
        INT 21H
        
        MOV AH,2
        MOV DL,'1'
        INT 21H
        MOV AL,CHAR
        SUB AL,'A'
        ADD AL,30H
        MOV DL,AL
        INT 21H
        JMP ENDIF
        
        ELSE:
        MOV AH,9
        LEA DX,NEWLINE
        INT 21H
        
        LEA DX,ILLEGALCHARACTER
        INT 21H
        JMP INPUT
        
        ENDIF:
        MOV AH,9
        LEA DX,NEWLINE
        INT 21H
        LEA DX,GOAGAIN
        INT 21H
        
        MOV AH,1
        INT 21H
        CMP AL,'Y'
        MOV AH,9
        LEA DX,NEWLINE
        INT 21H
        JZ WHILE
    
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
