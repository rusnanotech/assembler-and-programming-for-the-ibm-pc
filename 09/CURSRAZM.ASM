		page 60,132
TITLE	CURSOR (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
MAIN	PROC	NEAR
		MOV		AH,01	;��������� ������� �������
		MOV		CH,00	;������� ����� ������������
		MOV		CL,13	;������ ����� ������������
		INT		10H		;�������� ���������� � BIOS
		RET
MAIN	ENDP
CODESG	ENDS
		END MAIN