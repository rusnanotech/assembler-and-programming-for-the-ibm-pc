		page 60,132
TITLE	KEYB (COM)
CODESG	SEGMENT	PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG,ES:NOTHING
		ORG		100H
BEGIN:	JMP		SHORT INP
;------------------------------------------------------
;		������ ����������:
NAMEPAR	LABEL	BYTE
MAXLEN	DB		20				; ������������ �����
ACTLEN	DB		?               ; �������� �����
NAMEFLD	DB		20 DUP (' ')    ; ��������� �������
;------------------------------------------------------
;		��������� �����:
INP		PROC	NEAR
		MOV		AH,0AH		;������ ������� �����
		LEA		DX,NAMEPAR	;�������� ������ ������ ���������
		INT		21H			;����� DOS
		RET
INP		ENDP
CODESG	ENDS
		END		BEGIN