		page 60,132
TITLE	DISP UP (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
MAIN	PROC	NEAR
		MOV		AX,0600H	; 06H - ��������� �����, 04H - �� 4 ������, 00H - ��� ������
		MOV		BH,07		; �������: ����������, �/�
		MOV		CX,0000H	; ���������� �� 00,00 (0000H - ������)
		MOV		DX,184FH	;  �� 24,79 (184FH - ���� �����)
		INT		10H			; �������� ���������� � BIOS
		RET
MAIN	ENDP
CODESG	ENDS
		END MAIN