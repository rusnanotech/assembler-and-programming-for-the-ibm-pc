		page	60,132
		TITLE	EXRING (EXE) ������������ ������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
NAMEPAR	LABEL	BYTE
MAXNLEN	DB		31
ACTNLEN	DB		?
NAMEFLD	DB		31 DUP(' ')
PROMPT	DB		'Name? ','$'
NAMEDSP	DB		31 DUP(' '),13,10,'$'
ROW		DB		00
DATASG	ENDS
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
		MOV		AX,0600H
		CALL	Q10SCR		; �������� �����
		SUB		DX,DX		; ���������� ������ � 0
		CALL	Q20CURS
A10LOOP:
		CALL	B10PRMT		; ������ ���
		CALL	C10INPT		; ����
		TEST	ACTNLEN,0FFH; ��� �����?
		JZ		A90			;  �� - �����
		CALL	D10SCAS		; ����� ���������
		CMP		AL,'*'		; �������?
		JE		A10LOOP		;  �� - ������
		CALL	E10RGHT		; ��������� ��� ������
		CALL	F10CLNM
		JMP		A10LOOP
A90:	RET
BEGIN   ENDP
;				����� ��������� �� �����:
;				-------------------------------
B10PRMT	PROC	NEAR
		MOV		AH,09		;������ ������ �� �����
		LEA		DX,PROMPT	;����� ���������� �� ����� ���������
		INT		21H			;����� DOS
		RET
B10PRMT	ENDP
;				���� � ����������:
;				-------------------------------
C10INPT	PROC	NEAR
		MOV		AH,0AH		;������ ������� �����
		LEA		DX,NAMEPAR	;�������� ������ ������ ���������
		INT		21H			;����� DOS
		RET
C10INPT	ENDP
;				����� '*':
;				-------------------------------
D10SCAS	PROC	NEAR
		CLD					; �����������
		MOV		CX,30
		LEA		DI,NAMEFLD	; ����������
		MOV		AL,'*'		; ����� ������� �� [DI]
		REPNE SCASB			; ������?
		JE		D20			;  �� - �����,
		MOV		AL,20H		;  ��� - ������� * � AL
D20:	RET
D10SCAS	ENDP
;				MOVSB:
;				-------------------------------
E10RGHT	PROC	NEAR
		STD					; ����������� ���������
		SUB		CH,CH
		MOV		CL,ACTNLEN	; ����� CX ��� REP
		LEA		SI,NAMEFLD	; ������ �������
		ADD		SI,CX
		DEC		SI
		LEA		DI,NAMEDSP+30
		REP MOVSB			; ��������� ������ ������
		MOV		DH,ROW
		MOV		DL,48
		CALL	Q20CURS
		MOV		AH,09
		LEA		DX,NAMEDSP	; ������ ����������� �����
		INT		21H
		CMP		ROW,20		; ��������� ������
		JAE		E20			;  ��� -
		INC		ROW			;  ��������� ����� ������
		JMP		E90
E20:
		MOV		AX,0601H
		CALL	Q10SCR
		MOV		DH,ROW
		MOV		DL,00
		CALL	Q20CURS
E90:	RET
E10RGHT	ENDP
;				������� ������� �����:
;				-------------------------------
F10CLNM	PROC	NEAR
		CLD					; ����������� ���������
		LEA		DI,NAMEDSP	; ����������
		MOV		CX,15
		MOV		AX,2020H	; ��������� �������
		REP STOSW
        RET
F10CLNM	ENDP
;				������� ������:
;				-------------------------------
Q10SCR	PROC	NEAR
		MOV		BH,07		;���������� ������� (�����-�����)
		MOV		CX,0000		;������� ����� ������� (������, �������)
		MOV		DX,184FH	;������ ������ ������� (������, �������)
		INT		10H			;�������� ���������� � BIOS
        RET
Q10SCR	ENDP
;				��������� �������:
;				-------------------------------
Q20CURS	PROC	NEAR
		MOV		AH,02	; ������ �� ��������� �������
		MOV		BH,00	; ����� 0 (��������)
		INT		10H		; �������� ���������� � BIOS
		RET
Q20CURS	ENDP
CODESG  ENDS
		END BEGIN