		page 60,132
TITLE	CLEAN (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
MAIN	PROC	NEAR
		MOV		AX,0600H	;06 - ��������� ����� (07 - ����, 09 - ����� ������� � ���������), 00 - ���� ����� (��������� ������)
		MOV		BH,07		;���������� ������� (�����-�����)
		MOV		CX,0000		;������� ����� ������� (������, �������)
		MOV		DX,184FH	;������ ������ ������� (������, �������)
		INT		10H			;�������� ���������� � BIOS
		RET
MAIN	ENDP
CODESG	ENDS
		END MAIN