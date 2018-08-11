		page	60,132
		TITLE	EX115A (EXE) ��������� �������� (������ �)
;											����� �����������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
NAME1	DB		03H,04H,05H,0B4H
NAME2	DB		80 DUP(' ')
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
		CALL	B10MOVE		; ���������
		CALL	C10SCR		; ������� ������
		CALL	D10DISP
		RET
BEGIN	ENDP
;				��������� � ������������� (������ �):
;				-------------------------------
B10MOVE	PROC	NEAR
		CLD
		LEA		SI,NAME1
		LEA		DI,NAME2
		MOV		CX,40
		REP MOVSW
		RET
B10MOVE	ENDP
;				������� ������:
;				-------------------------------
C10SCR	PROC	NEAR
		MOV		AX,0600H	;06 - ��������� ����� 00 - ���� �����
		MOV		BH,07		;���������� ������� (�����-�����)
		SUB		CX,CX		;������� ����� ������� (������, �������)
		MOV		DX,184FH	;������ ������ ������� (������, �������)
		INT		10H			;�������� ���������� � BIOS
		RET
C10SCR	ENDP
;				����� ����������:
;				-------------------------------
D10DISP	PROC	NEAR
		SUB		DX,DX		; ������ � ������� (������)
		MOV		BH,00		; ����� 0 (������, �����)
		MOV		CX,01		; ����� ���������� (�����)
		LEA		SI,NAME2
		MOV		BL,80		; �������
		
D20:	MOV		AH,02		; ������ �� ��������� �������
		INT		10H			; �������� ���������� � BIOS
		MOV		AH,0AH		; ������ ������ �������
		MOV		AL,[SI]		; ��������� ������
		INT		10H			; �������� ���������� � BIOS
		INC		SI
		INC		DL			; ��������� �������
		CMP		DL,20
		JNZ		D30
		SUB		DL,DL
		INC		DH

D30:	DEC		BL
		JNZ		D20
		RET
D10DISP	ENDP
CODESG  ENDS
		END BEGIN