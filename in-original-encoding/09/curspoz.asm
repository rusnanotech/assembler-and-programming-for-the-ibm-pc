		page 60,132
TITLE	CURSOR (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
MAIN	PROC	NEAR
		MOV		AH,02	;������ �� ��������� �������
		MOV		BH,00	;����� 0 (��������)
		MOV		DH,15	;15-� ������
		MOV		DL,42	;42-� �������
		INT		10H		;�������� ���������� � BIOS
		RET
MAIN	ENDP
CODESG	ENDS
		END MAIN