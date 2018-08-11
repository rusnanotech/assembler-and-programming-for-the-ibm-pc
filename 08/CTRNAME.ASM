		page	60,132
		TITLE	CTRNAME (EXE)
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
;		������ ����������:
NAMEPAR	LABEL	BYTE
MAXLEN	DB		20					; ������������ ����� �����
NAMELEN	DB		?               	; ����� ��������� ��������
NAMEFLD	DB		20 DUP (' '),'$'	; ��������� ��� � ������������ ������ �� �����
PROMPT	DB		'Name? ','$'		; ��������� ����� ������� �� ����
DATASG	ENDS						;
;----------------------------------------------
CODESG  SEGMENT PARA 'Code'
BEGIN   PROC    FAR
		ASSUME  CS:CODESG,DS:DATASG,SS:STACKSG,ES:DATASG
        PUSH    DS
		SUB     AX,AX
        PUSH    AX
		MOV		AX,DATASG
		MOV		DS,AX
		MOV		ES,AX

		CALL	Q10CLR		; ������� ������
		MOV		DX,0000		; ��������� �������
		CALL	Q20CURS		; (0-� ������, 0-� �������)
		CALL	B10PRMP		; ������ ����� � ���������� �������
		CALL	D10INPT		; ������ ���
		CALL	Q10CLR		; ������� ������
		CMP		NAMELEN,00	; ��� �������?
		JE		A30			; 	��� - �����
		CALL	E10CODE		; ��������� ����� � '$' ��� ��������� ��������
		CALL	F10CENT		; ������������� � �����
A30:	RET
BEGIN   ENDP
;-------------------------------------------------------
;		����� ������ ������� �� ����:
B10PRMP	PROC	NEAR
		MOV		AH,09		; ������ ������ �� �����
		LEA		DX,PROMPT	; ����� ���������� �� ����� ���������
		INT		21H			; ����� DOS
		RET
B10PRMP	ENDP
;------------------------------------------------------
;		��������� �����:
D10INPT	PROC	NEAR
		MOV		AH,0AH		;������ ������� �����
		LEA		DX,NAMEPAR	;�������� ������ ������ ���������
		INT		21H			;����� DOS
		RET
D10INPT	ENDP
;------------------------------------------------------
;		��������� ����� � '$' ��� ��������� ��������:
E10CODE	PROC	NEAR
		MOV		BH,00
		MOV		BL,NAMELEN
		MOV		NAMEFLD[BX],07	;07H - ������ �����
		MOV		NAMEFLD[BX+1],'$'
		RET
E10CODE	ENDP
;-------------------------------------------------------
;		������������� � ����� �����:
F10CENT	PROC	NEAR
		MOV		DL,NAMELEN	; ����������� �������
		SHR		DL,1		;  ��������� �� 2,
		NEG		DL			;  �������� ����,
		ADD		DL,40		;  ��������� 40
		MOV		DH,12		; ����������� ������
		CALL	Q20CURS		; ���������� ������

		MOV		AH,09		; ������ ������ �� �����
		LEA		DX,NAMEFLD	; ����� ���������� �� ����� ���������
		INT		21H			; ����� DOS
		RET
F10CENT	ENDP
;-------------------------------------------------------
;		������� ������:
Q10CLR	PROC	NEAR
		MOV		AX,0600H	; 06 - ���������, 00 - ���� �����
		MOV		BH,30		; ���� (07 - ��� �/�)
		MOV		CX,0000		; ������� ����� ������� (������, �������)
		MOV		DX,184FH	; ������ ������ ������� (������, �������)
		INT		10H			; �������� ���������� � BIOS
		RET
Q10CLR	ENDP
;-------------------------------------------------------
;		��������� �������:
Q20CURS	PROC	NEAR		; ���������� ������� ��� �����������
		MOV		AH,02		; ������ �� ��������� �������
		MOV		BH,00		; �������� #0
		INT		10H			; ������� ���������� � BIOS
		RET
Q20CURS	ENDP
;----------------------------------------------
CODESG  ENDS
		END BEGIN