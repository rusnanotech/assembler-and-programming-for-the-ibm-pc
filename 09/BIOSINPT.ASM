		page	60,132
		TITLE	NMSCROLL (EXE) ��������, �������, ���������
;-------------------------------------------------------
STACKSG SEGMENT	PARA STACK 'Stack'
	    DW		32 DUP(?)
STACKSG ENDS
;-------------------------------------------------------
DATASG	SEGMENT	PARA 'Data'
INPTNM	DB		20 DUP (' ')
LNM		DB		?

DATASG	ENDS
;-------------------------------------------------------
CODESG  SEGMENT PARA 'Code'
BEGIN   PROC    FAR
		ASSUME  CS:CODESG,DS:DATASG,SS:STACKSG,ES:DATASG
        PUSH    DS
		SUB     AX,AX
        PUSH    AX
		MOV		AX,DATASG
		MOV		DS,AX
		MOV		ES,AX
		CALL	INPT10
		RET
BEGIN	ENDP
;-------------------------------------------------------
;		���������� ������:
INPT10	PROC	NEAR
		MOV		AH,08		; ������ �� ������ ��������/�������
		MOV		BH,00		; ����� 0 (��������)
		INT		10H			; �������� ���������� � BIOS
		RET
INPT10	ENDP
;-------------------------------------------------------
CODESG  ENDS
		END BEGIN