		page 60,132
TITLE	X84 (COM) ; ���. 8.4. ����� �� ����� ����������� DOS
CODESG	SEGMENT	PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
BEGIN:	JMP		MAIN
;--------------------------------------------------------------
;		������ � ����������:
DISAREA	DB		'Enter date (dd/mm/yy)',07H,13,10; ��������� ���������
;--------------------------------------------------------------
;		����� �� �����:
MAIN	PROC	NEAR
		MOV		AH,40H		; ������ ������ �� �����
		MOV		BX,01		; �������� ���������� (1 - �����)
		MOV		CX,24		; ����. ����� ��������� (� ������)
		LEA		DX,DISAREA	; ����� ������� ������ � ����������
		INT		21H			; ����� DOS
		RET
MAIN	ENDP
CODESG	ENDS
		END		BEGIN