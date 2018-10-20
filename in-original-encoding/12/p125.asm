		page	60,132
		TITLE	P123 (EXE) �������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
BYTE1	DB		80H
BYTE2	DB		16H
WORD1	DW		2000H
WORD2	DW		0010H
WORD3	DW		1000H
DATASG	ENDS
;----------------------------------------------
CODESG  SEGMENT PARA 'Code'
BEGIN   PROC    FAR
		ASSUME  CS:CODESG,DS:DATASG,SS:STACKSG,ES:DATASG
        PUSH    DS
		SUB     AX,AX
        PUSH    AX
		MOV		AX,DATASG
		MOV		DS,AX
		MOV		ES,AX
		CALL	D10DIV
		CALL	E10IDIV
		RET
BEGIN	ENDP
;				����������� �������:
;				-------------------------------
D10DIV	PROC	NEAR
		MOV		AX,WORD1	;᫮��/����
		DIV		BYTE1		; ���:��� � AH:AL
		MOV		AL,BYTE1	;����/����
		SUB		AH,AH		;����. �������� � AH
		DIV		BYTE2		; ���:��� � AH:AL
		MOV		DX,WORD2	;��. ᫮��/᫮��
		MOV		AX,WORD3	; ������� � DX:AX
		DIV		WORD1		; ���:��� � DX:AX
		MOV		AX,WORD1	;᫮��/᫮��
		SUB		DX,DX		; ����. �������� � DX
		DIV		WORD3		; ���:��� � DX:AX
		RET
D10DIV	ENDP
;				�������� �������:
;				-------------------------------
E10IDIV	PROC	NEAR
		MOV		AX,WORD1	;᫮��/����
		IDIV	BYTE1		; ���:��� � AH:AL
		MOV		AL,BYTE1	;����/����
		CBW					;����. �������� � AH
		IDIV	BYTE2		; ���:��� � AH:AL
		MOV		DX,WORD2	;������� ᫮��/᫮��
		MOV		AX,WORD3	; ������� � DX:AX
		IDIV	WORD1		; ���:��� � DX:AX
		MOV		AX,WORD1	;᫮��/᫮��
		CWD					; ����. �������� � DX
		IDIV	WORD3		; ���:��� � DX:AX
		RET
E10IDIV	ENDP
CODESG  ENDS
		END BEGIN