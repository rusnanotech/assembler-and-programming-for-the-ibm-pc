		page 60,132
TITLE	DISP CHAR (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
MAIN	PROC	NEAR
		MOV		AH,09		; ������� ������
		MOV		AL,0C4H		; ��������� ������
		MOV		BH,00		; ����� ��������
		MOV		BL,0F0H		; ������� (�������, ��������)
		MOV		CX,25		; ���� ����������
		INT		10H			; �������� ���������� � BIOS
		RET
MAIN	ENDP
CODESG	ENDS
		END MAIN