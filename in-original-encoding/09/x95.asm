		page 60,132
TITLE	EX95 (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
MAIN	PROC	NEAR
A10:	SUB		AX,AX
		INT		16H
		CMP		AL,00		; ������ ����������� �������?
		JNZ		A10
		CMP		AH,51H		; ������ ������� PgDn?
		JNZ		A10
		CALL	CURS
		RET
MAIN	ENDP
CURS	PROC NEAR
		MOV		AH,02		; ������ �� ��������� �������
		MOV		BH,00		; ����� 0 (��������)
		MOV		DH,12		; ������ ��� �������
		MOV		DL,00		; ������� ��� ������
		INT		10H			; �������� ���������� � BIOS
		RET
CURS	ENDP
CODESG	ENDS
		END MAIN