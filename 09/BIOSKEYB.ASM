		page 60,132
TITLE	BIOSKEYB (COM) ���� ���� � ����� �� �� ����� ���������� BIOS
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG
		ORG		100H
BEGIN:	JMP		MAIN
;---------------------------------------------
;		������:
CHAR	DB		20 DUP(?)
CYCLE	DW		?
TEXT	DB		'Copyright (C) V.A. Markov 2018'
DUMPDI	DW		?
;---------------------------------------------
;		������� ���������:
MAIN	PROC	NEAR
		SUB		CX,CX
		CALL	CLEAN
		CALL	INPUT
		CMP		SI,00		; ������� ������� - ������ ������?
		JZ		EXIT		;  ���� �� - ��������� ���������
		MOV		CX,0100H
		CALL	CLEAN
		CALL	OUTPUT
EXIT:	RET	
MAIN	ENDP
;---------------------------------------------
;		��������� �����:
INPUT	PROC	NEAR
I05:	SUB		SI,SI		; ��������� 0 �������
		LEA		DI,CHAR		; ��������� 1 �������
I10:	MOV		DX,SI		; ������� (� DL)
		MOV		DH,00		; ������
		CALL	CURSOR

I20:	CALL	READCHR
		CMP		AL,08H		; ������ ������� �������� (Backspace)?
		JZ		I90			;  - ���� ��, �� �������
		CMP		AL,0DH		; ����� ������� �������?
		JZ		I80
		CMP		AL,00		; ������ ����������� �������?
		JNZ		I30
		CMP		AH,3BH		; ������ ������� F1?
		JZ		I85

I30:	CALL	DISPCHR
		INC		DI			; ��������� ������
		INC		SI			; ��������� �������
		CMP		SI,19		; ����� ��������� �������� �������� 20?
		JNZ		I10			; 	���� ���, ��������� ���������

I80:	RET

I85:	CALL	HELP
		JMP		I10

I90:	DEC		SI			; ������� �� ����� ������ �������?
		JS		I05			;  ���� ���, �� ������ ��
		DEC		DI
		MOV		DX,SI		; ������� (� DL)
		CALL	CURSOR
		MOV		AL,20H
		CALL	DISPCHR
		JMP		I20
		INPUT	ENDP
;---------------------------------------------
;		����� �������:
HELP	PROC	NEAR
		MOV		DUMPDI,DI	; ��������� ���������� DI
		LEA		DI,TEXT
		MOV		BL,30		; ���������� ���-�� ������
		MOV		DL,25		; ������� (� DL)
		MOV		DH,12		; ����������� ������
H30:	CALL	CURSOR		; ���������� ������
		MOV		AL,[DI]		; ��������� ������
		CALL	DISPCHR
		INC		DI			; ��������� ������
		INC		DL			; ��������� ������� (������) �������
		DEC		BL
		JNZ		H30
		MOV		DI,DUMPDI	; ������� ������� ���������� � DI
		RET
HELP	ENDP
;---------------------------------------------
;		��������� ������:
OUTPUT	PROC	NEAR
		MOV		CYCLE,SI		; ���������� ���-�� ������
		SUB		DI,SI		; ��������� � ������� �������
		MOV		DL,39		; ������� (� DL)
		MOV		DH,12		; ����������� ������
		MOV		CX,SI
		SHR		CL,1
		SUB		DH,CL		; ��������� ������
O30:	CALL	CURSOR		; ���������� ������
		MOV		AL,[DI]		; ��������� ������
		CALL	DISPCHR
		INC		DI			; ��������� ������
		INC		DH			; ��������� ������� (������) �������
		DEC		CYCLE
		JNZ		O30
		RET
OUTPUT	ENDP
;---------------------------------------------
;		������� ������:
CLEAN	PROC	NEAR
		MOV		AX,0600H	; 06 - ��������� �����, 00 - ���� ����� (��������� ������)
		MOV		BH,07		; ���������� ������� (�����-�����)
;		MOV		CX,0000		; ������� ����� ������� (������, �������)
		MOV		DX,184FH	; ������ ������ ������� (������, �������)
		INT		10H			; �������� ���������� � BIOS
		RET
CLEAN	ENDP
;---------------------------------------------
;		��������� �������:
CURSOR	PROC	NEAR
		MOV		AH,02		; ������ �� ��������� �������
		MOV		BH,00		; ����� 0 (��������)
;		MOV		DH,00		; ������ ��� �������
;		MOV		DL,00		; ������� ��� ������
		INT		10H			; �������� ���������� � BIOS
		RET
CURSOR	ENDP
;---------------------------------------------
;		������ ���������� ������� � ��������� ��� � AL:
READCHR	PROC	NEAR
		MOV		AH,00		; ������� ������ �������
		INT		16H
		MOV		[DI],AL		; ��������� ������� � ������
		RET
READCHR	ENDP
;---------------------------------------------
;		����� ������� �� �����:
DISPCHR	PROC	NEAR
		MOV		AH,0AH		; ����� �������
;		MOV		AL,CHAR		; ��������� ������ ��� � AL
		MOV		BH,00		; ��������
		MOV		CX,01		; ����� ����������
		INT		10H			; �������� ���������� � BIOS
		RET
DISPCHR	ENDP
;---------------------------------------------
CODESG	ENDS
		END BEGIN