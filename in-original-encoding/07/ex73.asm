		page	60,132
		TITLE	EX73 (EXE) ;����� ���������
;-------------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
        DW		32 DUP(?)
STACKSG ENDS
;-------------------------------------------------
DATASG	SEGMENT	PARA 'Data'
X0		DW		0000H		;�������� ������	X0=0
X1		DW		0001H		;					X1=1
XN		DW		11 DUP(?)	;����������
DATASG	ENDS
;-------------------------------------------------
CODESG  SEGMENT PARA 'Code'
BEGIN   PROC    FAR
        ASSUME  CS:CODESG,DS:DATASG,SS:STACKSG,ES:DATASG
        PUSH    DS
        SUB     AX,AX
        PUSH    AX
		MOV		AX,DATASG
		MOV		DS,AX
		MOV		ES,AX
		CALL	B10
		RET
BEGIN   ENDP
;-------------------------------------------------
B10		PROC
		MOV		AX,X0	;�������� �������� ������
		MOV		DX,X1
		LEA		BX,XN	;������� ������ ��� �������� ����������� �������
		MOV		CX,6	;������� 6 ������ (�� ��� ���������� �� ����)
						;			AX		DX
B20:					;			X0=0	X1=1
		ADD AX,DX		;X2=X0+X1	X2=1	X1=1
		MOV	[BX],AX		;��������� � ������ ���������
		INC BX			;��������� ������
		INC BX			;��������� ������
		ADD DX,AX		;X3=X1+X2	X2=1	X3=2
		MOV [BX],DX		;��������� � ������ ���������
		INC BX			;��������� ������
		INC BX			;��������� ������
		LOOP B20		;��������� B20
        RET
B10		ENDP
;-------------------------------------------------
CODESG  ENDS
        END BEGIN