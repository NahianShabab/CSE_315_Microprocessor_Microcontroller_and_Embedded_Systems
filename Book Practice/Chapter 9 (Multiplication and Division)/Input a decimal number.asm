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
    
        
    call INPUT_DEC 
     
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP





INPUT_DEC PROC
  
  push bx
  push cx
  
  MOV AH,1
  int 21h
  
  ;cx = 0 (positive)
  xor cx,cx
  
  ; number bx=0 initially
  mov bx,0
  
  ;check for leading sign
  cmp al,'+'
  je INPUT_DEC_PLUS
  cmp al,'-'
  je INPUT_DEC_MINUS
  jmp INPUT_DEC_LOOP1
  
  INPUT_DEC_MINUS:
  mov cx,1
  int 21h
  
  INPUT_DEC_PLUS:
  int 21h
  
  ;loop for input digits
  INPUT_DEC_LOOP1:
    ;check if input is carriage return
    cmp al,cr
    je END_INPUT_DEC_LOOP1
  
    ;store digit in ax
    and ax,000fh
    
    push ax
    
    mov ax,10
    mul bx
    
    mov bx,ax
    
    pop ax
    
    add bx,ax
    
    mov ah,1
    int 21h
    
    jmp INPUT_DEC_LOOP1  
    
      
  END_INPUT_DEC_LOOP1:
    mov ax,bx
    
    pop cx
    pop bx
    
    ret
    
         
INPUT_DEC ENDP



END MAIN
