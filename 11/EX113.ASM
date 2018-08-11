		page	60,132
		TITLE	EX113 (EXE) ��������� ��������
;----------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;----------------------------------------------
DATASG	SEGMENT	PARA 'Data'
CONAME	DB		'SPACE EXPLORERS INC.'
PRLINE	DB		20 DUP(' ')
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
		CALL	A10MVSR			; �) ��������� ����� �������
		CALL	G10CLN
		CALL	B10MVSL			; �) ��������� ������ ������
		CALL	C10LODS			; �) �������� 3 � 4 ������ � AX
		CALL	D10STOS			; �) ���������� ����������� AX � ������
		CALL	E10CMPS			; �) ��������� CONAME � PRLINE
		CALL	F10SCAS			; e) ����� �������
		RET
BEGIN   ENDP
;				�) ��������� ������ ����� �������:
;				-------------------------------
A10MVSR	PROC	NEAR
		CLD						; ����������� ���������
		LEA		SI,CONAME		; ��������
		LEA		DI,PRLINE		; ����������
		MOV		CX,10			; ��������� 10 ������
		REP MOVSW
        RET
A10MVSR	ENDP
;				�) ��������� ������ ������ ������:
;				-------------------------------
B10MVSL	PROC	NEAR
		STD						; ����������� ���������
		LEA		SI,CONAME+18	; ��������
		LEA		DI,PRLINE+18	; ����������
		MOV		CX,10			; ��������� 10 ������
		REP MOVSW
        RET
B10MVSL	ENDP
;				�) �������� � AX:
;				-------------------------------
C10LODS	PROC	NEAR
		CLD						; ����������� ���������
		LEA		SI,CONAME+2		; �������� (3 � 4 �����)
		LODSW					; ��������� ����� � AX
        RET
C10LODS	ENDP
;				�) ���������� ����������� AX � ������:
;				-------------------------------
D10STOS	PROC	NEAR
		CLD					; ����������� ���������
		LEA		DI,PRLINE+5	; ����������
		STOSW				; AX ��� �������� ������������
		RET					;  �������
D10STOS	ENDP
;				�) ��������� CONAME � PRLINE �� ������������:
;				-------------------------------
E10CMPS	PROC	NEAR
		CLD					; �����������
		MOV		CX,20
		LEA		SI,CONAME	; ��������
		LEA		DI,PRLINE	; ����������
		REPE CMPSB			; ��������� [SI] � [DI]
		RET
E10CMPS	ENDP
;				e) ����� �������:
;				-------------------------------
F10SCAS	PROC	NEAR
		CLD					; �����������
		MOV		CX,20
		LEA		DI,CONAME	; ����������
		MOV		AL,20H		; ����� ������� �� [DI]
		REPNE SCASB			; ��������� AX � [DI]
		JNE		H20			; �� �����?
		MOV		BH,AL
H20:	RET
F10SCAS	ENDP
;				�������:
;				-------------------------------
G10CLN	PROC	NEAR
		CLD						; ����������� ���������
		LEA		DI,PRLINE		; ����������
		MOV		CX,10
		MOV		AX,2020H		; ��������� �������
		REP STOSW
        RET
G10CLN	ENDP
CODESG  ENDS
		END BEGIN