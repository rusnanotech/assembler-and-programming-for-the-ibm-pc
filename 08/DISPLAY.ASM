		page 60,132
TITLE	DISPLAY (COM)
CODESG	SEGMENT	PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H

BEGIN:	JMP		MAIN
NAMPRMP	DB		'Enter you name','$'

MAIN	PROC	NEAR
		MOV		AH,09		;������ ������ �� �����
		LEA		DX,NAMPRMP	;����� ���������� �� ����� ���������
		INT		21H			;����� DOS
		RET
MAIN	ENDP
CODESG	ENDS
		END		BEGIN