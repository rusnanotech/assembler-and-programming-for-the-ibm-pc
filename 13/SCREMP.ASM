		TITLE	SCREMP (EXE) ���� ������� � ��������,
;								����� �������� ������
;-----------------------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;-----------------------------------------------------------
DATASG	SEGMENT	PARA 'Data'
HRSPAR	LABEL	BYTE			; ������ ����������
MAXHLEN	DB		6				;	��� ����� �������
ACTHLEN	DB		?				;---------------------------
HRSFLD	DB		6 DUP(?)

RATEPAR	LABEL	BYTE			; ������ ����������
MAXRLEN	DB		6				;	��� ����� ��������
ACTRLEN	DB		?				;---------------------------
RATEFLD	DB		6 DUP(?)

MESSG1	DB		'Hours worked? ','$'
MESSG2	DB		'Rate of pay? ','$'
MESSG3	DB		'Wage = '
ASCWAGE	DB		10 DUP(30H), 13, 10, '$'
ADJUST	DW		?				; ����. ��������. 5*10^(P-3)
ASCHRS	DB		0
ASCRATE	DB		0
BINVAL	DW		00
BINHRS	DW		00
BINRATE	DW		00
COL		DB		00
DECIND	DB		00				; ������� ���������	P
MULT10	DW		01				; ��������� �������
NODEC	DW		00				; ���������� ��. ����� ','
ROW		DB		00
SHIFT	DW		?				; ������� ������. 10^(P-2)
TENWD	DW		10
DATASG	ENDS
;-----------------------------------------------------------
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
		CALL	Q10SCR			; �������� �����
		CALL	Q20CURS			; ���������� ������
A20LOOP:
		CALL	B10INPT			; ������ ����� � ��������
		CMP		ACTHLEN,00
		JE		A30
		CALL	D10HOUR			; �������� �������� �����
		CALL	E10RATE			; �������� ��. ��������
		CALL	F10MULT			; ���������� ������
		CALL	G10WAGE			; ������������� � ASCII
		CALL	K10DISP			; ������ ���������
		JMP		A20LOOP
A30:	
		MOV		AX,0600H
		CALL	Q10SCR			; �������� �����
		RET						; ����� �� ���������
BEGIN	ENDP
;				���� ������� � ��������:
;				--------------------------------------------
B10INPT	PROC	NEAR
		LEA		DX,MESSG1		; ������ ����� �������
		MOV		AH,09
		INT		21H
		LEA		DX,HRSPAR		; ������ �����
		MOV		AH,0AH
		INT		21H
		CMP		ACTHLEN,00
		JNE		B20
		RET
B20:
		MOV		COL,25			; ���������� �������
		CALL	Q20CURS
		LEA		DX,MESSG2		; ������ ����� ��������
		MOV		AH,09
		INT		21H
		LEA		DX,RATEPAR		; ������ ��������
		MOV		AH,0AH
		INT		21H
		RET
B10INPT	ENDP
;				��������� �������:
;				--------------------------------------------
D10HOUR	PROC	NEAR
		MOV		NODEC,00
		MOV		CL,ACTHLEN
		SUB		CH,CH
		LEA		SI,HRSFLD-1		; ���������� ������ �������
		ADD		SI,CX			;	�������
		CALL	M10ASBI			; ������������� � ��������
		MOV		AX,BINVAL
		MOV		BINHRS,AX
		RET
D10HOUR	ENDP
;				��������� �������� [1]:
;				--------------------------------------------
E10RATE	PROC	NEAR
		MOV		CL,ACTRLEN
		SUB		CH,CH
		LEA		SI,RATEFLD-1	; ���������� ������ �������
		ADD		SI,CX			;	��������
		CALL	M10ASBI			; ������������� � ��������
		MOV		AX,BINVAL
		MOV		BINRATE,AX
		RET
E10RATE	ENDP
;				���������, ���������� � �����:
;				--------------------------------------------
F10MULT	PROC	NEAR
		MOV		CX,05
		LEA		DI,ASCWAGE	; ���������� ������ ������
		MOV		AX,3030H	;	� ��� ASCII (30H)
		CLD					;	����������� - ����� �� �����
		REP STOSW

		MOV		SHIFT,10
		MOV		ADJUST,00
		MOV		CX,NODEC	; ����. ���-�� ��. ����� �����.
		CMP		CL,06		; ���� ��. ����� 6 ���.,
		JA		F40			;	�� ������
		DEC		CX			; �������� ���-�� �������������
		DEC		CX			;	������ ����� �������
		JLE		F30			; ������ ��� <= 2 �����
		MOV		NODEC,02	; �����. ����� ���-�� ����. ��.
		MOV		AX,01		; ��������� � ���������
F20:	MUL		TENWD		;	������� ����������
		LOOP	F20
		MOV		SHIFT,AX
		SHR		AX,1		; ��������� � ���������
		MOV		ADJUST,AX	;	��������� ����������
