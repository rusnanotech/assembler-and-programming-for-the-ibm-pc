		page 60,132
TITLE	DISP CHAR (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
BEGIN:	JMP		MAIN

ROW		DB		08H		; ������ (������)

MAIN	PROC	NEAR
		MOV		DI,8	; ������� ������ �������
		CALL	CLN10	; �������� �����
M10:	CALL	CURS20
		CALL	DISP30
		INC		ROW		; ��������� ������
		DEC		DI
		JNE		M10
		RET
MAIN	ENDP	

CLN10	PROC	NEAR
		MOV		AX,0600H	;06 - ��������� ����� (07 - ����, 09 - ����� ������� � ���������), 00 - ���� ����� (��������� ������)
		MOV		BH,07		;���������� ������� (�����-�����)
		MOV		CX,0000		;������� ����� ������� (������, �������)
		MOV		DX,184FH	;������ ������ ������� (������, �������)
		INT		10H			;�������� ���������� � BIOS
		RET
CLN10	ENDP

CURS20	PROC	NEAR
		MOV		AH,02	;������ �� ��������� �������
		MOV		BH,00	;����� 0 (��������)
		MOV		DH,ROW	;������
		MOV		DL,39	;�������
		INT		10H		;�������� ���������� � BIOS
		RET
CURS20	ENDP
		
DISP30	PROC	NEAR
		MOV		AH,09		; ������� ������
		MOV		AL,0B3H		; ��������� ������
		MOV		BH,00		; ����� ��������
		MOV		BL,07H		; �������
		MOV		CX,1		; ����������
		INT		10H			; �������� ���������� � BIOS
		RET
DISP30	ENDP

CODESG	ENDS
		END		BEGIN