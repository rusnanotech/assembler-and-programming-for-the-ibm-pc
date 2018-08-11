		page	60,132
		TITLE	P123 (EXE) �������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
DATAX	DW		0148H
		DW		2316H
DATAY	DW		0237H
		DW		5052H
CYCLE	DB		5
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
		CALL	B10SUM		; 12.1 ��������
		CALL	C10SUM		; 12.2 �������� � ��७�ᮬ
		CALL	E10MUL		; 12.3 ���������
		CALL	F10DIV		; 12.5 �������
		CALL	E10SHR		; 12.6 ����� ॣ���஢�� ����
		RET
BEGIN	ENDP
;				12.1 ��������:
;				-------------------------------
B10SUM	PROC	NEAR
		MOV		AX,DATAX	; �) 2-� ᫮�
		ADD		AX,DATAY
		SUB		DX,DX		; �) 2-� ��.᫮�
		MOV		AX,DATAX+2	;	᫮����� ��. ᫮�
		ADD		AX,DATAY+2
		ADC		DX,DATAX	;	᫮���� ��. ᫮�
		ADD		DX,DATAY
		RET
B10SUM	ENDP
;				12.2 �������� � ��७�ᮬ:
;				-------------------------------
C10SUM	PROC	NEAR
		STC					; ��⠭����� 1 � CF
		MOV		BX,DATAX
		ADC		BX,DATAY
		RET
C10SUM	ENDP
;				12.3 ���������:
;				-------------------------------
E10MUL	PROC	NEAR
		MOV		AX,DATAX	; �) 2-� ᫮�
		MUL		DATAY
		MOV		AX,DATAX	; �) ��.᫮�� �� ᫮��:
		MUL		DATAY		;	㬭������ ��.᫮��
		MOV		BX,AX		;	��࠭���� �ந����.
		MOV		CX,DX
		MOV		AX,DATAX+2
		MUL		DATAY		;	㬭������ ��.᫮��
		ADD		DX,BX
		ADC		CX,00		;	�ந����. � CX:DX:AX
		RET
E10MUL	ENDP
;				12.5 �������:
;				-------------------------------
F10DIV	PROC	NEAR
		MOV		AX,DATAX	; �) ᫮�� �� ����
		MOV		BL,23
		DIV		BL
		MOV		AX,DATAX+2	; �) ��.᫮�� �� ᫮��
		MOV		DX,DATAX
		DIV		DATAY
		RET
F10DIV	ENDP
;				12.6 ����� ॣ���஢�� ����:
;				-------------------------------
E10SHR	PROC	NEAR
		MOV		CL,CYCLE
		MOV		AX,DATAX+2
		MOV		DX,DATAX
		SHR		AX,CL
		MOV		BX,DX
		SHR		DX,CL		; = 0AH
		SUB		CL,16
		NEG		CL
		SHL		BX,CL		; = 4000H
		OR		AX,BX
		RET
E10SHR	ENDP
CODESG  ENDS
		END BEGIN