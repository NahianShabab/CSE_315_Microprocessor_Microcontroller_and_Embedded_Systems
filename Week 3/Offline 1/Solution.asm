.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR,LF,'$'
COMMA DB ',$' 


; N IS A UNSIGNED NUMBER
N DW ? 

;MAIN DATA ARRAY
ARR DW 100 DUP(?)


;STRING MESSAGES FOR DISPLAY
S_ENTER_N DB 'Enter the value of N (Array length): $'
S_ENTER_NUMBER DB 'Enter a number: $'
S_SORTED_ARRAY DB 'Sorted Array is: $'
S_ENTER_SEARCH_ELEMENT DB 'Enter x to search in array: $'
S_NOT_FOUND DB 'NOT FOUND$'
S_ELEMENT_FOUND DB 'Element found at index: $'
S_SEARCH_AGAIN DB 'Do you want to search again?y:Yes/(anything else:No): $'
.CODE


MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    ;STEP 1: INPUT N
    MAIN_INPUT_N:
        LEA DX,S_ENTER_N
        CALL PRINT_STRING
        CALL INPUT_DECIMAL
        MOV N,AX
    
    ;STEP 2: IF N<=0, TERMINATE
    CMP N,0
    JLE MAIN_END
    
    ;PRINT NEWLINE
    LEA DX,NEWLINE
    CALL PRINT_STRING
    
    ;STEP 3: INPUT N INTEGERES FROM USERS
    MOV CX,N
    LEA SI,ARR
    MAIN_INPUT_LOOP:
        LEA DX,S_ENTER_NUMBER
        CALL PRINT_STRING
                
        CALL INPUT_DECIMAL
        MOV [SI],AX
        ADD SI,2
            
         
        ;PRINT NEWLINE
        LEA DX,NEWLINE
        CALL PRINT_STRING 
        LOOP MAIN_INPUT_LOOP
    
    
    ;STEP 4: SORT THE ARRAY
    MOV CX,N
    LEA SI,ARR
    CALL INSERTION_SORT
    
    ;PRINT NEWLINE
    LEA DX,NEWLINE
    CALL PRINT_STRING
    
    ;STEP 5: DISPLAY THE ARRAY
    LEA DX,S_SORTED_ARRAY
    CALL PRINT_STRING
    
    LEA SI,ARR
    MOV CX,N
    MAIN_DISPLAY_LOOP:
       MOV AX,[SI]
       CALL OUTPUT_DECIMAL
       ADD SI,2
       ;PRINT COMMA
       LEA DX,COMMA
       CALL PRINT_STRING  
       LOOP MAIN_DISPLAY_LOOP
    
    ;PRINT NEW LINE
    LEA DX,NEWLINE
    CALL PRINT_STRING   
    
    ;STEP 6: INPUT X
    MAIN_INPUT_X:
    LEA DX,S_ENTER_SEARCH_ELEMENT
    CALL PRINT_STRING
    
    CALL INPUT_DECIMAL
    
    ;PRINT NEW LINE
    LEA DX,NEWLINE
    CALL PRINT_STRING 
    
    ;STEP 7: SEARCH X IN ARR
    MOV CX,N
    LEA SI,ARR
    CALL BINARY_SEARCH
    
    ;PRINT NEW LINE
    LEA DX,NEWLINE
    CALL PRINT_STRING
    
     
    ;DISPLAY INDEX
    MOV AX,BX
    CMP AX,-1
    JNE MAIN_PRINT_INDEX
    LEA DX,S_NOT_FOUND
    CALL PRINT_STRING
    LEA DX,NEWLINE
    CALL PRINT_STRING
    JMP MAIN_SEARCH_AGAIN
    
    MAIN_PRINT_INDEX:
        INC AX
        LEA DX,S_ELEMENT_FOUND
        CALL PRINT_STRING
        CALL OUTPUT_DECIMAL
    
    ;PRINT NEWLINE    
    LEA DX,NEWLINE
    CALL PRINT_STRING
    
    ;STEP 8: SEARCH AGAIN
    MAIN_SEARCH_AGAIN:
    LEA DX,S_SEARCH_AGAIN
    CALL PRINT_STRING
    
    MOV AH,1
    INT 21H
    
    CMP AL,'y'
    JNE MAIN_GOTO_STEP1
    ;PRINT NEWLINE    
    LEA DX,NEWLINE
    CALL PRINT_STRING
    JMP MAIN_INPUT_X 
    
    MAIN_GOTO_STEP1:  
    ;PRINT NEWLINE    
    LEA DX,NEWLINE
    CALL PRINT_STRING
    
    ;STEP 9: GO TO STEP 1
    JMP MAIN_INPUT_N      
    
    ;STEP 10: END
    MAIN_END:
        ;DOS EXIT
        MOV AH, 4CH
        INT 21H
