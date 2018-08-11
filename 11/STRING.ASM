		page	60,132
		TITLE	STRING (EXE) ��������� ��������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
NAME1	DB		'Assemblers'
NAME2	DB		10 DUP(' ')
NAME3	DB		10 DUP(' ')
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
		CALL	C10MVSB
		CALL	D10MVSW
		CALL	E10LODS
		CALL	F10STOS
		CALL	G10CMPS
		CALL	H10SCAS
		RET
BEGIN   ENDP
;				MOVSB:
;				-------------------------------
C10MVSB	PROC	NEAR
		CLD					; ����������� ���������
		LEA		SI,NAME1	; ��������
		LEA		DI,NAME2	; ����������
		MOV		CX,10		; ��������� 10 ������
		REP MOVSB
        RET
C10MVSB	ENDP
;				MOVSW:
;				-------------------------------
D10MVSW	PROC	NEAR
		CLD					; ����������� ���������
		LEA		SI,NAME2	; ��������
		LEA		DI,NAME3	; ����������
		MOV		CX,05		; ��������� 10 ������
		REP MOVSW
        RET
D10MVSW	ENDP
;				LODSW:
;				-------------------------------
E10LODS	PROC	NEAR
		CLD					; ����������� ���������
		LEA		SI,NAME1	; ��������
		LODSW				; ��������� 1-� ����� � AX
        RET
E10LODS	ENDP
;				STOSW:
;				-------------------------------
F10STOS	PROC	NEAR
		CLD					; ����������� ���������
		LEA		DI,NAME3	; ����������
		MOV		CX,05
		MOV		AX,2020H	; ��������� �������
		REP STOSW
        RET
F10STOS	ENDP
;				CMPSB:
;				-------------------------------
G10CMPS	PROC	NEAR
		CLD					; �����������
		MOV		CX,10
		LEA		SI,NAME1	; ��������
		LEA		DI,NAME2	; ����������
		REPE CMPSB			; ��������� [SI] � [DI]
		JNE		G20			; �� �����?
		MOV		BH,01
G20:	MOV		CX,10
		LEA		SI,NAME2	; ��������
		LEA		DI,NAME3	; ����������
		REPE CMPSB			; ��������� [SI] � [DI]
		JE		G30			; �� �����?
        MOV		BL,02
G30:	RET
G10CMPS	ENDP
;				SCASB:
;				-------------------------------
H10SCAS	PROC	NEAR
		CLD					; �����������
		MOV		CX,10
		LEA		DI,NAME1	; ����������
		MOV		AL,'m'		; ����� ������� �� [DI]
		REPNE SCASB			; ��������� AL � [DI]
		JNE		H20			; �� �����?
		MOV		AH,03
H20:	RET
H10SCAS	ENDP
CODESG  ENDS
		END BEGIN