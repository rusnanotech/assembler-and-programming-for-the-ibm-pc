TITLE	ASCII (COM) ������� ASCII � ����.
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG,ES:CODESG
		ORG		100H
BEGIN:	JMP		MAIN
;-----------------------------------------------------------
DISPROW	DB	3 DUP(' ')		; ��������� ����. �����.
HEXSTR	DB	00, 0B3H		; ��������� ASCII-����.
XLATAB	DB	30H,31H,32H,33H,34H
		DB	35H,36H,37H,38H,39H
		DB	41H,42H,43H,44H,45H,46H
BORDER	DB	0CDH
SPACE	DB	20H
HNODE	DB	0D1H
MNODE	DB	0B5H
LNODE	DB	0CFH
HCORNER	DB	0B8H
LCORNER	DB	0BEH
TNAME	DB	'ASCII Table (created by V.A. Markov)'
;-----------------------------------------------------------
MAIN	PROC	NEAR
		CALL	Q10CLR
		CALL	B10TAB
		CALL	D10BORD
		RET
MAIN	ENDP
;				����� �������:
;				--------------------------------------------
B10TAB	PROC	NEAR
		MOV		DX,0300H	; ��������� ������ � �������
B20:
		MOV		SI,OFFSET DISPROW	; ��������� �����
		CALL	C10HEX		; ��������������
		MOV		CX,1		; ����� ���������� (�����)
		MOV		DI,5		; ������� ����� ������
B30:	CALL	P10DISP		; ������� �� �����
		INC		SI
		INC		DL			; ��������� �������
		DEC		DI
		JNZ		B30
		CMP		HEXSTR,0FFH	; ��������� ������?
		JZ		B90			;	�� - �����
		INC		HEXSTR
		INC		DH
		CMP		DH,19
		JNZ		B50
		MOV		DH,3
		JMP		B20
B50:
		SUB		DL,5
		JMP		B20	
B90:	RET
B10TAB	ENDP
;				�������������:
;				--------------------------------------------
C10HEX	PROC	NEAR
		MOV		AL,HEXSTR	; ��������� � �������������
		MOV		AH,AL		;	����������������� ������.
		MOV		CL,4
		SHR		AL,CL
		AND		AH,0FH
		MOV		BX,OFFSET XLATAB	; �������������� � ���������.
		XLAT
		MOV		[SI],AL
		MOV		AL,AH
		XLAT
		MOV		[SI+1],AL
		RET
C10HEX	ENDP
;				���������� ������ �������:
;				--------------------------------------------
D10BORD	PROC
		MOV		CX,80		; ����� ���������� (�����)
		SUB		DX,DX

		MOV		SI,OFFSET SPACE	; ������� ���������
		MOV		DH,1
		CALL	P10DISP

		MOV		SI,OFFSET BORDER	; �������

		MOV		DH,19		;	- ������
		CALL	P10DISP

		MOV		DH,0		;	- �������
		CALL	P10DISP
		
		MOV		DH,2		;	- ������
		CALL	P10DISP
		
		MOV		CX,1		; ���� ������� �������
		DEC		DL
D20:	ADD		DL,5
		MOV		SI,OFFSET HNODE
		CALL	P10DISP
		CMP		DL,79
		JNZ		D20

		MOV		SI,OFFSET MNODE	; ������� ������ ����
		CALL	P10DISP

		MOV		SI,OFFSET HEXSTR+1	; ������ ������� ���������
		DEC		DH
		CALL	P10DISP

		MOV		SI,OFFSET HCORNER	; ������� ������ ����
		DEC		DH
		CALL	P10DISP

		MOV		SI,OFFSET TNAME	; ���������
		MOV		CX,1
		MOV		DX,0116H
D30:	INC		DL
		CALL	P10DISP
		INC		SI
		CMP		DL,58
		JNZ		D30
		
		MOV		DX,13FFH	; ���� ������ �������
D40:	ADD		DL,5
		MOV		SI,OFFSET LNODE
		CALL	P10DISP
		CMP		DL,79
		JNZ		D40
		
		MOV		SI,OFFSET LCORNER	; ������ ������ ����
		CALL	P10DISP
		
		RET
D10BORD	ENDP
;				����� �� �����:
;				--------------------------------------------
P10DISP	PROC	NEAR
		MOV		BX,001FH	; ����� 0, ������� 1F
		MOV		AH,02		; ������ �� ��������� �������
		INT		10H			; �������� ���������� � BIOS
		MOV		AH,09H		; ������ ������ �����./����.
		MOV		AL,[SI]		; ��������� ������
		INT		10H			; �������� ���������� � BIOS
		RET
P10DISP	ENDP
;				������� ������:
;				--------------------------------------------
Q10CLR	PROC	NEAR
		MOV		AX,0600H
		MOV		BH,07
		SUB		CX,CX
		MOV		DX,184FH
		INT		10H
		RET
Q10CLR	ENDP
CODESG	ENDS
		END		BEGIN