MAIN ENDP


;-----------------------------------------
;-----------------------------------------
; PROCEDURE: INPUT A SIGNED DECIMAL NUMBER

; @INPUT: *NOTHING*
; @OUTPUT:
;   AX: A SIGNED DECIMAL NUMBER
;-----------------------------------------
INPUT_DECIMAL PROC
    
    ;SAVE THESE REGISTERS
    PUSH BX
    PUSH CX
    
    ;AT FIRST, BX=TOTAL=0
    XOR BX,BX
    
    ;KEEP CX AS A SIGN FLAG
    ;CX=0 => POSITIVE ELSE NEGATIVE
    XOR CX,CX
    
    ;INPUT A CHARACTER
    MOV AH,1
    INT 21H
    
    ;CHECK IF 1ST CHAR IS '+' OR '-' SIGN
    CMP AL,'+'
    JE  INPUT_DECIMAL_PLUS
    CMP AL,'-'
    JE  INPUT_DECIMAL_MINUS
    JMP INPUT_DECIMAL_LOOP1
    
    ; SET CX=1 TO REPRESENT NEGATIVE
    INPUT_DECIMAL_MINUS:
        MOV CX,1
        INT 21H
        JMP INPUT_DECIMAL_LOOP1
    
    INPUT_DECIMAL_PLUS:
        INT 21H
    
    ;CHARACTER INPUT LOOP   
    INPUT_DECIMAL_LOOP1:
        ;CHECK IF INPUT IS CARRIAGE RETURN
        ;IF SO, BREAK THE LOOP
        CMP AL,CR
        JE END_INPUT_DECIMAL_LOOP1
         
        ;STORE THE DIGIT IN AX
        AND AX,000FH
        
        ;STORE THE DIGIT IN STACK
        PUSH AX
        
        ;BX=BX*10+AX
        MOV AX,10
        MUL BX
        MOV BX,AX
        POP AX
        ADD BX,AX
        
        ;ENTER NEXT CHARACTER
        MOV AH,1
        INT 21H
        JMP INPUT_DECIMAL_LOOP1
        
    END_INPUT_DECIMAL_LOOP1:
        ; IF CX=1(NEGATIVE) THEN NEGATE BX
        CMP CX,1
        JNE INPUT_DECIMAL_SKIP
        NEG BX
        
        INPUT_DECIMAL_SKIP:
            ;MOV BX TO AX
            MOV AX,BX
            ;RESTORE BX,CX
            POP CX
            POP BX
            RET    
INPUT_DECIMAL ENDP
;-----------------------------------------
;-----------------------------------------





;-----------------------------------------
;-----------------------------------------
;PROCEDURE: PRINT A SIGNED DECIMAL NUMBER

;@INPUT:
;   AX: NUMBER TO BE PRINTED
;@OUTPUT: *NOTHING*
;-----------------------------------------
OUTPUT_DECIMAL PROC
    ;SAVE REGISTERS
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    ;INITIALLY DIGIT_COUNT CX=0
    XOR CX,CX
    
    ;CHECK IF NEGATIVE,IF SO, PRINT A 
    ;'-'SIGN AND NEGATE BX
    CMP AX,0
    JGE OUTPUT_DECIMAL_SKIP1
    PUSH AX
    MOV AH,2
    MOV DL,'-'
    INT 21H
    POP AX
    NEG AX
    
    OUTPUT_DECIMAL_SKIP1:
    
    ;STORE THE DIGITS OF AX INTO A STACK
    ;AND KEEP THE DIGIT COUNT IN CX
    OUTPUT_DECIMAL_LOOP1:
        XOR DX,DX
        MOV BX,10
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JNE OUTPUT_DECIMAL_LOOP1
    
    ;PRINT THE CHARACTERS:
    JCXZ OUTPUT_DECIMAL_SKIP2
    MOV AH,2
    OUTPUT_DECIMAL_LOOP2:
        POP DX
        ADD DL,'0'
        INT 21H
        LOOP OUTPUT_DECIMAL_LOOP2
   
    OUTPUT_DECIMAL_SKIP2:
        ;RESTORE REGISTERS
        POP DX
        POP CX
        POP BX
        POP AX    
    RET    
OUTPUT_DECIMAL ENDP
;-----------------------------------------
;-----------------------------------------




;-----------------------------------------
;-----------------------------------------
;PROCEDURE: PRINT A STRING

;@INPUT:
;   DX: ADDRESS OF STRING
;@OUTPUT: *NOTHING*
;-----------------------------------------
PRINT_STRING PROC
    PUSH AX
    MOV AH,9
    INT 21H
    POP AX
    RET
