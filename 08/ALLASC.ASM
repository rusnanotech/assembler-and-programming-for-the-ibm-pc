		page 60,132
TITLE	ALLASC (COM)
CODESG	SEGMENT	PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG,ES:NOTHING
		ORG		100H
BEGIN:	JMP		SHORT MAIN
CTR		DB		00,'$'
;-------------------------------------------------------
;		�������� ���������:
MAIN	PROC	NEAR
		CALL	B10CDR		;�������� �����
		CALL	C10SET		;���������� ������
		CALL	D10DISP		;������� ������� �� �����
		RET
MAIN	ENDP
;-------------------------------------------------------
;		������� ������:
B10CDR	PROC
		MOV		AX,0600H	;06 - ���������, 00 - ���� �����
		MOV		BH,07		;���������� ������� (�����-�����)
		MOV		CX,0000		;������� ����� �������
		MOV		DX,184FH	;������ ������ �������
		INT		10H			;�������� ��������� � BIOS
		RET
B10CDR	ENDP
;-------------------------------------------------------
;		��������� �������:
C10SET	PROC
		MOV		AH,02		;������ �� ��������� �������
		MOV		BH,00		;����� 0
		MOV		DX,0000		;0-� ������, 0-� �������
		INT		10H			;�������� ���������� � BIOS
		RET
C10SET	ENDP
;-------------------------------------------------------
;		����� �� ����� ASCII-��������:
D10DISP	PROC
		MOV		CX,256		;256 �������� ��� 256 ��������
		MOV		AH,09		;������ ������ �� �����
		LEA		DX,CTR		;����� ���������� �� ����� ���������

D20:	INT		21H			;����� DOS
		INC		CTR
		LOOP	D20
		RET
D10DISP	ENDP

CODESG	ENDS
		END BEGIN