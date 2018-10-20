		page	60,132
		TITLE	P123 (EXE) ��������� ������� ����
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
MULTCND	DW		0F010H		; ������ ����� ���������
		DW		559CH		; ������� ����� ���������
MULTPLR	DW		27EEH		; ���������
		DW		7FA8H
PRODUCT	DW		0
		DW		0
		DW		0
		DW		0
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
		CALL	E10XMUL			; 1-� ���������
		CALL	Z10ZERO			; �������� ������������
		CALL	F10XMUL			; 2-� ���������
		RET
BEGIN	ENDP
;				��������� ��.����� �� �����:
;				-------------------------------


E10XMUL	PROC	NEAR
		MOV		AX,MULTCND		; ��������� ������� �����
		MUL		MULTPLR+2
		MOV		PRODUCT,AX
		MOV		PRODUCT+2,DX
		MOV		AX,MULTCND+2	; ��������� �������� �����
		MUL		MULTPLR+2
		ADD		PRODUCT+2,AX
		ADC		PRODUCT+4,DX
		RET
E10XMUL	ENDP
;				��������� ���� ������� ����:
;				-------------------------------
;	x1x0*y1y0 = p0*x0*y0 + p1*x0*y1 + p1*x1*y0 + p2*x1*y1
;				z1z0		z2z1		z2z1		z3z2

;					+6	+4	+2	+0
;					--------------
;	+ p0*x0*y0				z1	z0
;	+ p1*x0*y1			z2*	z1
;	+ p1*x1*y0			z2*	z1
;	+ p2*x1*y1		z3*	z2				(*) - �������
F10XMUL	PROC	NEAR
		MOV		AX,MULTCND		; p0*x0*y0
		MUL		MULTPLR+0
		MOV		PRODUCT+0,AX
		MOV		PRODUCT+2,DX
		MOV		AX,MULTCND		; p1*x0*y1
		MUL		MULTPLR+2
		ADD		PRODUCT+2,AX
		ADC		PRODUCT+4,DX		
		MOV		AX,MULTCND+2	; p1*x1*y0
		MUL		MULTPLR+0
		ADD		PRODUCT+2,AX
		ADC		PRODUCT+4,DX
		ADC		PRODUCT+6,00
		MOV		AX,MULTCND+2	; p2*x1*y1
		MUL		MULTPLR+2
		ADD		PRODUCT+4,AX
		ADC		PRODUCT+6,DX		
		RET
F10XMUL	ENDP
;				������� ����������:
;				-------------------------------
Z10ZERO	PROC	NEAR
		LEA		DI,PRODUCT
		SUB		AX,AX
		MOV		CX,4
		REP STOSW
		RET
Z10ZERO	ENDP
CODESG  ENDS
		END BEGIN