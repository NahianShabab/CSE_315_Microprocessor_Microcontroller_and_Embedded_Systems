.MODEL SMALL 
.STACK 100H 
.DATA

N DW ?
CR EQU 0DH
LF EQU 0AH

S_F DB 'F$'
S_B DB 'B$'
S_BPLUS DB 'B+$'
S_AMINUS DB 'A-$'
S_A DB 'A$'
S_APLUS DB 'A+$'
S_INVALID DB 'INVALID$'


.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n\r, stop taking input
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP
    
    END_INPUT_LOOP:
    MOV N, BX
    
    ; printing CR and LF
    MOV AH, 2
    MOV DL, CR
    INT 21H
    MOV DL, LF
    INT 21H
    
    
    ;------------------------------------
    ; start from here
    ; input is in N
   
    CMP N,100
    JG INVALID
    CMP N,80
    JGE APLUS
    CMP N,75
    JGE A
    CMP N,70
    JGE AMINUS
    CMP N,65
    JGE BPLUS
    CMP N,60
    JGE B
    CMP N,0
    JGE F
    JMP INVALID
    
    INVALID:
        LEA DX,S_INVALID
        JMP DISPLAY
    APLUS:
        LEA DX,S_APLUS
        JMP DISPLAY
    A:
        LEA DX,S_A
        JMP DISPLAY
        
    AMINUS:
        LEA DX,S_AMINUS
        JMP DISPLAY
        
    BPLUS:
        LEA DX,S_BPLUS
        JMP DISPLAY
    B:
        LEA DX,S_B
        JMP DISPLAY
        
    F:
        LEA DX,S_F
        JMP DISPLAY
    
    
    
    DISPLAY:
        MOV AH,9
        INT 21H
    
    
      

	; interrupt to exit
    MOV AH, 4CH
    INT 21H
    
  
MAIN ENDP 
END MAIN 
