		page	60,132
		TITLE	P122 (EXE) �������� ������� ����
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
WORD1A	DW		0123H
WORD1B	DW		0BC62H
WORD2A	DW		0012H
WORD2B	DW		553AH
WORD3A	DW		?
WORD3B	DW		?
WORD5A	DW		?
WORD5B	DW		?
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
		CALL	D10DWD		; ������ 1
		CALL	E10DWD		; ������ 2
		RET
BEGIN	ENDP
;				������ 1:
;				-------------------------------
D10DWD	PROC	NEAR
		MOV		AX,WORD1B	; ������� ������ �����
		ADD		AX,WORD2B
		MOV		WORD3B,AX
		MOV		AX,WORD1A	; ������� ����� �����
		ADC		AX,WORD2A	;  � ���������
		MOV		WORD3A,AX
		RET
D10DWD	ENDP
;				������ 2:
;				-------------------------------
E10DWD	PROC	NEAR
		CLC					; �������� ���� ��������
		MOV		CX,2
		LEA		SI,WORD1B	; ������
		LEA		DI,WORD2B	;  �����
		LEA		BX,WORD5B	; ����� ������ ����
E20:	
		MOV		AX,[SI]
		ADC		AX,[DI]
		MOV		[BX],AX
		DEC		SI
		DEC		SI
		DEC		DI
		DEC		DI
		DEC		BX
		DEC		BX
		LOOP	E20
		RET
E10DWD	ENDP
CODESG  ENDS
		END BEGIN