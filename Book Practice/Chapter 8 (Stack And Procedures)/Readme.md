# Stack And Procedures

## At the start of a procedure,Always push the registers you'll use ##temporarily into the stack. Then pop into them at the end of procedure. ##In this way the registers values will remain unchanged after the ##procedure is called. Obviously, Do not push those registers which are used for I/O with the calling procedure.


### For example, Suppose a procedure INPUT_NUMBER takes a decimal input ###from console and puts it in the AX.While doing so, it uses BX,CX and DX ###temporarily. The procedure ought to be like this:

~~~
 INPUT_NUMBER PROC
	PUSH BX
	PUSH CX
	PUSH DX

	; Procedure Body here;
	
	;pop them into reverse order
	PUSH DX
	PUSH CX
	PUSH BX

INPUT_NUMBER ENDP
~~~
 