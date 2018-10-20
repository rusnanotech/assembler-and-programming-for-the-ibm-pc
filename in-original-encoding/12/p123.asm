		page	60,132
		TITLE	P123 (EXE) ���������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
BYTE1	DB		80H
BYTE2	DB		40H
WORD1	DW		8000H
WORD2	DW		4000H
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
		CALL	C10MUL		; ��������� MUL
		CALL	D10IMUL		; ��������� IMUL
		RET
BEGIN	ENDP
;				��������� MUL (�����������):
;				-------------------------------
C10MUL	PROC	NEAR
		MOV		AL,BYTE1	; ���� * ����
		MUL		BYTE2		;  ������������ � AX
		MOV		AX,WORD1	; ����� * �����
		MUL		WORD2		;  ������������ � DX:AX
		MOV		AL,BYTE1	; ���� * �����
		SUB		AH,AH		;  ���������� ���������
		MUL		WORD1		;  ������������ � DX:AX
		RET
C10MUL	ENDP
;				��������� IMUL (��������):
;				-------------------------------
D10IMUL	PROC	NEAR
		MOV		AL,BYTE1	; ���� * ����
		IMUL	BYTE2		;  ������������ � AX
		MOV		AX,WORD1	; ����� * �����
		IMUL	WORD2		;  ������������ � DX:AX
		MOV		AL,BYTE1	; ���� * �����
		CBW					;  ���������� ���������
		IMUL	WORD1		;  ������������ � DX:AX
		RET
D10IMUL	ENDP
CODESG  ENDS
		END BEGIN