F30:
		MOV		AX,BINHRS
		MUL		BINRATE		; ��������� ������
		ADD		AX,ADJUST	; ��������� ����. ������.
		ADC		DX,00
		CMP		DX,SHIFT	; ��������� �� ������� �����
		JB		F50			;	��� ������� DIV?
F40:	
		SUB		AX,AX
		JMP		F70
F50:	
		CMP		ADJUST,00	; ���������� �� ���������?
		JZ		F80
		DIV		SHIFT		; ��������� ������
F70:	SUB		DX,DX		; �������� �������, �����. � AX
F80:	RET
F10MULT	ENDP
;				�������������� � ASCII-������:
;				--------------------------------------------
G10WAGE	PROC	NEAR
		LEA		SI,ASCWAGE+7		; �����. ���. �����.
		MOV		BYTE PTR[SI],','
		ADD		SI,NODEC			; �����. ����. �����.
G30:	
		CMP		BYTE PTR[SI],','
		JNE		G35					; ������, ���� �� ','
		DEC		SI
G35:	
		CMP		DX,00				; ���� DX:AX < 10,
		JNZ		G40					;	�� ���������
		CMP		AX,0010				;	����� �������
		JB		G50					;	������
G40:	
		DIV		TENWD				; ������� � DX - �����
		OR		DL,30H
		MOV		[SI],DL				; �������� ASCII-������
		DEC		SI
		SUB		DX,DX				; ������� �������
		JMP		G30
G50:	
		OR		AL,30H				; �������� ������.
		MOV		[SI],AL				;	ASCII-������
		RET
G10WAGE	ENDP
;				����� �������� ������:
;				--------------------------------------------
K10DISP	PROC	NEAR
		MOV		COL,50				; ���������� �������
		CALL	Q20CURS
		MOV		CX,09
		LEA		SI,ASCWAGE
K20:
		CMP		BYTE PTR[SI],30H	; ������� ���� ���������
		JNE		K30
		MOV		BYTE PTR[SI],20H
		INC		SI
		LOOP	K20
K30:	
		LEA		DX,MESSG3			; ����� �� �����
		MOV		AH,09
		INT		21H
		CMP		ROW,20				; ��������� ������?
		JAE		K80
		INC		ROW					; ��� - ���������
		JMP		K90
K80:
		MOV		AX,0601H
		CALL	Q10SCR
		MOV		COL,00
		CALL	Q20CURS
K90:	RET
K10DISP	ENDP
;				�������������� ����� �� ASCII � ��������[2]:
;				--------------------------------------------
M10ASBI	PROC	NEAR
		MOV		MULT10,0001	; �������� ��������� �������
		MOV		BINVAL,00	; �������� �������� ����
		MOV		DECIND,00	; �������� �������. ���������
		SUB		BX,BX		; �������� ������� ��. �� ','
M20:			; �������� ������� � �������� �� �������
		MOV		AL,[SI]		; ��������� ASCII-������
		CMP		AL,','
		JNE		M40			; ���� ',' - ����������
		MOV		DECIND,01	; 	���������� ��������� � 1
		JMP		M90
M40:			; ������� ������� � �������� ��������
		AND		AX,000FH	; �������� AH � ������ 3 
		MUL		MULT10		; �������� �� �������
		ADD		BINVAL,AX	; ������� � ��.���������
		MOV		AX,MULT10	; ��������� ���������
		MUL		TENWD		;	������� *10
		MOV		MULT10,AX
		CMP		DECIND,00	; ���� �� ���������� �������?
		JNZ		M90			; ���� ���, ���������
		INC		BX			;	������� ������ �� �������
M90:	
		DEC		SI			; ������. ����� ����. �������
		LOOP	M20
							; ����� �����
		CMP		DECIND,00	; ���� ���.�������?
		JZ		M100		;	�� - ��������� ��������
		ADD		NODEC,BX	;	�������� ��. �� �������
M100:	RET
M10ASBI	ENDP
;				��������� ������:
;				--------------------------------------------
Q10SCR	PROC	NEAR
		MOV		BH,30
		SUB		CX,CX
		MOV		DX,184FH
		INT		10H
		RET
Q10SCR	ENDP
;				��������� �������:
;				--------------------------------------------
Q20CURS	PROC	NEAR
		MOV		AH,02		; ������ ���������
		SUB		BH,BH
		MOV		DH,ROW
		MOV		DL,COL
		INT		10H
		RET
Q20CURS	ENDP
CODESG  ENDS
		END BEGIN
; [1]	�� ���� ��� ���� NODEC �� ����������, ��� ��� � ���
;		�������� ����� ���������� ���-�� ������ �������
;		��������� - ��������. � ����� ���� ���������
;		NODEC - ���-�� ������ ����� ���. � ������������.
; [2]	���� ��������� ����� �� �������, �� � �����
;		���������� ���������� BX �� 1.