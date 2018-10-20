TITLE	MEM (COM)
CODESG	SEGMENT PARA 'Code'
		ASSUME	CS:CODESG,DS:CODESG,SS:CODESG,ES:CODESG
		ORG		100H
BEGIN:	JMP		MAIN
MEMBIN	DW		2 DUP(?)
MESSG1	DB		'Memory size: '
MEMASC	DB		8 DUP(20H)
MESSG2	DB		' bytes'
;				������� ���������:
;				--------------------------------------------
MAIN	PROC	NEAR
		CALL	B10MEM
		CALL	C10ASC
		CALL	D10DISP
		RET
MAIN	ENDP
;				������ ������ ������ � ������ (��������):
;				--------------------------------------------
B10MEM	PROC	NEAR
		INT		12H			; ������ ������ (��) � AX
		MOV		DX,AX
		MOV		CL,10
		SHL		AX,CL
		SUB		CL,16
		NEG		CL
		SHR		DX,CL		; ������ ������ (�) � DX:AX
		MOV		MEMBIN,AX	; ���������� ����������
		MOV		MEMBIN+2,DX
		RET
B10MEM	ENDP
;				������� � ASCII-������ [1]:
;				--------------------------------------------
C10ASC	PROC	NEAR
		LEA		DI,MEMASC
		MOV		CX,1
		MOV		BX,10
		CMP		DX,BX		; ���������� �� ���� �������?
		JB		C50			; ���� ����, �� �������.

				;���������� ��������:
		INC		CX
		MOV		AX,BX
C40:	MUL		BX
		CMP		MEMBIN+2,AX
		JAE		C40
		MOV		BX,AX		; ���������� ��������

				;��������������� �������
		MOV		AX,MEMBIN
		MOV		DX,MEMBIN+2
		DIV		BX
		MOV		SI,AX		; ���������� ��������
		MOV		AX,DX		; ������� - � �������
		SUB		DX,DX
		MOV		BX,10

				;������ ���� � ASCII-������:
C50:	DIV		BX
		OR		DL,30H
		MOV		[DI+7],DL
		SUB		DL,DL
		DEC		DI
		CMP		AX,0
		JNE		C50
		MOV		AX,SI
		LOOP	C50
		
		RET
C10ASC	ENDP
;				����� ����������:
;				--------------------------------------------
D10DISP	PROC	NEAR
				
				;������ �������� ��������� ������� � DX:		
		MOV		AH,03
		MOV		BH,00
		INT		10H

		MOV		CX,01		; ����� ���������� (�����)
		LEA		SI,MESSG1
		MOV		BL,27		; �������
		
D20:	MOV		AH,02		; ������ �� ��������� �������
		INT		10H			; �������� ���������� � BIOS
		MOV		AH,0AH		; ������ ������ �������
		MOV		AL,[SI]		; ��������� ������
		INT		10H			; �������� ���������� � BIOS
		INC		SI
		INC		DL			; ��������� �������

D30:	DEC		BL
		JNZ		D20

		SUB		DL,DL
		INC		DH
		MOV		AH,02		; ������ �� ��������� �������
		INT		10H			; �������� ���������� � BIOS
		RET
D10DISP	ENDP
CODESG	ENDS
		END		BEGIN
;[1]	12 345/10 = 1 234 ���. 5
;		12 345/100 = 123 ���. 45