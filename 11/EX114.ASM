		page	60,132
		TITLE	STRING (EXE) ��������� ��������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
NAME1	DB		'Assemblers'
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
		CALL	A10SCAS		; �) ������ 1
		CALL	B10SCAS		; �) ������ 2
		RET
BEGIN	ENDP
;				�) ������ 1:
;				-------------------------------
A10SCAS	PROC	NEAR
		CLD					; �����������
		MOV		CX,5
		LEA		DI,NAME1	; ����������
		MOV		AX,'re'		; ����� ����� �� [DI]
		REPNE SCASW			; ��������� AX � [DI]
		MOV		CX,4
		LEA		DI,NAME1+1	; ����������
		REPNE SCASW			; ��������� AX � [DI]
		RET
A10SCAS	ENDP
;				�) ������ 2:
;				-------------------------------
B10SCAS	PROC	NEAR
		CLD					; �����������
		MOV		CX,10
		LEA		DI,NAME1	; ����������
B20:	MOV		AL,'e'		; ����� ����� �� [DI]
		REPNE SCASB			; ��������� AL � [DI]
		MOV		AL,'r'
		SCASB				; ��������� AL � [DI]
		JNZ		B20
		RET
B10SCAS	ENDP
CODESG  ENDS
		END BEGIN