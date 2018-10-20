		page	60,132
		TITLE	EX711 (EXE)
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
X		DW		4DCFH	;�������� ��������
Y1		DW		?		;���������
Y2		DW		?
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

		MOV		AX,X		;�������� ��������� ��������
		TEST	AX,8000H	;�������� �������� �� ����
		JS		NEGX		;� ���������� �������� ��� �����. �����
		SUB		BX,BX		;������� �������� BX
		JMP		CALC		;���������� � ��������
NEGX:	MOV		BX,0FFFFH	;�������� ������ �� ��� ����

CALC:	CALL	X10
		RET
BEGIN   ENDP
;----------------------------------------------
X10		PROC
		SHL		AX,1		;��������� �� 2 (2x)
		MOV		DX,AX		;���������� ����������� ��������

		SHL		AX,1		;��������� �� 4 (8x)
		RCL		BX,1
		SHL		AX,1
		RCL		BX,1

		TEST	BX,8000H	;�������� �������� �� ����
		JS		NEGX10		;� �������� �����. �����

		ADD		AX,DX		;��������� ��������� �������� (10x)
		JNC		ENDX10		;���� ��� �������� - � ���������
		INC		BX			;��������� BX �� 1, ���� �������
		JMP		ENDX10

NEGX10:	ADD		AX,DX		;��������� ��������� �������� (10x)
		JC		ENDX10		;���� ���� ������� - � ���������
		DEC		BX			;��������� BX �� 1, ���� ��� ��������

ENDX10:	MOV		Y1,AX		;������ ����������� � ������
		MOV		Y2,BX
		RET
X10		ENDP
;----------------------------------------------
CODESG  ENDS
		END BEGIN