PRINT_STRING ENDP
;-----------------------------------------
;-----------------------------------------




;-----------------------------------------
;-----------------------------------------
;PROCEDURE: SORT AN ARRAY OF DATA WORDS
;USING INSERTION SORT

;@INPUT:
;   SI: POINTER TO THE ARRAY
;   CX: SIZE OF THE ARRAY
;@OUTPUT: *NOTHING*
;-----------------------------------------
INSERTION_SORT PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
     
    MOV BX,1
    ;FOR BX=J=1 TO SIZE-1
    INSERTION_SORT_LOOP1:
        PUSH CX
        DEC CX
        CMP BX,CX
        POP CX
        JG END_INSERTION_SORT_LOOP1
        
        ;AX=KEY=ARR[J]
        PUSH SI
        MOV AX,BX
        ADD AX,AX
        ADD SI,AX
        MOV AX,[SI]
        POP SI
        
        ;DX=i=j-1
        MOV DX,BX
        DEC DX
        INSERTION_SORT_LOOP2:
            CMP DX,0
            JL END_INSERTION_SORT_LOOP2
            PUSH BX
            ;BX=A[i]
            PUSH SI
            MOV BX,DX
            ADD BX,BX
            ADD SI,BX
            MOV BX,[SI]
            POP SI
            CMP BX,AX
            JLE INSERTION_SORT_ELSE1
            PUSH SI
            ADD SI,DX
            ADD SI,DX
            ADD SI,2
            MOV [SI],BX
            POP SI
            POP BX
            DEC DX
            JMP INSERTION_SORT_LOOP2
            
            INSERTION_SORT_ELSE1:
                POP BX
                JMP END_INSERTION_SORT_LOOP2
            
            
               
        END_INSERTION_SORT_LOOP2:
        PUSH SI
        PUSH DX
        ADD DX,1
        ADD DX,DX
        ADD SI,DX
        POP DX
        MOV [SI],AX
        POP SI
        ;INCREASE BX/j
        INC BX
        JMP INSERTION_SORT_LOOP1 
            
    END_INSERTION_SORT_LOOP1:
        POP DX
        POP CX
        POP BX
        POP AX
    RET
INSERTION_SORT ENDP
;-----------------------------------------
;-----------------------------------------




;-----------------------------------------
;-----------------------------------------
;PROCEDURE: BINARY SEARCH

;@INPUT:
;   SI: POINTER TO THE ARRAY
;   CX: SIZE OF THE ARRAY
;   AX: NUMBER TO BE SEARCHED
;@OUTPUT:
;   BX: THE INDEX OF THE NUMBER,
;   RETURN -1 IF NOT FOUND
;-----------------------------------------
BINARY_SEARCH PROC
    PUSH AX
    PUSH CX
    PUSH DX
    
    ;DX=low=0
    XOR DX,DX
    
    ;CX=high= Array.length-1
    DEC CX
    
    
    BINARY_SEARCH_LOOP1:
        ;while low<=high loop
        CMP DX,CX
        JG  BINARY_SEARCH_UNSUCCESS
        
        ;BX=mid= floor((low+high)/2)
        MOV BX,DX
        ADD BX,CX
        PUSH AX
        PUSH DX
        XOR DX,DX
        MOV AX,BX
        MOV BX,2
        DIV BX
        MOV BX,AX
        POP DX
        POP AX
        
        ;CX=A[mid]
        PUSH SI
        PUSH CX
        MOV CX,BX
        ADD CX,CX
        ADD SI,CX
        MOV CX,[SI]
        
        
        CMP CX,AX
        POP CX
        POP SI
        
        ;CASE 1: A[mid]== x
        JE BINARY_SEARCH_CASE_1
        ;CASE 2: A[mid]< x
        JL BINARY_SEARCH_CASE_2
        ;CASE 3: A[mid]>x
        JMP BINARY_SEARCH_CASE_3
        
        BINARY_SEARCH_CASE_1:
            JMP END_BINARY_SEARCH
        BINARY_SEARCH_CASE_2:
            MOV DX,BX
            INC DX
            JMP BINARY_SEARCH_END_CASE
        BINARY_SEARCH_CASE_3:
            MOV CX,BX
            DEC CX
        
        BINARY_SEARCH_END_CASE:
            JMP BINARY_SEARCH_LOOP1
    
    BINARY_SEARCH_UNSUCCESS:
        MOV BX,-1
    END_BINARY_SEARCH:
        POP DX
        POP CX
        POP AX
        
    RET    
BINARY_SEARCH ENDP
;-----------------------------------------
;-----------------------------------------
END MAIN
