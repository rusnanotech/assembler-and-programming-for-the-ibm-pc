		page	60,132
		TITLE	NMSCROLL (EXE) ��������, �������, ���������
;-------------------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;-------------------------------------------------------
DATASG	SEGMENT	PARA 'Data'
;		������ ����������:
NAMEPAR	LABEL	BYTE
MAXLEN	DB		20					; ������������ ����� �����
ACTLEN	DB		?               	; ����� ��������� ��������
NAMEFLD	DB		20 DUP (' ')		; ��������� ���
COL		DB		00
COUNT	DB		?
PROMPT	DB		'Name? '
ROW		DB		00
DATASG	ENDS						;
;-------------------------------------------------------
CODESG  SEGMENT PARA 'Code'
BEGIN   PROC    FAR
		ASSUME  CS:CODESG,DS:DATASG,SS:STACKSG,ES:DATASG
        PUSH    DS
		SUB     AX,AX
        PUSH    AX
		MOV		AX,DATASG
		MOV		DS,AX
		MOV		ES,AX
		MOV		AX,0600H
		CALL	Q10CLR		; �������� �����
A20LOOP:
		MOV		COL,00		; ���������� ������� 0
		CALL	Q20CURS
		CALL	B10PRMP		; ������ ����� �������
		CALL	D10INPT		; ������ � ����������
		CMP		ACTLEN,00	; ��� �����?
		JNE		A30			;  ���� ��,
		MOV		AX,0600H	;  �� �������� �����
		CALL	Q10CLR		;  � ��������� ���������
		RET
A30:	
		CALL	E10NAME
		JMP		A20LOOP
		RET
BEGIN   ENDP
;-------------------------------------------------------
;		����� ������ �������:
B10PRMP	PROC	NEAR
		LEA		SI,PROMPT	; ����� ������
		MOV		COUNT,05
B20:
		MOV		BL,70H		; �������������
		CALL	F10DISP		; ������������ ������
		INC		SI			; ��������� ��������
		INC		COL			; ��������� �������
		CALL	Q20CURS
		DEC		COUNT		; ���������� ��������
		JNZ		B20			; ��������� n ���
		RET
B10PRMP	ENDP
;-------------------------------------------------------
;		������� ������:
D10INPT	PROC	NEAR
		MOV		AH,0AH		; ������ ������� �����
		LEA		DX,NAMEPAR	; �������� ������ ������ ���������
		INT		21H			; ����� DOS
		RET
D10INPT	ENDP
;-------------------------------------------------------
;		����� � �������� � ���������:
E10NAME	PROC	NEAR
		LEA		SI,NAMEFLD	; ����� �����
		MOV		COL,40		; ���������� �������
E20:
		CALL	Q20CURS		; ���������� ������
		MOV		BL,0F0H		; ������� � ��������
		CALL	F10DISP     ; ������������ ������
		INC		SI          ; ��������� ������
		INC		COL         ; ��������� �������
		DEC		ACTLEN      ; ��������� �������
		JNZ		E20         ; ������� n ���
		CMP		ROW,20      ; ��������� ������?
		JAE		E30         ;  ���
		INC		ROW         ; 
		RET                 ; 
E30:	MOV		AX,0601H    ;  �� --
		CALL	Q10CLR      ;  �������� �����
		RET
E10NAME	ENDP
;-------------------------------------------------------
;		������� ������:
F10DISP	PROC	NEAR
		MOV		AH,09		; ������� ������
		MOV		AL,[SI]		; ��������� ������
		MOV		BH,00		; ����� ��������
		MOV		CX,01		; ����������
		INT		10H			; �������� ��������� � BIOS
F10DISP	ENDP
;-------------------------------------------------------
;		������� ������:
Q10CLR	PROC	NEAR
		MOV		BH,07		; ���������� ������� (�����-�����)
		MOV		CX,0000		; ������� ����� ������� (������, �������)
		MOV		DX,184FH	; ������ ������ ������� (������, �������)
		INT		10H			; �������� ���������� � BIOS
		RET
Q10CLR	ENDP
;-------------------------------------------------------
;		���������� ������:
Q20CURS	PROC	NEAR
		MOV		AH,02		; ������ �� ��������� �������
		MOV		BH,00		; ����� 0 (��������)
		MOV		DH,ROW		; ������
		MOV		DL,COL		; �������
		INT		10H			; �������� ���������� � BIOS
		RET
Q20CURS	ENDP
;-------------------------------------------------------
CODESG  ENDS
		END BEGIN